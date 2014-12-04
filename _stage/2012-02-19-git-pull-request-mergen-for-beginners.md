---
layout: post
title: "Git-Pull Request mergen for beginners"
date: 2012-02-19 14:26
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
<p><a href="http://code-inside.de/blog-in/wp-content/uploads/image1450-570x194.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image1450-570x194" border="0" alt="image1450-570x194" src="http://code-inside.de/blog-in/wp-content/uploads/image1450-570x194_thumb.png" width="498" height="170" /></a></p>  <p>My project “<a href="http://knowyourstack.com/">KnowYourStack.com</a>” (the working title was BizzBingo – a detailed blogpost will follow soon) lays on <a href="https://github.com/robertmuehsig/BizzBingo">GitHub</a> and I’ve recognized a Problem where <a href="http://daniellang.net/">Daniel Lang</a> helped me a lot. At the end he created a Fork for my Project and laid a Pull Request:</p>  <p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb625.png" width="583" height="192" /></p>  <p><b>The question is: How do I transfer the changes to me?</b></p>  <p>Because I’m a totally beginner in <a href="http://www.knowyourstack.com/what-is/git">Git</a>/<a href="http://www.knowyourstack.com/what-is/github">GitHub</a> I’m going to write it down step by step. The <a href="http://help.github.com/send-pull-requests/">help</a> page on GitHub was a good introduction but at last I need to merge several files during this action which makes this a lot more complicated.</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:f7c2f135-b3e9-445b-9e61-88cf970a051a" class="wlWriterEditableSmartContent"><pre name="code" class="c#">git checkout master
...
git pull https://github.com/dlang/BizzBingo master
... (VIELE DATEIEN werden gezogen)...</pre></div>

<p><b></b></p>

<p><b>Result:</b></p>

<p>“Automatic merge failed: fix conflicts and then commit the result.” </p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b2fbb714-72bf-4584-bc99-3c99a09dc1a3" class="wlWriterEditableSmartContent"><pre name="code" class="c#">$ git mergetool</pre></div>

<p><b>Beware: </b>Before you start make sure you already created a Mergetool. It’s not that difficult and you will find a <a href="http://gitguru.com/2009/02/22/integrating-git-with-a-visual-merge-tool/">detailed instruction here</a>. In fact all you have to do is to choose a Merge Program (I’ve chosen <a href="http://kdiff3.sourceforge.net/">KDiff3</a> but it’s ugly). And after that you need to tell Git which tool is the right one for the mergen process. At the end that’s what the .gitconfig looks like: </p>

<p>&#160;</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:26b42d98-a735-4b8b-be0b-f3997c7ef161" class="wlWriterEditableSmartContent"><pre name="code" class="c#">[diff][/diff]

	tool = kdiff3

[merge]

	tool = kdiff3

[mergetool "kdiff3"]

	path = C:/Program Files (x86)/KDiff3/kdiff3.exe

    keepBackup = false

    trustExitCode = false

[difftool "kdiff3"]

    path = C:/Program Files (x86)/KDiff3/kdiff3.exe

    keepBackup = false

    trustExitCode = false</pre></div>

<p>After that the files will merge to GitHub with “commit” and “push”. That’s it. <img style="border-bottom-style: none; border-left-style: none; border-top-style: none; border-right-style: none" class="wlEmoticon wlEmoticon-smile" alt="Smiley" src="http://code-inside.de/blog-in/wp-content/uploads/wlEmoticon-smile12.png" /></p>

<p>I think that will work – Thanks again Daniel <img style="border-bottom-style: none; border-left-style: none; border-top-style: none; border-right-style: none" class="wlEmoticon wlEmoticon-smile" alt="Smiley" src="http://code-inside.de/blog-in/wp-content/uploads/wlEmoticon-smile12.png" /></p>
