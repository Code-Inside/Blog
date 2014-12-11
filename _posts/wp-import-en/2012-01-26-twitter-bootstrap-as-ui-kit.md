---
layout: post
title: "Twitter Bootstrap as UI-kit"
date: 2012-01-26 18:26
author: CI Team
comments: true
categories: [Uncategorized]
tags: [Twitter Bootstrap]
language: en
---
{% include JB/setup %}
&nbsp;

<strong> </strong>

HTML and CSS are not foreign words for me but I regret, I’m not a Web designer - I see myself as a webdeveloper. But at least a dressy side is a must. But thank good there are some ready “Systems”.

<strong> </strong>

<strong>Twitter Bootstrap</strong>

<strong> </strong>

Twitter Bootstrap is a Toolkit for every kind of Web applications. It includes some basic styles and also some special styles for Buttons, charts, forms and so on. After all it is a smart Grid-System. Compared to other CSS Grid Frameworks Twitter Bootstrap seems to be more “round” and it offers some basic elements.

The best way is to take a look <a href="http://twitter.github.com/bootstrap/">online</a>. You will find a source on <a href="https://github.com/twitter/bootstrap">GitHub</a>.

<strong>Technics behind it </strong>

<strong> </strong>

Twitter Bootstrap is using <a href="http://twitter.github.com/bootstrap/#less">Less</a> to build the CSS and it also contains ready <a href="http://twitter.github.com/bootstrap/javascript.html">Javascripts</a> for some little UI gimmicks like Popups, Dropdowns, Dialogs, …

<strong>The embedding </strong>

<strong> </strong>

All you have to do is to embed the Styles (the Less files plus the <a href="http://lesscss.org/">Less Javascript files</a> or the ready CSS). An example which you will also found on the GitHub examples:
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d1640d3d-ba68-496a-acf1-23ffa7825732" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">&lt;!DOCTYPE html&gt;
&lt;html lang="en"&gt;
  &lt;head&gt;
    &lt;meta charset="utf-8"&gt;
    &lt;title&gt;Bootstrap, from Twitter&lt;/title&gt;
    &lt;meta name="description" content=""&gt;
    &lt;meta name="author" content=""&gt;

    &lt;!-- Le HTML5 shim, for IE6-8 support of HTML elements --&gt;
    &lt;!--[if lt IE 9]&gt;
      &lt;script src="http://html5shim.googlecode.com/svn/trunk/html5.js"&gt;&lt;/script&gt;
    &lt;![endif]--&gt;

    &lt;!-- Le styles --&gt;
    &lt;link href="../bootstrap.css" rel="stylesheet"&gt;
    &lt;style type="text/css"&gt;
      /* Override some defaults */
      html, body {
        background-color: #eee;
      }
      body {
        padding-top: 40px; /* 40px to make the container go all the way to the bottom of the topbar */
      }
      .container &gt; footer p {
        text-align: center; /* center align it with the container */
      }
      .container {
        width: 820px; /* downsize our container to make the content feel a bit tighter and more cohesive. NOTE: this removes two full columns from the grid, meaning you only go to 14 columns and not 16. */
      }

      /* The white background content wrapper */
      .content {
        background-color: #fff;
        padding: 20px;
        margin: 0 -20px; /* negative indent the amount of the padding to maintain the grid system */
        -webkit-border-radius: 0 0 6px 6px;
           -moz-border-radius: 0 0 6px 6px;
                border-radius: 0 0 6px 6px;
        -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.15);
           -moz-box-shadow: 0 1px 2px rgba(0,0,0,.15);
                box-shadow: 0 1px 2px rgba(0,0,0,.15);
      }

      /* Page header tweaks */
      .page-header {
        background-color: #f5f5f5;
        padding: 20px 20px 10px;
        margin: -20px -20px 20px;
      }

      /* Styles you shouldn't keep as they are for displaying this base example only */
      .content .span10,
      .content .span4 {
        min-height: 500px;
      }
      /* Give a quick and non-cross-browser friendly divider */
      .content .span4 {
        margin-left: 0;
        padding-left: 19px;
        border-left: 1px solid #eee;
      }

      .topbar .btn {
        border: 0;
      }

    &lt;/style&gt;

    &lt;!-- Le fav and touch icons --&gt;
    &lt;link rel="shortcut icon" href="images/favicon.ico"&gt;
    &lt;link rel="apple-touch-icon" href="images/apple-touch-icon.png"&gt;
    &lt;link rel="apple-touch-icon" sizes="72x72" href="images/apple-touch-icon-72x72.png"&gt;
    &lt;link rel="apple-touch-icon" sizes="114x114" href="images/apple-touch-icon-114x114.png"&gt;
  &lt;/head&gt;

  &lt;body&gt;

    &lt;div class="topbar"&gt;
      &lt;div class="fill"&gt;
        &lt;div class="container"&gt;
          &lt;a class="brand" href="#"&gt;Project name&lt;/a&gt;
          &lt;ul class="nav"&gt;
            &lt;li class="active"&gt;&lt;a href="#"&gt;Home&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="#about"&gt;About&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="#contact"&gt;Contact&lt;/a&gt;&lt;/li&gt;
          &lt;/ul&gt;
          &lt;form action="" class="pull-right"&gt;
            &lt;input class="input-small" type="text" placeholder="Username"&gt;
            &lt;input class="input-small" type="password" placeholder="Password"&gt;
            &lt;button class="btn" type="submit"&gt;Sign in&lt;/button&gt;
          &lt;/form&gt;
        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;div class="container"&gt;

      &lt;div class="content"&gt;
        &lt;div class="page-header"&gt;
          &lt;h1&gt;Page name &lt;small&gt;Supporting text or tagline&lt;/small&gt;&lt;/h1&gt;
        &lt;/div&gt;
        &lt;div class="row"&gt;
          &lt;div class="span10"&gt;
            &lt;h2&gt;Main content&lt;/h2&gt;
          &lt;/div&gt;
          &lt;div class="span4"&gt;
            &lt;h3&gt;Secondary content&lt;/h3&gt;
          &lt;/div&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;footer&gt;
        &lt;p&gt;&amp;copy; Company 2011&lt;/p&gt;
      &lt;/footer&gt;

    &lt;/div&gt; &lt;!-- /container --&gt;

  &lt;/body&gt;
&lt;/html&gt;</pre>
</div>
It creates this side:

<a href="{{BASE_PATH}}/assets/wp-images-en/image1367.png"><img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="image1367" src="{{BASE_PATH}}/assets/wp-images-en/image1367_thumb.png" border="0" alt="image1367" width="513" height="310" /></a>

<strong>Roadmap</strong>

There is also a <a href="https://github.com/twitter/bootstrap/wiki/Roadmap">Roadmap</a> for this Project which is cultivated by some developers on Twitter:

<a href="{{BASE_PATH}}/assets/wp-images-en/image1368.png"><img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="image1368" src="{{BASE_PATH}}/assets/wp-images-en/image1368_thumb.png" border="0" alt="image1368" width="521" height="232" /></a>

<strong>Result</strong>

Twitter Bootstrap seems to be a great entrance for non-designer with many nice elements. The only think I’ve missed is a version for Mobile websites – I’m looking forward to it.

Download and everything else on <a href="http://twitter.github.com/bootstrap/">GitHub</a>.
