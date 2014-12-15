---
layout: post
title: "Bullshit-Bingo-Online with BizzBingo-RTW"
date: 2011-01-09 12:08
author: CI Team
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}


<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 10px 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb331.png" width="170" height="93" />Once upon a time there was a group of developers on a Microsoft WebCamp with too much unused energy and the idea was born to create a "<a href="http://en.wikipedia.org/wiki/Buzzword_bingo">Bulshit-Bingo-Online-Version</a>" as a Demo MVC project. As Open Source of course! Now we are proudly presenting our first big step...</p>
<p>Try it out here: <a href="http://www.bizzbingo.com">www.bizzbingo.com</a></p>  

<p><b>Little introduction story</b></p>  

<p>On the <a href="http://www.webcamps.ms/#munich_panel">WebCamp in Munich in June 2010</a> we´ve got a little quest to solve: develop a Demo MVC WebApp. The team I (Robert) and Torsten Hufsky boiled up at this time consists of 4/5 nice follows of mine and they are from Dresden too:</p>
<p>Â· <a href="http://twitter.com/kenkosmowski">Ken Kosmowski</a></p>
<p>Â· Tom Miller</p>
<p>Â· <a href="http://twitter.com/oliverguhr">Oliver Guhr</a></p>
<p>Â· <a href="http://twitter.com/TorstenHu">Torsten Hufsky</a></p>
<p>Â· Robert MÃ¼hsig </p>
<p>To say the true, we didn´t reach a lot on this first day but we have ideas and the project was already published on <a href="http://businessbingo.codeplex.com/">Codeplex</a>. We planned to create a "<a href="http://en.wikipedia.org/wiki/Buzzword_bingo">Bullshit/Buzzword Bingo</a>" - but as an online game. But we are far away from this today but for me it becomes a little hobby project now. </p>
<p>After the WebCamp was over the development falls into sleep but Ken and Robert are still working on it to try out some interesting technics. </p>
<p><b>Technic/ Architecture </b></p>  

<p>To save our files we used a Microsoft SQL databank and as a "Frontend Framework" for the web component ASP.NET MVC 3 - the whole thing is on Windows Azure / SQL Azure. For the "Architecture" we are planning to make a gentle try with <a href="http://www.udidahan.com/2009/12/09/clarified-cqrs/">CQRS</a>.</p>
<p>At the moment we are (still) using a data source but the idea behind CQRS is that Queries do a kind of "Cache".</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image108.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb17.png" width="496" height="242" /></a></p>
<p>Commands: Delete / Create / Update </p>
<p>Queries: Read</p>
<p>Here are some of the frameworks we have used. </p>  

<p><b>Applikations-Frameworks:</b></p>
<p>Â· ASP.NET MVC 3</p>
<p>Â· .NET 4.0</p>
<p>Â· Entity Framework fÃ¼r Datenzugriff</p>
<p>Â· Castle Windsor fÃ¼r IoC</p>
<p>Â· jQuery</p>
<p>Â· <a href="http://www.frontendmatters.com/projects/fem-css-framework/">FEM CSS Grid</a></p>
<p><b>Test-Frameworks:</b></p>  

<p>Â· NUnit</p>
<p>Â· Moq for Mocking</p>
<p><b>Build / Deployment:</b></p>
<p>Â· Powershell to deploy the SQL Scripts</p>
<p>Â· MSBuild</p>
<p>Â· Azure SDK</p>
<p><b>miscellaneous:</b></p>  

<p>Â· Azure SDK isn´t used in any project at the moment but here you will find a description of the hosting.</p>
<p>Â· <a href="http://www.ndepend.com/">NDepend</a> for Codeanalyse</p>
<p>Â· <a href="http://www.jetbrains.com/teamcity/">TeamCity</a> as Buildserver</p>
<p>Â· The tests are done after the example of <a href="http://blog.thomasbandt.de/39/2326/de/blog/tdd-bdd-status-quo.html">Thomas Badts blogpost</a> (unfortunately it´s only available in german language) - more details how we structured the tests will follow soon or you check it out by yourself <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile7.png" /></p>
<p><b>The Solution</b></p>  

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image410.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image4_thumb.png" width="238" height="382" /></a></p>
<p>Here you can see our actual solution. Our current status you are able to see on <a href="http://businessbingo.codeplex.com/">our Codeplex side</a>. </p>
<p>Web = MVC Frontend </p>
<p>Queries/QueryHandlers = "Read" order </p>
<p>Commands / CommandsHandlers = "writing" orders</p>
<p>Data = Entity Framework &amp; Mapping to the Model</p>
<p>Model = POCOs</p>
<p>Installer = IoC Konfiguration </p>
<p>We also used a lot of time for the tests. Little special on our "Unit Tests":</p>
<p>Data.Tests are throw the file bank and they are testing the repositories. Because of this the databank will be performed, if needed automatically, by SQL scripts, which are located on the database folder. </p>
<p>IntegrationTests are testing the whole System and start at the controller - they are not really "WebTests" or "BrowserTests"</p>
<p>Both kinds of Tests are creating a test databank at the beginning with consistent effective - constructing on a SQL script.</p>  

<p><b>So what is this website suposed to do? </b></p>
<p>Visitors will find a random created set of "Buzzwords":</p>
<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb334.png" width="438" height="241" /></p>
<p>If you are on a (boring) meeting you have to click on the words which are used by the speakers in you meeting. (yes, it´s possible to cheat but you don´t have to <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile7.png" /> )</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image131.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image13_thumb.png" width="444" height="242" /></a></p>
<p>As soon as you have 4 words in one row you win the game:</p>
<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb336.png" width="433" height="267" /></p>
<p>That´s it for now. You can choose between English and a German version and you don´t have to register yourself.</p>
<p>Why are we doing a Postback? Because we have lots of ideas left and we want a really online game. Yes, a Postback isn´t in time now a day but it´s enough for us at the moment. </p>
<p><b>Source Code? </b></p>  

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image171.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image17_thumb.png" width="262" height="87" /></a></p>
<p>We use CodePlex (and with this TFS). You are welcome to take a look on the source code <a href="http://businessbingo.codeplex.com/">here</a>. </p>
<p>Try? Feedback?</p>
<p>If you want to try it click <a href="http://www.bizzbingo.com/">here</a>. And of course we are thankful for every kind of feedback either here or in our <a href="http://bizzbingo.uservoice.com/forums/94165-general?lang=de&amp;utm_campaign=Widgets&amp;utm_content=tab-widget&amp;utm_medium=Popin+Widget&amp;utm_source=bizzbingo.uservoice.com">UserVoice forum</a>. We will go on working on this project and maybe it will be a little help for anyone of you out there. Some of our future blogposts will be about this subject and take a deeper look on some aspects like for example Unit Testing or how to do Database Tests.</p>
