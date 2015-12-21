---
layout: post
title: "HowTo: Google Instant Suchbox – verschiedene Styles in einem Input-Feld?"
date: 2010-10-17 15:14
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [HowTo, HTML, Input, Style]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1072.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb254.png" width="218" height="121" /></a>Ab und an komme ich auch in den Genuß mich mit der Grundmaterie des Webs auseinanderzusetzen: HTML. Ich hab mich gefragt, wie Google es geschafft hat, zwei Styles in einem Input-Feld zu mixen. Eigentlich ist es einfach...</p>  <p></p>  <p><strong>Zwei Styles - "eine” Input Box:</strong></p>  <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1073.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb255.png" width="137" height="71" /></a> </p>  <p>"Autocomplete” Textboxen sind ja <a href="{{BASE_PATH}}/2009/08/27/howto-aspnet-mvc-und-jquery-autocomplete/">alt</a>, aber ein Detail ist bei Google noch ganz nett umgesetzt: Mein Suchwort "Tel&quot; (schwarze Buchstaben) wird mit dem ersten Ergebnis quasi fortgeführt (der ausgegraute Text). Wie geht das?</p>  <p><strong>Html Input Felder - nur 1 Style</strong></p>  <p>Ein HTML Input Feld kann man stylen wie man lustig ist, allerdings kann man nicht verschiedene Schriftfarben in einem Feld mixen.</p>  <p><strong>Der Trick</strong></p>  <p>Da das HTML von Googles Startseite etwas komplexer ist, hab ich im Internet etwas rumgeschaut wo es was ähnliches gibt: <a href="http://apps.tutorboy.com/youtube-instant-search/">YouTube Instant</a> (ich glaub der clevere Entwickler arbeitet nun auch bei YouTube/Google ;) ) - weniger komplex und von dort hab ich mal die Input-Box nachgebastelt:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1074.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb256.png" width="178" height="47" /></a> </p>  <p>Es sind <strong>zwei Input Element übereinander</strong>. Der eine mit dem <strong>Textvorschlag</strong> ist <strong>grau</strong> und die eigentliche <strong>Suchbox</strong> ganz normal mit <strong>schwarzen</strong> Text.</p>  <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1075.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb257.png" width="506" height="63" /></a> </p>  <p>Hier das komplette HTML:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:9fa138ee-8739-4d07-9f51-c4ad09a2cfc4" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;html&gt;
&lt;head&gt; 

&lt;style&gt;
#searchBox {width:570px;float:right;border:1px solid #A2BFF0;}
#grayText, #search{
	background:none;
	position:absolute;
	width:540px;
	height:30px;
	z-index:100;
	padding-left:5px;
	
}
#queryBox {height:30px;}
#grayText {z-index:0;color:#C0C0C0;}
&lt;/style&gt;
&lt;/head&gt;
&lt;body&gt;
	&lt;div id="searchBox"&gt;
		&lt;input type="text" id="grayText" disabled="disabled" autocomplete="off" value="Das ist der Suchtext" size="60"&gt;
		&lt;input type="text" autocomplete="off" id="search" value="Das ist der" size="60" name="q"&gt;
	&lt;/div&gt;
&lt;/body&gt;
&lt;/html&gt;</pre></div>

<p>Jetzt versteh ich auch wie die <a href="http://plugins.jquery.com/project/maskedinput">Masked Input jQuery Plugins</a> funktionieren (also vielleicht - nachgeschaut habe ich nicht) : <a href="{{BASE_PATH}}/assets/wp-images-de/image1076.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb258.png" width="174" height="37" /></a> </p>

<p>Für alle HTML / CSS / Javascript Experten die über den Post nur müde lächeln können: Wie das vorher genau funktionierte war mir echt nicht bewusst - bin doch meistens nur im Backend mit .NET unterwegs. ;) </p>
