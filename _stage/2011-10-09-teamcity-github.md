---
layout: post
title: "TeamCity & GitHub"
date: 2011-10-09 13:26
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
&nbsp;

Because of my <a href="http://code-inside.de/blog-in/2011/08/23/entrance-into-git-for-net-developer/">latest fun</a> with Git I’ve planned to connect it with the CI Tool of my choice. So what do I have to do if I want TeamCity to bring me the latest Sources?

<strong> </strong>

<strong>In fact it’s very easy…</strong>

<strong> </strong>

In the latest <a href="http://www.jetbrains.com/teamcity/">Version of TeamCity (at the moment it’s 6.5)</a> the Git-Client is already installed. It’s not necessary to do some SSH configuration or some magic stuff like that – at least not for taking open repositories only.

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb552.png" border="0" alt="image" width="502" height="278" />

Important: Instead of declaring the HTTP address (like you know it from several SVN hosts) you need to declare the GIT Adress:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb553.png" border="0" alt="image" width="551" height="132" />

What’s left could stay at default. Sometimes things are not that difficult.
