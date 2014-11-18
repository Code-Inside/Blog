---
layout: post
title: "Easy ways to customize Bootstrap"
description: "If you are developer - like me - you might already using Bootstrap, but what if you need to change some colors or font-families? Here are some tools that I have found."
date: 2014-11-18 20:20
author: robert.muehsig
tags: [Bootstrap]
---
{% include JB/setup %}

So, you are using Bootstrap? Fine, but what do you do if you would like to change some color, font-sizes, font-families, paddings etc.? 
This blogpost highlights some (free) tools for people who don't write or know a lot of CSS/LESS. If you are a front-end dev and already know advanced toolings this blogpost is not ideal for you.

## Don't customize the CSS/LESS files
_Here might be dragons!_ A big warning upfront: Don't pollute the generated CSS files and only change the variables.less file from Bootstrap - otherwise you are running a your own fork and might not be able to upgrade.

As far as I know all Customizer will only alter the variables.less file - this is the only way to _customize_ bootstrap.

If you only want to change certain elements [try to override it with your own CSS](http://bootstrapbay.com/blog/customize-bootstrap/).

## [The Default Customizer](http://getbootstrap.com/customize/)

Well - this one might be obvious - but there is the [official Customizer on getBootstrap.com](http://getbootstrap.com/customize/). This works well, but you there is no direct feedback and you need to know the variables and their behavior. 
If you start using this customizer you will be able to get a "config.json" file which you can reuse later. This file saves all your settings and you can change it later.

![x]({{BASE_PATH}}/assets/md-images/2014-11-18/default-customizer.png "Bootstrap Default Customizer")

## [Bootstrap Magic](http://pikock.github.io/bootstrap-magic/)

This one comes with a live editor and in theory you should be able to import an existing variables.less, but it didn't worked for me.

But the live changing elements makes it very easy to see the changes in action and if you don't need to upload existing variables this one might work for you.

![x]({{BASE_PATH}}/assets/md-images/2014-11-18/magic.png "Bootstrap Magic")

## My recommendation: [Bootstrap Live Customizer](http://bootstrap-live-customizer.com/)

Like Bootstrap Magic this one comes also with "Live" Rendering. With this editor I was able to change some variables, generate the CSS/LESS, reuploaded the variables.less file at a later time and continue my editing.
_Awesome and definitely worth trying out!_

![x]({{BASE_PATH}}/assets/md-images/2014-11-18/live.png "IIS Management Service Delegation")
 
Hope this helps!
 
_If you know other tools, please let me know. Thanks!_