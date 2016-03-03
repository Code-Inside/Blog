---
layout: post
title: "Using Travis CI for GitHub Pages builds"
description: "Recently I had some issues with publishing blogposts on GitHub Pages. To get a better understanding if something failed during the Jekyll build I started to use Travis CI."
date: 2016-03-03 23:30
author: Robert Muehsig
tags: [Jekyll, GitHub Pages, Travis CI]
language: en
---
{% include JB/setup %}

![x]({{BASE_PATH}}/assets/md-images/2016-03-03/travisci.png "Travis CI Logo")

## Short recap: GitHub Pages & Jekyll

This blog is powered by [GitHub Pages](https://pages.github.com/), which uses [Jekyll](https://jekyllrb.com/) in the background. Jekyll is a static website generator, which means that this page is "build" and has no server-side rendering logic when you hit the page - it's pure static HTML, CSS and JS.

You could run Jekyll on your local box and publish the sites to GitHub Pages - I prefer a pure "GitHub Page"-based model. Actually I don't even have Jekyll installed on my PC. [I wrote a small blogpost about running Jekyll on Windows if you are interested](http://blog.codeinside.eu/2014/09/13/How-We-Moved-From-Wordpress-To-Jekyll-On-Windows/).

## __[Travis CI](http://travis-ci.org)__

As you might imaging - during the build stuff can break. In this case GitHub will send you a very short "error" email via mail. To get a more detailed report, [GitHub suggests to use Travis CI](https://help.github.com/articles/viewing-jekyll-build-error-messages/), which is the main topic of this blogpost.

## Travis CI Setup

The basic setup is pretty simple, but I had some issues - the last step is not very good documented - and that's why I decided to blog about it.

### 1. Login to Travis CI and "sync" your account

You will need to login to Travis CI with your GitHub account. This will kick in a "sync". After a short period you should see all your repositories on your profile page:

![x]({{BASE_PATH}}/assets/md-images/2016-03-03/travisci-1.png "Travis CI Profile Page")

### 2. Enable the desired project on Travis CI

Just flip on the switch on your profil page for the desired project and Travis will watch the repository for any changes.

### 3. Adding a Gemfile and a .travis.yml file to your project

To build GitHub Page stuff via Travis you will need a [Gemfile](https://github.com/Code-Inside/Blog/blob/gh-pages/Gemfile) and a [.tarvis.yml](https://github.com/Code-Inside/Blog/blob/gh-pages/.travis.yml).
My current files are pretty basic and a copy from the GitHub Pages Help site, with __one important exception__...

### 4. Targeting the correct branch

The last step is to ensure that Travis CI will search for the correct branch. In my case, I only have the "gh-pages" branch, but Travis CI will look for a "master" branch.

To configure Travis CI to use the correct "gh-pages" branch you will need this config section inside the .yml:

    branches:
     only:
     - gh-pages  

After this setup you should already see the finished Travis CI build:
	 
![x]({{BASE_PATH}}/assets/md-images/2016-03-03/travisci-2.png "Travis CI Build Page")

__Important:__ The output of the build will not be copied over to GitHub - at this stage it is just a "safety net". If you want to publish from Travis CI, there are many blogposts out there that describe this topic.

Hope this helps!
