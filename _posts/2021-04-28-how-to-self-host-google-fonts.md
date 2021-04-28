---
layout: post
title: "How to self host Google Fonts"
description: "TLDR; search for 'google-webfonts-helper'"
date: 2021-04-28 23:30
author: Robert Muehsig
tags: [Google Fonts]
language: en
---

{% include JB/setup %}

[Google Fonts](https://fonts.google.com/) are really nice and widely used. Typically Google Fonts consistes of the actual font file (e.g. woff, ttf, eot etc.) and some CSS, which points to those font files. 

In one of our applications, we used a HTML/CSS/JS - Bootstrap like theme and the theme linked some Google Fonts. The problem was, that we wanted to __self host everything__. 

After some research we discovered this tool: __[Google-Web-Fonts-Helper](https://google-webfonts-helper.herokuapp.com/)__ 

![x]({{BASE_PATH}}/assets/md-images/2021-04-28/image.png "Google Web Fonts Helper")

Pick your font, select your preferred CSS option (e.g. if you need to support older browsers etc.) and download a complete .zip package. Extract those files and add them to your web project like any other static asset. (*And check the font license!*)

The project site is on [GitHub](https://github.com/majodev/google-webfonts-helper).

Hope this helps!