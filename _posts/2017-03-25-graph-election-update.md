---

layout: post
title: "Update: Graph-based Model Election Forecasting"
categories: research GSP polling forecasting
---

While I am no longer directly working on the project, I am still an informal advisor to the undergraduates currently working to improve the model. The challenge we currently face is quite intriguing. We have the data: presidential election, senatorial election, median income, demographics, poverty, etc. The new issue is how we combine the graph shift operators from each of these data sets to produce an optimal graph shift operator (that results in minimum norm-1 error).

Let’s first use intuition. Our goal is to predict presidential elections, so we can reason that the presidential election graph shift operator should receive the most weight. The question becomes exactly how much weight should this receive? And of course how do we distribute the remaining weight?

We have a solution in:

> Egilmez, H. E., Ortega, A., Guleryuz, O. G., Ehmann, J., & Yea, S. (2016). "An Optimization Framework for Combining Multiple Graphs" Signal & Image Processing Institute , University of Southern California , Los Angeles , CA , USA, (ii), 4114–4118.

To summarize the paper - we have a framework to combine independent graph shift operators to produce an optimal graph shift operator. This is fantastic, except the runtime is frankly garbage. After contacting the authors to get a missing piece of code, our undergraduate implemented the algorithm. Did it work? We don’t know! Running to find the optimal combination of 7 different 3111x3111 graph the algorithm would take ~70 days. This is likely an exaggeration. I read through the paper and the runtime appears to be O(N^4). If we take advantage of MATLAB’s matrix operations we can get this down to O(N^3). At this point all optimizations we make don’t reduce the order of the runtime, just the absolute duration. I am confident we could reimplement the algorithm using MATLAB’s built in parallel processing framework and then run on a computing cluster for a total computing time of 1 day max. I am excited to see how far below the 5% norm-1 error we go with an optimal graph shift operator.

The question beyond this is time-frame weighting within individual datasets (prioritizing more recent data), but one thing at a time.
