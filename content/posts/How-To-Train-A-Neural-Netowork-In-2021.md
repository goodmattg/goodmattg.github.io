+++
Title = "Deep Learning in 2021"
date = 2021-09-07
description = "Deep Learning in 2021"
categories = ["Deep Learning", "Neural Network", "DL", "AI", "GPU", "AIInfra"]
comments = true
+++

{{< centered >}}
# Deep Learning in 2021
<hr>
<br>
{{</ centered>}}

This post is going to cover the state of deep learning in 2021. If you're coming from a university classroom, get ready for an exhausting amount of detail. The classic pattern of "just feed some data through the network and backpropogate" is still the truth, but only covers ~2% of the labor to get anything useful. 

# Table of Contents
1. Theory
2. Requirements
## Language: Python

The lingua franca of modern DL is Python. All the major research codebases are in Python, the major DL frameworks all have Python bindings, and the vast majority of tooling is written for Python users. I don't know of any big league research organizations that use anything other than Python.

2. CPU Training on Machine

This is the "Hello World" of DL, but we'll explore this scenario in some detail so we can reference it in later sections. 

3. GPU Training on Machine
4. Multi-GPU Training on Machine
5. Multi-GPU Single Node Training Cloud
6. Multi-GPU, Multi-Node Training Cloud

Truly large-scale models are trained in the multi-gpu, multi-node setting. Examples include GPT-3, DeepMind's DOTA model, and Google's DL driven recommendation algorithms. Recall that a 'node' is typically a physical machine with 8 GPU's. When practitioners say a model was trained on 1024 GPU's, that precisely means the model was trained on 1024 / 8 = 128 physical nodes, each with 8 GPU's. 

Let's take a moment to think of the broad challenges here before getting into specifics. We're now training a model across 128 separate physical machines. This introduces problems related to communication, i.e. that the physical nodes will have to communicate with each other over some network, and problems of 

6a. Distributed Training Frameworks
a. MPI
b. DDP (NCCL)
c. Horovod 
https://github.com/horovod/horovod
d. BytePS


7. Cloud Workflows for Deep Learning
8. Deep Learning Frameworks
9. Higher Level Frameworks 
Keras, Ignite, Lightning
9. Data Ingestion Patterns
