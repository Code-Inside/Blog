---
layout: post
title: "HowTo: start visual studio always as administrator"
date: 2010-11-06 19:27
author: CI Team
comments: true
categories: [HowTo]
tags: [Admin, start, Visual Studio]
language: en
---
{% include JB/setup %}
<p><img title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb156.png" width="196" height="120" />Those of you who use the right IIS as development server should know the problem with vista and windows 7:</p>
<p>As long as the user account control /UAC still works you need to go the hard way via "click right" and "achieve as admin". With a little trick it´s possible to avoid all the clicks in the context menu. </p> 
  

<p><b>"run program as administrator"</b></p>
<p>You will find this action in the calibration menu:</p>
<p><img title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb157.png" width="269" height="378" /></p>
<p>With a double click on the .SLN these exe will be opened:</p>  
  
  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:77ccb5e2-c103-42d3-a3c7-a4ed12049c81" class="wlWriterEditableSmartContent"><pre name="code" class="c#">C:\Program Files (x86)\Common Files\microsoft shared\MSEnv\VSLauncher.exe

</pre>
</div>





<p>You will find the normal exe file here:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:867416fd-76b7-4090-a6fc-a8cbf1036169" class="wlWriterEditableSmartContent"><pre name="code" class="c#">C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\IDE\devenv.exe
</pre>
</div>


<p>Make these calibrations on both files. Without changing the UAC you will still have the "warning dialog" - otherwise you will be reminded every tame to start VS as an admin and you must not search for "run program as administrator". </p>

<p>By the way: if you are used to develop desktop programs you should keep in mind that you program should be able to be achieved by normal users without admin rights as well. </p>
