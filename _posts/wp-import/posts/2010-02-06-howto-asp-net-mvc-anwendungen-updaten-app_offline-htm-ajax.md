---
layout: post
title: "HowTo: ASP.NET MVC Anwendungen updaten - App_Offline.htm & AJAX"
date: 2010-02-06 00:38
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [AJAX, App_Offline, ASP.NET MVC, HowTo, Update]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image920.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="99" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb105.png" width="111" align="left" border="0"></a> Um eine ASP.NET Anwendung umzudaten ist es oftmals auch nötig bestimmt dlls auszutauschen. Dazu muss natürlich auch die Anwendung runtergefahren werden. Mit ASP.NET 2.0 kam ein nettes Feature hinzu: Das <a href="http://weblogs.asp.net/scottgu/archive/2006/04/09/442332.aspx">App_Offline.htm.</a> Mit diesem File kann man neue Requests abfangen und auch für AJAX Calls gibt es einen Workaround.</p><p><strong>App_Offline.htm</strong></p> <p>Legt man ein File namens "App_Offline.htm" in den Web-Root <a href="http://stackoverflow.com/questions/1153449/asp-net-2-0-how-to-use-appoffline-htm">leitet der IIS</a> alle <strong><a href="http://stackoverflow.com/questions/179556/will-appoffline-htm-stop-current-requests-or-just-new-requests">neuen</a></strong> Requests an dieses File weiter. Damit ist es möglich, dass man Usern während des Update Prozesses eine Informationsseite zu präsentieren. Diese Updateseite wird mit dem HTTP Code 404 ausgeliefert. </p> <p><strong>"IE Problem"</strong></p> <p>Es soll wohl bei dem IE zu Problemen kommen, wenn die Updateseite zu klein ( kleiner als 512 byte ) ist - dann stellt der IE seine eigene Fehlerseite dar. Hier reicht es einfach das HTML durch Kommentare etc. "aufzublähen".<br>Hier das <a href="http://weblogs.asp.net/scottgu/archive/2006/04/09/442332.aspx">Beispiel</a> von ScottGu:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e45fb7ac-dd65-4cb5-9048-8e3c6b7f2b77" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"&gt;

&lt;html xmlns="http://www.w3.org/1999/xhtml" &gt;

&lt;head&gt;

    &lt;title&gt;Site Under Construction&lt;/title&gt;

&lt;/head&gt;

&lt;body&gt;

    &lt;h1&gt;Under Construction&lt;/h1&gt;

 

    &lt;h2&gt;Gone to Florida for the sun...&lt;/h2&gt;

   

&lt;!--       

    Adding additional hidden content so that IE Friendly Errors don't prevent

    this message from displaying (note: it will show a "friendly" 404

    error if the content isn't of a certain size).

   

    &lt;h2&gt;Gone to Florida for the sun...&lt;/h2&gt; 

    &lt;h2&gt;Gone to Florida for the sun...&lt;/h2&gt; 

    &lt;h2&gt;Gone to Florida for the sun...&lt;/h2&gt; 

    &lt;h2&gt;Gone to Florida for the sun...&lt;/h2&gt; 

    &lt;h2&gt;Gone to Florida for the sun...&lt;/h2&gt; 

    &lt;h2&gt;Gone to Florida for the sun...&lt;/h2&gt; 

    &lt;h2&gt;Gone to Florida for the sun...&lt;/h2&gt; 

    &lt;h2&gt;Gone to Florida for the sun...&lt;/h2&gt; 

    &lt;h2&gt;Gone to Florida for the sun...&lt;/h2&gt; 

    &lt;h2&gt;Gone to Florida for the sun...&lt;/h2&gt; 

    &lt;h2&gt;Gone to Florida for the sun...&lt;/h2&gt; 

    &lt;h2&gt;Gone to Florida for the sun...&lt;/h2&gt; 

    &lt;h2&gt;Gone to Florida for the sun...&lt;/h2&gt;     

--&gt;

&lt;/body&gt;

&lt;/html&gt;</pre></div>
<p><strong>Resultat</strong></p>
<p>Wenn das File nun ins Webroot gelegt wird, wird nur das ausgegeben.</p>
<p><strong>AJAX Problem</strong></p>
<p>Was noch zu Problemen führen könnte wären WebApps in den AJAX eingesetzt wird. Die Webseite ist komplett geladen und der User klick fröhlich rum. Dann geht er einen Kaffee holen und in dieser Zeit aktualisieren wir die Anwendung. Jetzt wäre es natürlich schade wenn der nächste AJAX Call einfach nur ins Leere laufen würde - etwas schöner wäre ja, wenn man den Nutzer wenigstens sagt, dass die Anwendung gerade gewartet wird.</p>
<p><strong>Lösung</strong></p>
<p>Wie <a href="http://weblogs.asp.net/mschwarz/archive/2006/04/11/App_5F00_Offline.htm-and-Ajax.NET-Professional.aspx">hier vorgeschlagen</a> habe ich einfach einen besonderen HTML Kommentar in die Fehlerseite mit eingebaut:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:1803eea8-a55a-4776-bd26-1d22da5e0702" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;!--[AJAX_APP_OFFLINE_FLAG]--&gt;   </pre></div>
<p>Jetzt kann ich z.B. über ein <a href="{{BASE_PATH}}/2010/01/26/howto-globales-exception-handling-fr-jquery-ajax-aufrufe/">globales AJAX Exception Handling</a> schauen ob dieser "Flag" vorkommt und wenn ja eine nettere Fehlermeldung ausgeben:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:32d1d7f5-f30d-4460-a03a-7b8d2de3c9b5" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">$(document).ajaxError(function(e, xhr, settings, exception) {
            alert('Error!');

            var responseText = xhr.responseText;
            if (responseText.indexOf("&lt;!--[AJAX_APP_OFFLINE_FLAG]--&gt;") != -1) {
                alert("Site update in progress... keep cool :)");
            }
            else {
                alert('Real error! OMG!');
            }

        });</pre></div>
<p><strong>Resultat für den normalen Aufruf:</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image921.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="123" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb106.png" width="244" border="0"></a> </p>
<p><strong>Resultat für AJAX Aufrufe:</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image922.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="88" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb107.png" width="244" border="0"></a> </p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image923.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="88" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb108.png" width="244" border="0"></a> </p>
<p><strong>Hinweis:</strong></p>
<p>Damit der erste Aufruf bei euch funktioniert habe ich die "App_Offline.htm" mal in "xApp_Offline.htm" umbenannt. </p>
<p><strong>Javascript und CSS Datein:</strong></p>
<p>Sobald der IIS die App_Offline.htm entdeckt wird nur dieses File ausgeliefert. Somit kann man in der App_Offline.htm keine CSS Datei einbinden die in dieser Webapplikation liegt!</p>
<p><strong>Frage in die Runde:</strong></p>
<p>Wie ist eure Strategie wenn es um das Updaten von Anwendungen geht? </p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/mvcappoffline/mvcappoffline.zip">[ Download Democode ]</a></strong></p>
