---
layout: post
title: Dynamic Time Warping for Clustering Time Series Data
---

This post is as much a meditation on using Dynamic Time Warping (DTW) in production as it is a review of my work. I have so many questions about this subject. If you have any answers, I hope you will reach out.

## Motivation

This was for the Wikipedia competition hosted by Kaggle competition to predict future page view counts on Wikipedia. Like so many of the solutions now the winning approach used RNNs to learn a set of hyperparameters on the entire dataset that are then fed in to a predict locally on each time series. This begs comparison to multivel hierarchical models from a Bayesian perspective, but I'll save that for a later post. I treat these competitions as a way to explore new classes of techniques more than as competition to win. And it's from that perspective that I settled on Dynamic Time Warping as the technique I wanted to explore. The big question I had was:

> Instead of learning hyperparameters on our entire corpus of time series, wouldn't it be great if we could find a way to sub divide our corpus into highly **similar** groups, and then learn hyperparameters on those groups?

In the context of the [winning solution][1] this would clustering layer would sit a layer above the RNN. In the language of hierarchical multilevel models, this would adding another level to the model that where we then compute posterior distributions on the hyperparameters for each group, with additional hyperparameters for the entire population. This yielded the question of how to cluster time series data - and the best answer on offer was Dynamic Time Warping.

** FIGURE SHOWING THE MULTIVEL MODEL AND THE GROUP LAYER SITTING ABOVE AN RNN BOX **

## Literature Review: DTW

This review is informal but should provide sufficient grounding.

## Theory: DTW

** MATLAB plot of 3d path through two signals - would look great **

## DTW Nearest-Neigbhor Clustering



[1]: https://www.kaggle.com/c/web-traffic-time-series-forecasting/discussion/43795
