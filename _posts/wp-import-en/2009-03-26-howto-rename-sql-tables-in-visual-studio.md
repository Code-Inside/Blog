---
layout: post
title: "HowTo: Rename SQL Tables in Visual Studio"
date: 2009-03-26 02:41
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, SQL, Visual Studio]
language: en
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image79.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; margin: 0px 10px 0px 0px; border-right-width: 0px" height="104" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb90.png" width="147" align="left" border="0" /></a>The integration of SQL Servers in Visual Studio is really great. I use VS to create my SQL tables and simple administration stuff - it&#180;s not often that I start SQL Management Studio. But one thing is really annoying: You can&#180;t rename SQL Tables in VS! But there is a little trick to do that.</p> 
<!--more-->
  <p><strong>The context menu:</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image80.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="172" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb95.png" width="244" border="0" /></a> </p>
<p>Unfortunately there is no &quot;rename&quot; button here and the name property is disabled.</p>
<p><strong>The trick:</strong>     <br />Just add the tables to an database diagram and rename it there and save it - that&#180;s it.</p>
<p><em>I found this nice trick on <a href="http://www.bbits.co.uk/blog/archive/2006/03/15/7660.aspx">this site</a> - there are <a href="{{BASE_PATH}}/2009/02/20/howto-create-sql-table-relationships-via-dragndrop/">some cool features</a> in the database diagram view. </em></p>
