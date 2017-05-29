---
layout: post
title: "Using Visual Studio Code & Team Foundation Version Control (TFVC)"
description: "See how to use Visual Studio Code with a TFVC based repository."
date: 2017-05-29 23:45
author: Robert Muehsig
tags: [TFVC, Visual Studio, Visual Studio Code]
language: en
---
{% include JB/setup %}

Recently we start working on a Angular 4 app but all other parts of the application (e.g. the backend stuff) were stored in a good old TFVC based repository (inside a Team Foundation Server 2015) . 
Unfortunately building an Angular app with the full blown Visual Studio with the "default" Team Explorer workflow is not really practical.
Another point for using Visual Studio Code was that most other online resources about learning Angular are using VS Code.

Our goal was to keep __one__ repository, otherwise it would be harder to build and maintain.

## First plan: Migrate to Git

First we tried to migrate our __complete__ code base to Git with this [generally awesome tool](https://github.com/git-tfs/git-tfs). Unfortunately for us it failed because of our quite large branch-tree. I tried it on a smaller code base and it worked without any issues.

At this point we needed another solution, because we wanted to get started on the actual application - so we tried to stick with TFVC.

__Important:__ I always would recommend Git over TFVC, because it's the way our industry is currently moving and at some point in the future we will do this too.

__If you have similar problems like us: Read on!__

## Second plan: Get the TFVC plugin working in Visual Studio Code

Good news: Since [April 2017](https://blogs.msdn.microsoft.com/visualstudioalm/2017/04/12/official-release-of-tfvc-support-for-visual-studio-code/) there is a Visual Studio Team Services extension for Visual Studio Code that also supports TFVC!

Requirements:

* Team Foundation Server 2015 Update 2
* A existing __local__ workspace configuration (at least currently, check this [GitHub issue](https://github.com/Microsoft/vsts-vscode/issues/176) for further information)
* The actual [extension](https://github.com/Microsoft/vsts-vscode)

## Be aware: Local Workspaces!

Even I'm using TFS since a couple of years I just recently discovered that the TFS supports to different "workflows". The "default" workflow always needs a connection to the TFS to checkout files etc. 
There is an alternative mode called "local" mode which seems to work like SVN. The difference is, that you can create a local file and the TFVC-client will "detect" those changes. Read more about the differences [here](https://www.visualstudio.com/en-us/docs/tfvc/decide-between-using-local-server-workspace).

![x]({{BASE_PATH}}/assets/md-images/2017-05-29/local-workspace.png "Local Workspace setting").

## Configuration

In our OnPremise TFS 2015 world I just needed only this configuration line in my user settings:

    ...
    "tfvc.location": "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Professional\\Common7\\IDE\\CommonExtensions\\Microsoft\\TeamFoundation\\Team Explorer\\TF.exe",
    ...

## Action!

Now when I point VS Code to my local workspace folder, the TFVC plugin will kick in and I see the familiar "change"-tracking:

![x]({{BASE_PATH}}/assets/md-images/2017-05-29/changetracking.png "Working with the extension").

It is not perfect, because I still need to setup and "manage" (e.g. get the history etc.) via the full blown Visual Studio, but with this setup it is "do-able".