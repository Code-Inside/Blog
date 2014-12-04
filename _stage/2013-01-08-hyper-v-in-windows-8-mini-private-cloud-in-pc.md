---
layout: post
title: "Hyper-V in Windows 8 – „Mini-Private-Cloud in PC“"
date: 2013-01-08 14:20
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
&nbsp;

<strong> </strong>

Windows 8 Pro and Enterprise deliver a powerful tool: Hyper-V. Hyper-V is the platform for virtualization and was only available for server operating systems – with Windows 8 it is now also available for Pro and Enterprise versions. Since main storage and disk space aren’t that expensive everyone is able to have their own “Mini-Private-Cloud” on their PC.

<strong>Why Hyper-V? </strong>

<strong> </strong>

Of course there are several platforms for virtualization – even for free – but if the operating system offers one why not use it or at least try it?

I would guess that the Hyper-V version doesn’t differ from the server version that means in fact you have an efficient platform for virtualization in your ordinary pc.

<strong>Who should use it – and who not?</strong>

<strong> </strong>

Hyper-V is quite “technical” and offers many opportunities although it might not be the most comfortable option for users. Since Hyper-V comes from the server-Connor it is not comparable with user friendly virtualization solutions. If you are looking for VMWare Fusion or parallels (both virtualization solutions on MAC OS to virtualize Windows) you shouldn’t use Hyper-V.

But it is perfect for developer or IT-Admins to test software.

<strong>Installation:</strong>

<strong> </strong>

The installation is very easy as long as the hardware plays along:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb850.png" border="0" alt="image" width="396" height="410" />

After the installation (which will unfortunately ask for a reboot) you are now able to use the Hyper-V manager.

<strong>Configure Hyper-V: Step 1 – Network </strong>

<strong> </strong>

At first you need to create a “Virtual Switch”.

<img title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb851.png" border="0" alt="image" width="311" height="159" />

If you want to integrate the virtual machine into the network (including the internet connection) you might use my setting as an example:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb852.png" border="0" alt="image" width="521" height="492" />

<strong> </strong>

<strong>Configure Hyper-V: Step 2 – create a virtual machine </strong>

<strong><img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb853.png" border="0" alt="image" width="400" height="285" /></strong>

&nbsp;

<strong> </strong>

Now a wizard appears where you have to enter the following information’s:

- VM names

- Storage location

- Connection (here you have to select the virtual switch)

- Virtual hard disk place and a possible installation medium

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb854.png" border="0" alt="image" width="479" height="369" />

<strong>User Hyper-V</strong>

<strong> </strong>

After you’ve created the VM you are now able to start the VM, connect yourself via RDP with the integrated monitor or make some snapshots and so on.

<img title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb855.png" border="0" alt="image" width="538" height="224" />

<strong>VHDs are compatible with other virtualization platforms </strong>

<strong> </strong>

The virtual hard disk (VHD) could also be used from other Hyper-V installations, VirtualBox or VMWare (<a href="http://en.wikipedia.org/wiki/VHD_(file_format)">and other</a>). The VHD could even be lifted to the “right” Cloud with Windows Azure.

<strong>Everything on board… </strong>

If you like to test new operation systems without knocking out your main computer virtualization is a good thing. With Hyper-V you have a new powerful solution in the desktop operation system – just a few clicks away <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="http://code-inside.de/blog-in/wp-content/uploads/wlEmoticon-winkingsmile49.png" alt="Zwinkerndes Smiley" />

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb856.png" border="0" alt="image" width="587" height="366" />
