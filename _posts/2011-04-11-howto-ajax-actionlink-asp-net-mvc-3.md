---
layout: post
title: "HowTo: AJAX Actionlink & ASP.NET MVC 3"
date: 2011-04-11 23:33
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [AJAX, ASP.NET MVC, HowTo]
---
<p><a href="{{BASE_PATH}}/assets/wp-images/image1241.png"><img style="border-right-width: 0px; margin: 0px 10px 0px 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb421.png" width="163" height="107" /></a> </p>  <p>Im MVC Framework gibt es ein paar kleine Helferlein und über die AJAX Helper hatte ich bereits <a href="http://code-inside.de/blog/2009/08/25/howto-ajax-und-aspnet-mvc/">vor einiger Zeit geschrieben</a> - allerdings hat sich die Funktionalität ein klein wenig geändert, daher hier jetzt das Update.</p> <!--more-->  <p><strong>Problemfall: AJAX Actionlink liefert neue Seite zurück</strong></p>  <p>Wir haben ein Standard MVC 3 Web Projekt und folgende Zeile soll einfach nur einen Link erzeugen, welcher bei Knopfdruck ein View per AJAX nachlädt und in das "Result” Div reinsetzt:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ffd83d40-ebc2-49c2-a2e1-dcee5333b293" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    @Ajax.ActionLink("Foobar load", "Foobar", "Home", new AjaxOptions() { HttpMethod = "Get", UpdateTargetId = "Result" })</pre></div>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1242.png"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb422.png" width="350" height="105" /></a> </p>

<p></p>

<p>Nach dem Knopfdruck sollte eigentlich per AJAX der View geladen werden, allerdings wird kein AJAX Request ausgelöst. Warum?</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1243.png"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb423.png" width="220" height="103" /></a>&#160;</p>

<p><strong>Javascript Bibliotheken fehlen</strong></p>

<p>In der Standard-Masterpage ist bereits jQuery verlinkt, was allerdings noch fehlt ist die AJAX Bibliothek. Vor MVC3 waren dafür die MS AJAX Bibliotheken da - diese brauchen wir jetzt aber nicht mehr.</p>

<p>Für AJAX benötigen wir noch zusätzlich die jQuery.unobtrusive-ajax.js (bzw. die min.js) Datei!</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1244.png"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb424.png" width="260" height="297" /></a> </p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:444b96ac-250c-42f0-aa49-a792c96e4570" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
    ...
    &lt;script src="@Url.Content("~/Scripts/jquery-1.4.4.min.js")" type="text/javascript"&gt;&lt;/script&gt;
    &lt;script src="@Url.Content("~/Scripts/jquery.unobtrusive-ajax.min.js")" type="text/javascript"&gt;&lt;/script&gt;
&lt;/head&gt;
...</pre></div>

<p></p>

<p></p>

<p>Ein Blick ins HTML bringt vielleicht auch eine kleine Überraschung:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1245.png"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb425.png" width="568" height="54" /></a> </p>

<p>Falls das bei jemanden anders aussieht: Wichtig sind noch folgende Einstellungen in der Web.config (diese sind allerdings bei neuen Projekten Standard)</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a6846b87-85dc-405f-9969-3d4065855837" class="wlWriterEditableSmartContent"><pre name="code" class="c#">  &lt;appSettings&gt;
    &lt;add key="ClientValidationEnabled" value="true"/&gt; 
    &lt;add key="UnobtrusiveJavaScriptEnabled" value="true"/&gt; 
  &lt;/appSettings&gt;</pre></div>

<p></p>

<p><strong>Unobtrusive Javascript? What?</strong></p>

<p>Um was geht es eigentlich bei den "unobtrusive Javascript” Sachen? Ganz allgemein geht es darum, dass die Seite auch ohne Javascript trotzdem noch "bedienbar” bleibt und z.B. kein JS Eventhandler direkt im a-Tag reingehangen wird. Dies wird über die data- Attribute mit "angehangen.</p>

<p>Hier ein Screenshot aus einer <a href="http://simonwillison.net/static/2008/xtech/">tollen Präsentation</a> über das Thema:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1246.png"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb426.png" width="329" height="248" /></a></p>

<div style="width: 425px" id="__ss_390708"><strong style="margin: 12px 0px 4px; display: block"><a title="Unobtrusive JavaScript with jQuery" href="http://www.slideshare.net/simon/unobtrusive-javascript-with-jquery">Unobtrusive JavaScript with jQuery</a></strong> <iframe height="355" marginheight="0" src="http://www.slideshare.net/slideshow/embed_code/390708" frameborder="0" width="425" marginwidth="0" scrolling="no"></iframe>

  <div style="padding-bottom: 12px; padding-left: 0px; padding-right: 0px; padding-top: 5px">View more <a href="http://www.slideshare.net/">presentations</a> from <a href="http://www.slideshare.net/simon">Simon Willison</a> </div>
</div>

<p><strong>Pures jQuery</strong></p>

<p>Natürlich braucht man die AJAX Helper nicht zu nutzen, es würde auch mit jQuery Standardmitteln gehen:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b87c5977-dadd-4bba-8615-f9bcf880f7c4" class="wlWriterEditableSmartContent"><pre name="code" class="c#">$(function() {
    $('#mylink').click(function() {
        $('#AjaxTestDiv').load(this.href);
        return false;
    });
});</pre></div>

<p>Wie immer eine große Hilfe bei der Problemlösung: <a href="http://stackoverflow.com/questions/4973605/ajax-actionlink-not-working-response-isajaxrequest-is-always-false">Stackoverflow</a> :)</p>

<p><strong>[ </strong><a href="{{BASE_PATH}}/assets/files/democode/mvc3ajaxactionlink/mvc3ajaxactionlink.zip"><strong>Download Sample Code</strong></a><strong> ]</strong></p>
