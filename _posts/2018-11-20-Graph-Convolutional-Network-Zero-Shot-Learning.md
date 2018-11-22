---
layout: post
title: Graph Convolutional Networks for Zero Shot Learning
comments: true
---

Are the state-of-the-art CNNs we are currently seeing actually learning anything, or are we just encoding exceedingly complex loss functions to solve good old fashioned convex optimization problems. 

Supervised models are not artificially intelligent agents - they are enormously powerful pattern recognizers. 

I understand the stigma in this community to cite Hofstader's GEB - but he raises what I believe is the key point in the colloquial way. Resnet-152 is powerful, but it never jumps the boundary of what it's currently doing. Some would argue humans only have so many levels of jumping the bounds that we can accomplish, and this leads to an intersting philosophical point, but it hardly looks like we're trying to build systems that jump any bounds. The heavy focus has been on the pattern recognition side of the AI puzzle because that's the side that is lower hanging fruit thanks to backprop and GPUs and also yields immediately apparent results. 



Resnet-50 is a poor approximation of a newborn child. We don't come into the world having a priori knowledge of all the classes of items we will ever see. There were times as children we saw things that we had never seen before, and  we not only had to categorize those things, but we had to adjust our mental map of what 'things' even were.

I'm thinking of a network structure where the model's a priori knowledge evolves over training time and can optionally reject training samples. So input is both labeled and unlabeled training data as well as a fully-connected knowledge graph. Assume any labeled training data is true (global actor is not lying to model agent). Any unlabeled data is forward propagated through NN. Look at distribution of output probabilities. True certainty of object class would tend towards delta above the object bucket. i.e. if model is looking at something it has seen before, or something that makes sense in the context of the knowledge graph, backprop the sample through the model. Optionally add a new weakly connected node to the knowledge graph if the distribution is uniform (model has no clue what it's looking at). Would require some update function for the knowledge graph. First and foremost - paper request? If anyone knows the name of this, please put paper citations in the comments. 