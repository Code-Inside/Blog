---
layout: post
title: "HowTo: Taskmanagement with Visual Studio (ToDos, Hacks & co.)"
date: 2008-11-19 11:26
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, Taskmanagement, TFS, Visual Studio]
language: en
---
{% include JB/setup %}
<p>Many programmers know that there is very handy tool inside of Visual Studio to manage ToDos, &quot;Hacks&quot; and so on. I discovered this cool, secret (Visual Studio has a lot of such unknown gimmicks) feature some weeks ago: </p>
<p><strong>Taskmanagement</strong></p>
<p>You can manage your tasks in several applications: Outlook, &quot;Work Items&quot; in combination with TFS or other non-Microsoft product.    <br />In small or private projects I haven&#180;t a TFS and don&#180;t want to use Outlook - one important point is the connection between the ToDo/Hack/what ever and the code line/code file. </p>
<p>Just activate &quot;View -&gt; Task List&quot; in Visual Studio and you get a small taskmanager.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb34.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="244" alt="image_thumb" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb-thumb.png" width="221" border="0" /></a> </p>
<p>You can view your current ToDos (+ code line where the ToDo is located) :</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb35.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="93" alt="image_thumb3" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb3-thumb.png" width="284" border="0" /></a> </p>
<p>If you klick on one item you go directly to this code file:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb61.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="83" alt="image_thumb6" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb6-thumb.png" width="400" border="0" /></a> </p>
<p>Just add <em>&quot;ToDo: ...&quot;</em>&#160; to create a new task.</p>
<p><strong>Custom Tokens</strong></p>
<p>You can easly add your own &quot;Tokens&quot; in the option dialog of Visual Studio:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb91.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="297" alt="image_thumb9" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb9-thumb.png" width="507" border="0" /></a> </p>
<p>If you work in big projects or with a team you should only use the &quot;Taskmanager&quot; in Visual Studio for very small &quot;ToDos&quot; or &quot;Hacks&quot; - bigger ToDos&#160; should be placed inside other systems like TFS as &quot;Work Items&quot;.</p>
