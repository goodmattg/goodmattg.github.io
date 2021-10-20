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

This post is going to cover the state of deep learning in 2021. If you're coming from a university classroom, get ready for an exhausting amount of detail. The classic pattern of "just feed some data through the network and backpropogate" is still the truth, but it takes ~5x more effort beyond the network to get anything useful.

# Table of Contents

{{< table_of_contents >}}

# Theory

TODO

# Requirements

## Language: Python

The lingua franca of modern DL is Python. All the major research codebases are in Python, the major DL frameworks all have Python bindings, and the vast majority of tooling is written for Python users. I don't know of any big league research organizations that use anything other than Python.

# CPU Training on Machine

This is the "Hello World" of DL, but we'll explore this scenario in some detail so we can reference it in later sections. Let's use the `torchvision` library from the PyTorch team to train a simple classifier on MNIST. 

```python

import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
import torchvision.transforms as transforms

from torch.utils.data import DataLoader
from torchvision.datasets import MNIST

transform = transforms.Compose([
                               transforms.ToTensor(),
                               transforms.Normalize(
                                 (0.1307,), (0.3081,))
                             ])

# NOTE: Dataset downloaded to local machine
trainset = MNIST(root='./data', train=True, download=True, transform=transform)
trainloader = DataLoader(trainset, batch_size=4, shuffle=True, num_workers=2)

class Net(nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        self.conv1 = nn.Conv2d(1, 10, kernel_size=5)
        self.conv2 = nn.Conv2d(10, 20, kernel_size=5)
        self.conv2_drop = nn.Dropout2d()
        self.fc1 = nn.Linear(320, 50)
        self.fc2 = nn.Linear(50, 10)

    def forward(self, x):
        x = F.relu(F.max_pool2d(self.conv1(x), 2))
        x = F.relu(F.max_pool2d(self.conv2_drop(self.conv2(x)), 2))
        x = x.view(-1, 320)
        x = F.relu(self.fc1(x))
        x = F.dropout(x, training=self.training)
        x = self.fc2(x)
        return F.log_softmax(x)

net = Net()

criterion = nn.CrossEntropyLoss()
optimizer = optim.SGD(net.parameters(), lr=0.001, momentum=0.9)

for epoch in range(2):
    running_loss = 0.0
    for i, data in enumerate(trainloader, 0):
        # NOTE: Data loaded from disk into RAM
        inputs, labels = data

        optimizer.zero_grad()

        # NOTE: CPU computes forward pass, backward pass, update weights
        outputs = net(inputs)
        loss = criterion(outputs, labels)
        loss.backward()
        optimizer.step()

        running_loss += loss.item()
        if i % 2000 == 1999:
            print('[%d, %5d] loss: %.3f' % (epoch + 1, i + 1, running_loss / 2000))
            running_loss = 0.0
```

Several things verify that our model works correctly:
1. There were no interpreter errors when we run the code (i.e. no crashes)
2. The loss decreases
3. The accuracy on the validation increases

This example is representative of how tutorials and most universities teach deep learning, but it is not useful in practice. Let's dig in on several of the assumptions that make this example so elegant. First, the MNIST dataset is __tiny__, only 9.9 MB,  and __static__. Why do we focus on this? Because in practice, the datasets we want to use to power insights or new features are __massive__ and __dynamic__ (constantly changing). It is easy in this example to download MNIST to our local device to train the model - it only takes a few seconds to make an HTTP request to the server with the tarball of the MNIST dataset and download the whole dataset. And once the dataset is in memory, the time cost of loading small batches of the dataset into our model on the CPU is __effectively optimal__. MNIST is just 28x28 pixel images - it takes almost no time to load a small batch of 28x28 images, and those images take up almost no RAM. You can't beat the speed of just loading data from disk onto CPUs without fancy I/O optimizations which we'll cover in a later section. If we were lazy and inefficient, we could always re-download the MNIST dataset from the server every time we trained the model and __it would still work__. We would only add a few seconds to each training run, and the amount of memory we consume is only 9.9 MB. 

Also observe that all of the operations in the function above 

The questions I will repeat over and over in the context of our examples:

1. What happens when the dataset cannot fit in memory? 
2. What happens if the dataset is changes over time?


# GPU Training on Machine

This example is the same scenario as "CPU Training on Machine", but we now have 1 GPU in addition to our CPUs.

![Single GPU](/assets/posts/DL2021/SingleGPU.svg)

![Local Globa rank](/assets/posts/DL2021/LocalGlobalRank.svg)

https://pytorch.org/docs/stable/data.html#torch.utils.data.DataLoader
https://pytorch.org/docs/stable/notes/multiprocessing.html#multiprocessing-cuda-note

# Distributed Deep Learning

It will be useful to understand the role of distributed communications in DL before digging in to multi-GPU training. The plain english explanation is when training a model on a large dataset with multiple gpu's, it speeds things up to _parallelize_ the model training by sending different chunks of the data to each GPU, have each GPU compute weight updates separately, and then add up those weight updates to produce one global weight update at each time step. The copy of the model on each GPU will have the same weights after each iteration of backpropagatation, but we've now consumed _# gpu's_ times the data in a single iteration. Throughout this process the GPU's need to be in constant communication, and so a distributed communications protocol is required.

## Message Passing Interface (MPI)

Message Passing Interface (MPI) surfaced out of a supercomputing computing community working group in the 1990's. From the MPI 4.0 specification[^1]: 

> MPI (Message-Passing Interface) is a message-passing library interface specification...
MPI addresses primarily the message-passing parallel programming model, in which data is moved from the address space of one process to
that of another process through cooperative operations on each process. Extensions to the
“classical” message-passing model are provided in collective operations, remote-memory
access operations, dynamic process creation, and parallel I/O

[^1]: https://www.mpi-forum.org/docs/mpi-4.0/mpi40-report.pdf

MPI specifies _primitives_ (i.e. building blocks) that can be used to compose complex distributed communications patterns. MPI specifies two main types of primitives:
1. _point-to-point_ : one process communicates with another process (1:1) 
2. _collective_ : group of processes communicates within the group (many:many)

These primitives are obviously useful for distributed deep learning. Each GPU process has weight gradients we need add up? Use the `all_reduce()` primitive. Each GPU process `P_i` comes up with a tensor `x_i` that needs to be shared to all other GPU processes? Use the `all_gather()` primitive, etc. Below is a helpful graphic directly from the MPI 4.0 standard to cement the concept.

![Multi GPU](/assets/posts/DL2021/MPICollectiveCommunication.png)

# Multi-GPU Training on Machine

## Training

![Multi GPU](/assets/posts/DL2021/MultiGPU.svg)
image_caption

https://pytorch.org/tutorials/intermediate/dist_tuto.html
https://pytorch.org/docs/stable/distributed.html

# Multi-GPU Single Node Training Cloud
# Multi-GPU, Multi-Node Training Cloud

Truly large-scale models are trained in the multi-gpu, multi-node setting. Examples include GPT-3, DeepMind's DOTA model, and Google's DL driven recommendation algorithms. Recall that a 'node' is typically a physical machine with 8 GPU's. When practitioners say a model was trained on 1024 GPU's, that precisely means the model was trained on 1024 / 8 = 128 physical nodes, each with 8 GPU's. 

Let's take a moment to think of the broad challenges here before getting into specifics. We're now training a model across 128 separate physical machines. This introduces problems related to communication, i.e. that the physical nodes will have to communicate with each other over some network, and problems of 

6a. Distributed Training Frameworks (_Training Backends_)
a. MPI
b. DDP (NCCL)
c. Horovod 
https://github.com/horovod/horovod
d. BytePS
e. Parameter Servers

https://pytorch.org/tutorials/intermediate/rpc_param_server_tutorial.html


7. Cloud Workflows for Deep Learning
8. Deep Learning Frameworks
9. Higher Level Frameworks 
Keras, Ignite, Lightning
9. Data Ingestion Patterns

Resources:

Andrej Karpathy's Recipe for Training Neural Networks (2019)