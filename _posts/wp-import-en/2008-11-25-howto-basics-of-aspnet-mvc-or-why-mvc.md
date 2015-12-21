---
layout: post
title: "HowTo: Basics of ASP.NET MVC or why MVC?"
date: 2008-11-25 01:47
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET, ASP.NET MVC, DRY, HowTo, MVC]
language: en
---
{% include JB/setup %}
<p>A while ago I blogged about some <a href="{{BASE_PATH}}/tag/aspnet-mvc/">ASP.NET MVC stuff</a>, but why should I (and you) care about ASP.NET MVC?    <br /><a href="http://asp.net/mvc">ASP.NET MVC</a> is a great and extensible framework for building web applications and <a href="http://www.hanselman.com/blog/DevConnectionsTheASPNETMVCFramework.aspx">is a alternative to the ASP.NET WebForms model</a>.</p>
<p><strong>Tell me more about &quot;MVC&quot;!&#160; <br /></strong>MVC stands for &quot;Model-View-Controller&quot;, which is a <a href="http://wikipedia.org/wiki/Model_View_Controller">very old (but still very useful) design pattern</a>. This design pattern will split your application in 3 different parts (&quot;model&quot;, &quot;view&quot;, &quot;controller&quot;). <a href="http://en.wikipedia.org/wiki/Separation_of_concerns">&quot;Seperation of concern&quot;</a> is one of it&#180;s main benefits.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb210.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="139" alt="image_thumb2" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb2-thumb.png" width="280" border="0" /></a>&#160;</p>
<p>Short description of these parts:</p>  <ul>   <li>&quot;Model&quot;: Represents your application data/model and has no(!) business logic</li>    <li>&quot;View&quot;: Just display the given viewdata (this could be a normal HTML page or JSON/RSS data)</li>    <li>&quot;Controller&quot;: The controller represents the business logic and create the view data and send it to a view.</li> </ul>
<p>A good example of an MVC application is the <a href="http://www.codinghorror.com/blog/archives/001112.html">web browser</a>.</p>
<p><strong>What is so &quot;bad&quot; about ASP.NET WebForms?</strong>    <br />ASP.NET WebForms include many abstractions for the web development. If you are a WinForms developer, you will feel comfortable with it, but if you started with PHP/JSP or just pure HTML and Javascript you will feel very uncomfortable.     <br />The &quot;viewstate&quot; is one feature to hide the stateless nature of HTML, but it can make your web application very slow and makes you crazy. The &quot;WebForms&quot; model include a very complex <a href="http://www.eggheadcafe.com/articles/20051227.asp">lifecycle</a> and it&#180;s&#160; important to understand this to work with ASP.NET WebForms.    <br />In my opinion it is too complex and the framework should embrace the nature of HTTP and don&#180;t hide it.</p>
<p>Disclaimer: If you feel comfortable with WebForms, you have no reason to change to MVC - <a href="http://www.hanselman.com/blog/DevConnectionsTheASPNETMVCFramework.aspx">MVC is only on option</a>.</p>
<p><strong>What are the benefits of ASP.NET MVC</strong>    <br />MVC is a very testable framework and you get full control of the rendering process. You can add functionality if you want, because MVC is very extensible and you can create a clean, <a href="http://en.wikipedia.org/wiki/DRY">DRY</a>, testable web application.     <br />Phil Haack (the program manager of ASP.NET MVC) did a <a href="http://channel9.msdn.com/pdc2008/PC21/">great presentation at the PDC</a>.</p>
<p><strong>Things that you&#180;ll maybe missing in MVC</strong>    <br />Many ASP.NET controls use the postback-functionality. This function will not work well together with the MVC framework. Phil Haack did also 2 podcasts on HerdingCode and tell some thought about &quot;the control story in MVC&quot;:    <br /><a href="http://herdingcode.com/?p=75">Part 1</a>    <br /><a href="http://herdingcode.com/?p=82">Part 2</a></p>
<p>If you have questions, please add a comment (and if my english really suck please let me know ;) ). This blogpost should only provide basics - other posts are planned.</p>
