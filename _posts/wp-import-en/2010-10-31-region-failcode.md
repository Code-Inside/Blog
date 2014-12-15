---
layout: post
title: "#region == Failcode"
date: 2010-10-31 10:11
author: CI Team
comments: true
categories: [News]
tags: []
language: en
---
{% include JB/setup %}
<img title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb230.png" border="0" alt="image" width="191" height="191" align="left" />This is a very old subject. But thanks to a way to motivated workmate, who used to drop "regions" in every code, we talked about this subject again. Are #regions good or not?

For all of you who don´t know what the hell Im talking about: #region on <a href="http://msdn.microsoft.com/en-us/library/9a1ybwek(VS.71).aspx">MSDN</a>.

<br/><br/>
<!--more-->

Let´s take a look on an example:

<img title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb231.png" border="0" alt="image" width="142" height="203" />

"..." stands for countless other stuff.

<strong>First impression:</strong>

Nice and tidy.

<strong>But serious...</strong>

<strong> </strong>

Im interested in the Code not in any kind of blocks. With the use of #region the only thing you do is to shroud the code. When I open the user.cs I want to see the code on the first sight.

Yes, there is a hot key to make the code visual but why should I use this #region blocks?

<strong>Code Smell</strong>

<strong> </strong>

Often I find some #regions in classes where the code consists of endless lines to give it a little bit more structure.

For example you open a method and find this:

<img title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb232.png" border="0" alt="image" width="178" height="114" />

I have the problem that I even so want to see the code. So I click to open it.

<img title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb233.png" border="0" alt="image" width="181" height="211" />

Fascinating.... but wait... what happens on Y?

<img title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb234.png" border="0" alt="image" width="193" height="310" />

Every good thing is three.... What´s written behind Z?

<img title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb235.png" border="0" alt="image" width="202" height="346" />

Fantastic isn´t it? Of course the code in my example is nonsense but in fact there could be kilometres of code behind X,Y and Z.

<strong>Why I think #regions is useless sense of order:</strong>

<strong> </strong>

First fact: there is not a really advantage. Okay it looks nice on the first sight but in the end there is one possible conclusion:

There are too many responsibilities in this class and somebody try to hush this up. <strong>Better</strong>: Split it! And with this I didn´t mean into "Partial Classes" but into separate function units.

<strong>Interface Implementation:</strong>

Another example: Visual Studio always put interface implementations in #regions. I don´t think that´s nice (and its possible to stop it ;) ). Is it really helpful for structure? In my opinion there are way better opportunities since VS2010. So I don´t need any #regions.

<strong>In addition...</strong>

If you are creating "On-the-fly" codes (e.g. with the TDD Manier), Visual studio used to place the code somewhere as well. That proofs that the system of #regions is to be doomed to failure anyway.
