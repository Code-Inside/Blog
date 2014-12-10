---
layout: post
title: "HowTo: Understanding Interfaces - a simple description"
date: 2009-03-18 01:27
author: codemin
comments: true
categories: [HowTo]
tags: [HowTo, Interfaces]
language: en
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image78.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="108" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb89.png" width="108" align="left" border="0" /></a> Interfaces are an important feature for designing great software, but many programming newbies have a understanding problem - Why should I use &quot;interfaces&quot;? What is an &quot;interface&quot;?</p>  <p>&#160;</p> 
<!--more-->
  <p><strong>A very simple sample</strong>    <br />I would like to create 3 types (Train, Car, Human) in my (very simple, not real world) sample. Each type is movable and that&#180;s why I want to create the &quot;IMovable&quot; interface.&#160; <br />To move these types I implement a&#160; &quot;God&quot; class which can move these objects as he wishes. (I know - it&#180;s a very real sample ;) ).</p>  <p><strong>Structur:</strong></p>  <p><a href="http://code-inside.de/blog/wp-content/uploads/image170.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="186" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image-thumb149.png" width="240" border="0" /></a></p>  <p>The most important thing is our &quot;<strong>IMovable</strong>&quot; interfaces (the name of an interface begins with &quot;I&quot; in .NET):</p>  <div class="CodeFormatContainer">   <pre class="csharpcode">    <span class="kwrd">public</span> <span class="kwrd">interface</span> IMovable
    {
        <span class="kwrd">void</span> Move();
    }</pre>
</div>

<p>You define methods, properties or events in the interface - it&#180;s a kind of a contract and the real implementation doesn&#180;t matter.</p>

<div class="CodeFormatContainer">
  <pre class="csharpcode">    <span class="kwrd">public</span> <span class="kwrd">class</span> Human : IMovable
    {
        <span class="preproc">#region</span> IMovable Member

        <span class="kwrd">public</span> <span class="kwrd">void</span> Move()
        {
            Console.WriteLine(<span class="str">&quot;The human take a step.&quot;</span>);
        }

        <span class="preproc">#endregion</span>
    }</pre>
</div>

<p>Our human implements the interface - and &quot;take a step&quot; to &quot;Move&quot;. The signature of the methods must be equal to the method of the interface (parameters, return value)!</p>

<p><strong>Implementing god
    <br /></strong>Now it&#180;s time to move! We implement now our God class with the &quot;MoveObject&quot; method. It takes an item which implement the &quot;IMovable&quot; interface:</p>

<div class="CodeFormatContainer">
  <pre class="csharpcode">    <span class="kwrd">public</span> <span class="kwrd">class</span> God
    {
        <span class="kwrd">public</span> <span class="kwrd">static</span> <span class="kwrd">void</span> MoveObject(IMovable item)
        {
            Console.WriteLine(<span class="str">&quot;God moves something...&quot;</span>);
            item.Move();
        }
    }</pre>
</div>

<p>The method &quot;<strong>MoveObject</strong>&quot; takes anything that implements the interface - the concret type doesn&#180;t matter! You can now put a car, train, human or another type in it - as long as it implements the &quot;<strong>IMovable</strong>&quot; interface!</p>

<p><a href="http://code-inside.de/blog/wp-content/uploads/image171.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="144" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image-thumb150.png" width="429" border="0" /></a></p>

<p>Now we can create many classes which implement the interface and we don&#180;t need to change anything in our God class!</p>

<p>Our test program:</p>

<div class="CodeFormatContainer">
  <pre class="csharpcode">    <span class="kwrd">class</span> Program
    {
        <span class="kwrd">static</span> <span class="kwrd">void</span> Main(<span class="kwrd">string</span>[] args)
        {
            Car BMW = <span class="kwrd">new</span> Car();
            Train ICE = <span class="kwrd">new</span> Train();
            Human Robert = <span class="kwrd">new</span> Human();

            God.MoveObject(BMW);
            God.MoveObject(ICE);
            God.MoveObject(Robert);

            Console.ReadLine();
        }
    }</pre>
</div>

<p>We have a train, a BMW and me - the result (the original source code was in german, I just translated it in this post) :</p>

<p><a href="http://code-inside.de/blog/wp-content/uploads/image172.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="244" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image-thumb151.png" width="489" border="0" /></a></p>

<p><strong><a href="http://code-inside.de/files/democode/usinginterfaces/usinginterfaces.zip" target="_blank">[ Download Source Code ]</a></strong></p>
