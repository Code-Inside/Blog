---
layout: post
title: "Entrance into Git for .NET Developer"
date: 2011-08-23 16:56
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: [Git; Google Code]
language: en
---
{% include JB/setup %}
&nbsp;

&nbsp;

&nbsp;

If you want to be hip at the Source Control administration you have to take a look on Git or other peripheral Source Code administrations. Git is the most celebrated agent. That the subject <a href="http://en.wikipedia.org/wiki/Distributed_revision_control">DVCS (peripheral version administration)</a> will be Mainstream in the world of .NET world is a fact since <a href="http://blogs.msdn.com/b/bharry/archive/2011/08/02/version-control-model-enhancements-in-tfs-11.aspx">the comment of Brain Harry to the next TFS (responsible for the TFS at the Microsoft Corp.):</a>

“I’m certain that about this time, I bunch of people are asking “but, did you implement DVCS”.  The answer is no, not yet.  You still can’t checkin while you are offline.  And you can’t do history or branch merges, etc.  Certain operations do still require you to be online.  You won’t get big long hangs – but rather nice error messages that tell you you need to be online.  DVCS is definitely in our future and this is a step in that direction but there’s another step yet to take.”

<a href="{{BASE_PATH}}/assets/wp-images-en/image1313.png"><img style="background-image: none; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; padding-top: 0px; border: 0px;" title="image1313" src="{{BASE_PATH}}/assets/wp-images-en/image1313_thumb.png" border="0" alt="image1313" width="138" height="112" align="left" /></a>For this blogpost it is important, that I only started working with Git so it’s possible that some facts aren’t true. But of course you are welcome to adjust me in the comments below. If you need some more help than take a look at the help side of GitHub.

So let’s have a start….

<strong>Git – what do I need?</strong>

As client for windows I recommend <a href="http://code.google.com/p/msysgit/downloads/list">msysgit</a>. Important tool there is Git Bash. It’s possible to install a GUI but to say the true, I didn’t get how it works and the instructions are done with the Bash.

For playing around it’s a good idea to create a Repository on <a href="http://github.com/">GitHub</a> or Google Code (<a href="http://google-opensource.blogspot.com/2011/07/announcing-git-support-for-google-code.html">Google Code supports Git as well</a>). I’ve created a Repository on both services and in my opinion GitHub is more elegant and offers a lot of help for beginner.

<strong>Introduction to GitHub</strong>

GitHub offers a great help which adopts you the subject step by step. From the setup of the client…

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb500.png" border="0" alt="image" width="569" height="351" />

… to the creation of the first repositories:

<a href="{{BASE_PATH}}/assets/wp-images-en/image1319.png"><img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="image1319" src="{{BASE_PATH}}/assets/wp-images-en/image1319_thumb.png" border="0" alt="image1319" width="570" height="337" /></a>

<strong>Important Initial instructions</strong>

In the last Screenshot you can see the first instructions for a first “Checkin” (in TFS language):

First you create a folder named “BizzBingo” and after that you start the initialization with “git init”.

In the folder there is a hidden “.git” folder – that’s where the mainly magic with the version administration happens. A file will be created and added via “git add.” And you da a “git commit – m ‘First’!” . Now we add it via “git remote…” to GitHub an push it at the end via “git push – u origin master”.

Now it’s visible at GitHub (in the example it’s a readme file).

<strong>Introduction at Google Code</strong>

In fact it’s not that different at <a href="http://code.google.com/hosting/createProject">Google Code</a>. Here it starts with cloning the Repository. With this the “.git” folder will be placed in the directory.

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb498.png" border="0" alt="image" width="580" height="232" />

<strong>Add files</strong>

I’ve copied files into the directory. Via “<strong>git add</strong>.” All files in the directory will be added to Repository.

Now the order “git commit –m “COMMENT” appears – But be careful if you call git commit VIM appears and asks you to insert a comment:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb499.png" border="0" alt="image" width="510" height="149" />

Press “I” for the Inser-Mode and enter something now “ESC” and “:wq” I recommend you the “-m ‘Comment’” parameter.

<strong>Go on trying …</strong>

Like I’ve said before I recommend you the <a href="http://help.github.com/">GitHub Help Side</a>. If I found out something new I will let you know <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile24.png" alt="Zwinkerndes Smiley" />

Download <a href="http://code.google.com/p/msysgit/downloads/list">Git Client for Windows</a>

Create Repository on <a href="https://github.com/">GitHub</a> / <a href="http://code.google.com/hosting/">GoogleCode</a>

<script type="text/javascript"><!--
google_ad_client = "ca-pub-9430917753624356";
/* Code-Inside Post Ende */
google_ad_slot = "2672274407";
google_ad_width = 468;
google_ad_height = 60;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
