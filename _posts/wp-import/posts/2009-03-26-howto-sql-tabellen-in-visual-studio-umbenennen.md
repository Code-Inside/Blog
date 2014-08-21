---
layout: post
title: "HowTo: SQL Tabellen in Visual Studio umbenennen"
date: 2009-03-26 00:23
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, SQL, Visual Studio]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image693.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="104" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb671.png" width="147" align="left" border="0" /></a>Die Integration von SQL Servern im Visual Studio ist sehr nett, nur selten nutze ich direkt das SQL Management Studio. Eine Sache nervt allerdings: SQL Tabellen umbenennen scheint nicht vorgesehen zu sein - &#252;ber einen kleinen kleinen Trick geht jedoch auch das direkt aus Visual Studio heraus.</p> 
<!--more-->
  <p><strong>Das Contextmen&#252;:</strong></p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image694.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="172" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb672.png" width="244" border="0" /></a> </p>  <p>Im Contextmen&#252; findet sich kein Rename oder &#228;hnliches und in den Properties ist auch der Name ausgegraut.</p>  <p><strong>Der Trick:</strong>    <br />Man f&#252;gt die Tabellen einem Datenbank Diagramm hinzu und kann dort den Namen im Eigenschaftsfenster &#228;ndern :)</p>  <p><em>Gefunden habe ich den Trick auf </em><a href="http://www.bbits.co.uk/blog/archive/2006/03/15/7660.aspx"><em>dieser Seite</em></a><em> - interessant </em><a href="{{BASE_PATH}}/2009/02/18/howto-sql-tabellen-beziehungen-erstellen-per-dragndrop/"><em>welche Features</em></a><em> in dem Diagram View stecken ;)</em></p>
