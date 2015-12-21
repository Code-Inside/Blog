---
layout: post
title: "HowTo: CMD Parameter maskieren (“C:\Program' is not recognized…”)"
date: 2011-04-25 18:57
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [CMD]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1257.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb437.png" width="193" height="79" /></a> </p>  <p>Viele Tools kann man über die Windows Command Line aufrufen. Meistens will man dem Programm noch Parameter mitgeben. Dummerweise stört sich die CMD an Whitespaces (bekanntes Beispiel: Als Parameter eine Pfadangabe mit "Program Files”)). Da ich gestern etwas gefrustet war (und es eigentlich total einfach ist ;) ) blogge ich die simple Lösung jetzt...</p>  <p><strong>Beispiel</strong></p>  <p>Wir nutzen das Tool NDepend in unserem Buildprozess. Eine komplette Beschreibung ist hier. Der Aufruf ist so gedacht (der geht allerdings nicht so):</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d7f6e5b3-f90b-4991-8bc9-3fdefc6c9275" class="wlWriterEditableSmartContent"><pre name="code" class="c#">C:\Windows\system32\cmd.exe /s /c "C:\Program Files\NDepend\NDepend.Console.exe" "C:\Program Files (x86)\TeamCity\..." ...</pre></div>

<p>Problem ist der Part nach dem NDepend.Console.exe Aufruf - Grund: </p>

<p><strong>'C:\Program' is not recognized as an internal or external command, operable program or batch file.</strong></p>

<p><strong>Lösung:</strong> <strong>Die Parameter maskieren...</strong></p>

<p>&quot;<strong><u>\&quot;</u></strong>C:\Program Files (x86)\TeamCity\...<strong><u>\&quot;</u></strong>&quot;</p>

<p>Dann klappts auch mit der CMD ;)</p>

<p>Wie immer - <a href="http://stackoverflow.com/questions/2403647/how-to-escape-parameter-in-windows-command-line">Stackoverflow &lt;3</a>.</p>
