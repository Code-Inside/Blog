---
layout: post
title: "Chocolatey-apt-get for Windows"
date: 2012-09-25 10:25
author: CI Team
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
&nbsp;

Per exident I’ve found the Tool „<a href="http://chocolatey.org/">Chocolatey</a>“. If you take a look on the website you may recognize some similarities to <a href="http://nuget.org/">NuGet</a>.

<strong>What does Chocolatey?<a href="{{BASE_PATH}}/assets/wp-images-en/image163.png"><img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb71.png" border="0" alt="image" width="506" height="649" /></a></strong>

Chocolatey is a “Maschine Package Manager” what means that it helps you with easy download and update tools for your machine – straight on the console.

<strong>What’s the difference to NuGet?</strong>

NuGet is for Development libraries whereas Chocolatey is more about the Tooling.

<strong>You need a demonstration?</strong>

The team of Chocolatey published a video which shows some of the functions:

&nbsp;
<div id="scid:5737277B-5D6D-4f48-ABFC-DD9C333F4C5D:070cdd04-02b7-44e5-90fa-0eedf3e04828" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<div><object width="448" height="252"><param name="movie" value="http://www.youtube.com/v/N-hWOUL8roU?hl=en&amp;hd=1" /><embed type="application/x-shockwave-flash" width="448" height="252" src="http://www.youtube.com/v/N-hWOUL8roU?hl=en&amp;hd=1"></embed></object></div>
</div>
<strong>How do I install Chocolatey?</strong>

Simple start CMD and follow this:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb712.png" border="0" alt="image" width="474" height="65" />

<em>@powershell -NoProfile -ExecutionPolicy unrestricted -Command “iex ((new-object net.webclient).DownloadString(‘http://bit.ly/psChocInstall’))”</em>

<strong>Try it…</strong>

I had to close the console first and open the powershell console but then I was able to run the “cinst Console2”:

<a href="{{BASE_PATH}}/assets/wp-images-en/SNAGHTMLb39dd9c.png"><img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="SNAGHTMLb39dd9c" src="{{BASE_PATH}}/assets/wp-images-en/SNAGHTMLb39dd9c_thumb.png" border="0" alt="SNAGHTMLb39dd9c" width="477" height="320" /></a>

Tadaa….

<strong>Open Source, for Windows and based on NuGet</strong>



Over all it is <a href="https://github.com/chocolatey/chocolatey/">Open Source</a>, based on NuGet (like you can see) and although it’s an old idea it wasn’t already solved for windows. Take a look on Chocolaey – for the developer tool box <img class="wlEmoticon wlEmoticon-smile" style="border-style: none;" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-smile16.png" alt="Smiley" />

More information’s are available at the <a href="https://github.com/chocolatey/chocolatey/wiki">GitHub Wiki</a>!

If you are already familiar to the tool you are welcome to <a href="http://www.knowyourstack.com/what-is/chocolatey">share your experiences on KnowYourStack</a> <img class="wlEmoticon wlEmoticon-smile" style="border-style: none;" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-smile16.png" alt="Smiley" />
