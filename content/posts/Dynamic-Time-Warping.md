+++
title = "Dynamic Time Warping for Clustering Time Series Data"
date = 2017-12-10
description = "This post is as much a meditation on using Dynamic Time Warping (DTW) in production as it is a review of my work. I have so many questions about this subject. If you have any answers, I hope you will reach out."
categories = ["DTW", "ML", "Kaggle"]
comments = true
+++

<hr>

## Motivation

This was for the Wikipedia competition hosted by Kaggle competition to predict future page view counts on Wikipedia. Like so many of the solutions now the winning approach used RNNs to learn a set of hyperparameters on the entire dataset that are then fed in to a predict locally on each time series. This begs comparison to multivel hierarchical models from a Bayesian perspective, but I'll save that for a later post. I treat these competitions as a way to explore new classes of techniques more than as competition to win. And it's from that perspective that I settled on Dynamic Time Warping as the technique I wanted to explore. The big question I had was:

> Instead of learning hyperparameters on our entire corpus of time series, wouldn't it be great if we could find a way to sub divide our corpus into highly **similar** groups, and then learn hyperparameters on those groups?

In the context of the [winning solution][^1] this clustering layer would sit a layer above the RNN. In the language of hierarchical multilevel models, this would adding another level to the model that where we then compute posterior distributions on the hyperparameters for each group, with additional hyperparameters for the entire population. This yielded the question of how to cluster time series data.
I looked to the research and settled on Dynamic Time Warping (DTW) from Keogh et. al from UC Riverside. For any pair of time series signals, we can find the energy of the signal that minimizes the distance between two input signals. DTW can easily show that time warped signals are the same. This technique has been highly effective in classifying EEG and other time-varying signals. As


## Literature Review: DTW

This review is informal but should provide sufficient grounding. Most of the important work has been done by Keogh

1. Rakthanmanon, T., Campana, B., Mueen, A., Batista, G., Westover, B., Zhu, Q., … Keogh, E. (n.d.). Searching and Mining Trillions of Time Series Subsequences under Dynamic Time Warping.

2. Mueen, A., & Keogh, E. (2016). Extracting Optimal Performance from Dynamic Time Warping, 2129–2130.

3. Lemire, D. (2009). Faster retrieval with a two-pass dynamic-time-warping lower bound, 42, 2169–2180. http://doi.org/10.1016/j.patcog.2008.11.030

4. Keogh, E. (n.d.). Clustering of Time Series Subsequences is Meaningless : Implications for Previous and Future Research.

5. H. Sakoe and S. Chiba, “Dynamic programming algorithm optimization for spoken word recognition,” IEEE Trans. Acoust. Speech, Lang. Process., vol. 26, no. 1, pp. 43–50, 1978.

6. MuÌller, Meinard. Information Retrieval for Music and Motion. Springer, 2010.

## Theory: DTW

For an excellent review of the computational aspects of DTW I recommend "Abdullah Mueen, Eamonn J. Keogh: Extracting Optimal Performance from Dynamic Time Warping. KDD 2016: 2129-2130". Refer to Meinard for a solid review of DTW theory.

Dynamic Time Warping is a path-searching algorithm. DTW finds the minimum cost path between the complete matrix of pairwise distances between two time-series we will label $X$ and $Y$. Define $X := (x_1, x_2, ..., x_n)$ and $Y:=(y_1, y_2,...,y_n)$. This matrix of pairwise distances is referred to as the *cost* matrix $C$. Define the function $c(x,y)$ as the cost or local distance function between two points $x$ and $y$. If $c(x,y)=0$, the two points are identical. Therefore, low cost implies similarity, high cost implies dissimilarity. DTW finds a path through the cost matrix of minimum total cost. Each valid path through the cost matrix is called a "warping" path. The set of all warping paths is labeled $W$.

This recursive function gives the minimum cost path:

$$\gamma(i,j)~=~d(q_i, c_j)+min\{\gamma(i-1,j-1), \gamma(i-1, j), \gamma(i, j-1)\}$$

![DTW Trace](/assets/posts/DTW/DTWTrace.jpg)
*Figure 1. DTW computed optimal path between sinusoid & sinusoid + sinc over $[0,6\pi]$*

## DTW Nearest-Neigbhor Clustering

The Wikipedia challenge provide 145,000 time-series to predict. Ideally, I would have computed pairwise DTW distances for all 145,000 pairs, and then run agglomerative clustering with Ward linkage to generate clusters. The computation wasn't feasible on my desktop setup, and I wasn't willing to go the AWS route for this exercise. Instead, I decided to randomly sample 10,000 rows, compute pairwise DTWs for the row sample, run hierarchical clustering on the pairwise distance matrix, and finally assign all non-sampled rows to the cluster matching of their nearest neighbor. Admittedly this was not the ideal solution. By assigning all non-sampled rows to the cluster containing their nearest neighbor (i.e. minimizing DTW distance), I likely unbalanced the clusters. Furthermore, nearest-neighbor clustering is meaningless with high-dimensionality inputs. I considered nearest-neighbor defensible because my dimensionality was unitary. That is, I only clustered on the DTW distance and so avoided have high-dimensionality inputs. I didn't compute any rough heuristics to quantify the distribution of non-sampled rows to clusters due to time constraints.

> "As noted by (Agrawal et al., 1993, Bradley and Fayyad, 1998), in high dimensions the very concept of nearest neighbor has little meaning, because the ratio of the distance to the nearest neighbor over the distance to the average neighbor rapidly approaches one as the dimensionality increases." [2]

I ending up doing a minor rewrite of Prof. Eamonn Keogh's UCR-DTW C++ tool to do nearest-neighbor search instead of sub-sequence search. The tool now searches a list of time-series to find the one that minimizes the DTW distance instead of sub-sequence search to find the sub-sequence that minimizes distance. Because of optimizations in the UCR-DTW tool (via research by Lemire, Kim, et. al) the tool only computes the full DTW in <10% of cases.

After clustering, about 80,000 rows belong to one cluster - so we could conceptualize that cluster as the base data set and run our standard model. I would be curious to train the winning solution on each of my clusters to see if that improved its performance. The smaller cluster had predictable features like single large spikes, uniformity, two spikes, clear seasonality, etc. Using different linkage whole and partial linkage patterns instead of ward only increased the size of the largest cluster. This indicates that there is no signicant distinction for the majority of the time series signals in the corpus.

## Code Appendix

```matlab

    %% Define original signal
    x = 0:pi/64:6*pi;
    y = 0.25*sin(x);

    %% Modify a section of the signal
    N = length(y);
    xind = (floor(0.40*N):floor(0.60*N));
    ymod = y;
    ymod(xind) = sinc(x(xind));

    %% Compute DTW
    zg = repmat(y, N, 1);
    zgmod = repmat(ymod', 1, N);
    d2 = sqrt((zg - zgmod) .^ 2);
    [~,ix,iy] = dtw(y, ymod);

    %% Plottingm
    [xg, yg] = meshgrid(1:N);
    d2(sub2ind(size(d2), iy, ix)) = 1.5*max(d2(:));
    mesh(xg, yg, d2)
```

[^1]: https://www.kaggle.com/c/web-traffic-time-series-forecasting/discussion/43795
