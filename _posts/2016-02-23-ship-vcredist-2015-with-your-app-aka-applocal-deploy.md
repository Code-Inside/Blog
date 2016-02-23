---
layout: post
title: "Shipping Visual C++ 2015 redistributable DLLs with your app or how to do an app-local deployment"
description: "So, this was a long headline. A few days ago I had the pleasure to take a peek into VC++ development. One problem was, that we use the VC++ 2015 runtime, which needs to be deployed on the client. This blogpost will cover how to ship this dependency with your app."
date: 2016-02-23 22:45
author: Robert Muehsig
tags: [VCRedist, VC++, Universal CRT]
language: en
---
{% include JB/setup %}

## Small warning: I'm not a C++ dev

We use VC++ just for a very small part of our application, but this part needs the VC++ 2015 runtime "installed" on the client, but we don't want the UAC install dialog. 
So - let's take a look how we can solve this problem.

And if I write something stupid here - please let me know.

## Ways to deploy VC++ 2015

There are three ways to deploy the runtime:

* Install it via the standalone VCRedist installer. This is probably the most known way, but requires elevated permissions because the file will be installed to System32.
* Install it via a merge module. If you already have an installer, you can include the needed .msm files in your own installer, but this will also require elevated permissions because the files will be also installed to System32.
* Deploy it with your app as app-local deployment. We will cover this in this blogpost, because __we don't want to touch the elevated permissions__.

If you want to read more about the first two ways, the [MSDN](https://msdn.microsoft.com/en-us/library/ms235299.aspx) might be a good place to start.

## App-Local deployment of the VC++ 2015 runtime

All what you need is already (if you are using Windows 10 & Visual Studio 2015) installed on your dev machine. Otherwise you will need to download the Windows 10 SDK and Visual Studio 2015.

Depending on your application, you will need to ship __all__ dlls from the following folders with your application (= the dll/exe/whatever that needs the runtime) :

__x86 applications__

* C:\Program Files (x86)\Windows Kits\10\Redist\ucrt\DLLs\x86
* C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\redist\x86\Microsoft.VC140.CRT

__x64 applications__

* C:\Program Files (x86)\Windows Kits\10\Redist\ucrt\DLLs\x64
* C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\redist\x64\Microsoft.VC140.CRT

The ["Universal CRT"](https://blogs.msdn.microsoft.com/vcblog/2015/03/03/introducing-the-universal-crt/) consists of many dlls and all are required. You have to copy them to your application folder and it should just work.

As far as I know, if a user has installed the runtime via VCRedist or the merge modules the files inside System32 will be picked.

I found this solution [here](https://social.msdn.microsoft.com/Forums/sqlserver/en-US/d8f0acf9-5d4c-408d-8cea-c201fd61b9b7/local-deployment-of-redist-dlls-no-longer-works-with-visual-studio-2015?forum=visualstudiogeneral) and it seems to work just fine - no UAC prompt. Yay.

Hope this helps.
