---
layout: post
title: "How we moved from Wordpress to Jekyll - on Windows"
description: "TL;DR Normal Wordpress Export and convert this via wpXml2Jekyll to Markdown. Fixed URLs & co. via Notepad++ and copied files. Commit do GitHub. Done. But its a bit harder to get things running on Windows."
date: 2014-09-13 21:45
author: Robert Muehsig
tags: [Wordpress, Jekyll, Migration, Windows]
language: en
---
{% include JB/setup %}

As I told you in an older post we moved successfully (more or less...) from Wordpress to [Jekyll](http://jekyllrb.com/). And we did this with our Windows Machines. I will explain very shortly how we did this migration and how we got Jekyll run on Windows.

## 1. Install a comment system like Disqus and Migrate the existing Comments
Jekyll is a static page generator and ... well... its static. No "dynamic" content here. Therefor comments needs to be outsourced, because this is something "dynamic". A popular service for comments is [__Disqus__](https://disqus.com/). Install Disquis in your Wordpress Installation and make sure all comments are visible on your blog. Disqus offers a Wordpress Plugin (which was kinda buggy) and can import comments via the Export XML (see step 2).

## 2. Export Wordpress Pages/Posts/Comments
Go in your Wordpress Administration and Export everything via __"Tools"__ - __"Export"__. This generates a Wordpress Export XML. 

## 3. Backup all Images/Assets/Media Files from your Wordpress Installation
The Wordpress Export will only contain non-binary data. In order to save images and other uploads __copy everything under wp-uploads to your machine__.

## 4. Convert Pages and Posts to Markdown via wpXml2Jekyll
I used [__wpXml2Jekyll__](https://github.com/theaob/wpXml2Jekyll) to convert the Wordpress Export to Markdown. There are some other tools out there, but this one is very easy and does its job. If you know C# (or want to learn it) you can look at the source code and enhance it. The result should contain Posts and Pages as Markdown.

## 5. Finetuning - Search & Replace in the Markdown files.
Notepad++ was a big help in this step. I removed some old domain references in the Markdown files and some "invalid" characters from the export. Might not be needed, but keep in mind: You now have a bunch of text files, which are very easy to edit.

## 6. Install Jekyll - on Windows.
Now it's time to run Jeykll. It should be much easier on Linux or Mac, but I use Windows and this is the best description I found on the Web:
[__Run Jekyll on Windows__](http://jekyll-windows.juthilo.com/)
Make sure you follow each step. You will need Ruby, Ruby Dev Kit, Ruby Gems, Jekyll and Phyton - and make sure Ruby and Phyton are in the PATH Variable. This was a major pain point for me - but trust me: It works.

## 7. Running Jekyll with Content
Now you should move the Pages/Posts to Jekyll and put the copied media files somewhere. Our Blog-Repository contains the Markdown & Media Files. In this step you should test your site and see if everything is served as expected.

## 8. Make it Awesome
As you can see - we are still working on this, but now our Blog is powered by Jekyll and saved on GitHub - which is super awesome.

## Summary
The steps are not hard, but we needed some time to do this migration and we have still room for improvements. Biggest issue was to get Jekyll running on Windows. Hope this might help you when you migrate your Blog from Wordpress to Jekyll.
