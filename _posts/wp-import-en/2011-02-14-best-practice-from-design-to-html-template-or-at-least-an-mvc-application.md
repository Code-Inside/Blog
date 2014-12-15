---
layout: post
title: "Best Practice: from Design to HTML Template or at least an MVC Application"
date: 2011-02-14 16:24
author: CI Team
comments: true
categories: [Best Practise]
tags: [Design, Html, MVC]
language: en
---
{% include JB/setup %}


<p><a href="{{BASE_PATH}}/assets/wp-images-en/image124.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb33.png" width="134" height="95" /></a>This blogpost is about my own experience in the fields of "How do I pass this cool Design into my cool MVC WebApp?". In little projects you are used to do it on your own but what happens, if this is not the case? (Beside you are used to be a talent in multitasking). </p>  
  

<p><b>Entire developing process of a WebApp </b></p>  

<p>Beware: It´s a developer speaking here. Maybe there are some other ways - but writing into and so on isn´t an option for me <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile12.png" /></p>
<p>A kind of esoteric subject but if you, or at least your customer, now what you want, you will find nice ideas about what your web application should do. Then there will be a designer who is painting around in Photoshop and now it´s getting difficult. Because who is going to put this into HTML? And who is writing the Code?</p>  

<p><b><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb355.png" width="494" height="103" /></b></p>
<p><b>Web designer = Web developer </b></p>  

<p>Like I said before, I´m a developer. Of course, I now some stuff about HTML and so on but in bigger or more professional projects I always try to get an HTML-guru (Web designer). The reason is, it´s not so easy to get perfect HTML (CSS structures. There are some stumbling blocks just like browser compatibility, semantic or recoverability. The HTML-guru builds HTML templates and the web developer takes these templates and connects them with this business logic. </p>
<p><b>Result of the web designer:</b></p>  

<p>Easy and static HTML (with CSS and pictures and so on) sides with all side elements on them. But there are some thinks you should keep in mind:</p>
<p>- Are there some error messages and where are they shown?</p>
<p>- If you have used Javascript frameworks you should test if they render some standard element out like for example jQuery will pass out error messages into a specific structure</p>
<p>- Are there some areas where "loading icons" for AJAX should be?</p>
<p>- Elements should fit all the time. In the best case you should create a form-style which you can use as often as you want to</p>
<p>- And also you need to take a look on some overlays or implementation from extern services like for example Google Maps</p>
<p>It doesn´t matter with what the designer works but it could be an advantage to put his results under a version control.</p>
<p>The reason for the simple web site: I don´t know any web designer who is working with Visual Studio or the expression products to "produce" HTML. In fact, they don´t need to do so anyway. You can send the result to your boss or your customer because he will find any important elements on it. It´s also possible to create click dummies (with some work). </p>
<p>But for me more important: the web designer is never in touch with the ASP.NET MVC project. Also the markup would be much prettier with razor there is a lot of thought in the views about which areas are send out into the "partials" - maybe the web designer don´t know this.</p>
<p>But what happens, if you want to change the design?</p>
<p>In this case it is possible to send the statistic website to somebody and give him the order to send back something in the same form. </p>
<p><b>The awkward part of the work </b></p>  

<p>As web developer you have to spread the HTML construct and put them into the fitting views in partials or masterpages and so on. For me I do not write into the CSS anymore and in the case of an error (like for example problems with the browser view) I inform the designer and he is able to look it up on the statistic HTML side, fix it without the help of foreign systems and send the CSS back to me.</p>
<p><b>Example</b></p>
<p>As a "little" example we created a statistic side with all elements at <a href="http://www.bizzbingo.de/">BizzBingo (Codeplex).</a> The stripes in the background are from the <a href="http://www.frontendmatters.com/projects/fem-css-framework/">CSS Grid Framework</a>. To say the true, in this project I´m developer and designer in one person but it´s just for fun. </p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image125.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb34.png" width="240" height="222" /></a>The template isn´t that exiting but it´s quit helpful while discussing the several side elements. If we are going to find an HTML-guru he (or she) can start working without MVC magic or data base stuff. Just HTML.</p>
