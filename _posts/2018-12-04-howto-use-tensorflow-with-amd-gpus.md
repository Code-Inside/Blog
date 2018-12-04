---
layout: post
title: "How to use TensorFlow with AMD GPU's"
description: "it's super easy"
date: 2018-12-04 23:15
author: Oliver Guhr
tags: [ml, tensoflow, amd , gpu]
language: en
---

{% include JB/setup %}

# How to use TensorFlow with AMD GPU's 

Most machine learning frameworks that run with a GPU support Nvidia GPUs,
but if you own a AMD GPU you are out of luck. 

Recently AMD has made some progress with their [ROCm](https://rocm.github.io/) platform for GPU computing and does now provide a TensorFlow build for their gpus. 

Since I work with tensorflow and own a AMD GPU it was time to give it a try.
I stumpled upon [these](https://gpuopen.com/rocm-tensorflow-1-8-release/) instructions for TensorFlow 1.8 but since they are outdated, I decided to write down what I did. 


## 1. Set up Linux

It looks like there is currently no ROCm support for Windows. And no, WSL aka Bash for Windows does not work. But there are packages for CentOS/RHEL 7 and Ubuntu. I used Ubuntu 18.04.

## 2. Install ROCm

Just follow the ROCm [install instructions](https://rocm.github.io/ROCmInstall.html#ubuntu-support---installing-from-a-debian-repository).

## 3. Install TensorFlow 

AMD provides a special build of TensorFlow. Currently they support TensorFlow 1.12.0. 
You can build it yourself, but the most convenient way to use it, is to install the package from PyPI:

```
sudo apt install python3-pip 
pip3 install --user tensorflow-rocm
```


## 4. Train a Model

To test your setup you can run the image recognition task from the Tensorflow tutorials.

```
git clone https://github.com/tensorflow/models.git
cd models/tutorials/image/imagenet
python3 classify_image.py
```

and the result should look like this:

```
giant panda, panda, panda bear, coon bear, Ailuropoda melanoleuca (score = 0.89103)
indri, indris, Indri indri, Indri brevicaudatus (score = 0.00810)
lesser panda, red panda, panda, bear cat, cat bear, Ailurus fulgens (score = 0.00258)
custard apple (score = 0.00149)
earthstar (score = 0.00141)
```



