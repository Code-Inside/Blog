---
layout: post
title: "HowTo: object orientated programming / OOP in Javascript (create a simple class)"
date: 2010-12-13 12:12
author: CI Team
comments: true
categories: [HowTo]
tags: [class, Javascript, OOP, programming]
language: en
---
{% include JB/setup %}

  <p>Because of the increasing hype about AJAX and the "file-format" JSOPN, another subject in the field of web-developmen gets more and more interesting: Javascript-development.</p>  <p>All in all, in my opinion a little change is happening to web-development - we try to realize many things on the client. </p>  <p>I appreciate this change because, why should I communicate with the server while sorting a chart when the files are already on the client?</p>  <p>Exactly these are the types of assignments that are done by Javascript-Frameworks today. In Microsoft´s ASP.NET AJAX Extensions you will find a client-library as well. But there is a general question: How is it possible to encapsulate files in such a Framework? How is it possible to define own Javascript classes with methods?</p>  
  <!--more-->  <p><b>Defining classes and methods in Javascript - Keyword "prototype" </b></p>  <p>Prototype is not only a keyword in the fields of Javascript Framework for defining methods, also in the world of JS.</p>  <p>But step by step now.</p>  <p>We create a very simple example: a rectangle. The attributes are width and height and we just want to know the area. </p>  <p><b>Step 1: defining the constructor including member</b></p>  <pre>function Rectangle()
    {
        this.height;
        this.width;
    }</pre>

<p>In fact, the constructor is a normal JS function because the keyword "class" doesn´t exist in JS. After that we tell them our two attributes "width" and "height" and as usual in OOP beginning with "this".</p>

<p><b>Step 2: defining getter/setter </b></p>

<p>Of course it´s possible to pass the files directly to the constructor ("<i>Rectangle(10, 5)"</i>) but today we are going to use the getter/setter method where the "prototype" is important for:</p>

<pre> Rectangle.<strong>prototype</strong>.setHeight = function(value)
    {
            this.height = value;
    }
    Rectangle.<strong>prototype</strong>.getHeight = function()
    {
            return this.height;
    } </pre>

<p>We are going to "prototype" the rectangle and tell them, that we have a "setHeight" and a "getHeight" function and both have access to the attributes of the class with the keyword "this".</p>

<p>Same thing for the other attribute of course. </p>

<p><b>Step 3: create Calc method</b></p>

<p>The method we need for the calculation of the area is as easy as we thought. "prototype" and reach the data via "this":</p>

<pre>Rectangle.prototype.calc = function()
    {
            var result = this.getWidth() * this.getHeight();
            return result;
    }    </pre>

<p><b>Step 4: create objects and test them</b></p>

<p>In the simple demo-application (bottom left) we create the objects in a JS Function which is called in the onload.</p>

<pre>function initApp()
    {
        var objectA = new Rectangle();
        objectA.setHeight(10);
        objectA.setWidth(2);

        var objectB = new Rectangle();
        objectB.setHeight(15);
        objectB.setWidth(3);

        alert(objectA.calc());
        alert(objectB.calc());
    }</pre>

<p><b>Step 5: result</b></p>

<p>It works. (tested IE7 and FF2);</p>

<p><img border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb130.png" width="193" height="169" /></p>

<p><img border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb131.png" width="193" height="169" /></p>

<p>A view into firebug shows us the hierarchy:</p>

<p><img border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb132.png" width="424" height="98" /></p>

<p><b>Continuative links:</b></p>

<p>I choose this simple example because I only found difficult alternatives in the Internet till now. If you want to learn more about this subject please take a look on <a href="http://mckoss.com/jscript/object.htm">this website</a>. </p>

<p><a href="http://code-developer.de/democode/jsoop/default.htm">[Source Code + Demoapplication]</a></p>
