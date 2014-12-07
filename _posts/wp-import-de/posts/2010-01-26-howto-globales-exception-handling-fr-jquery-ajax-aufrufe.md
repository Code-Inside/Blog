---
layout: post
title: "HowTo: Globales Exception Handling für jQuery AJAX Aufrufe"
date: 2010-01-26 00:25
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Error, Exception, Global, Handling, HowTo, jQuery]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image909.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="93" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb94.png" width="93" align="left" border="0"></a>Eine schicke AJAX Anwendung ist heute schnell gebaut und viele Elemente werden über einen asynchronen Prozess erst geladen. Doch was passiert wenn ein serverseitiger Fehler auftaucht? Damit man nicht überall die "error" Events abfangen braucht, kann man das sehr leicht auch für <a href="http://api.jquery.com/ajaxError/">jQuery global</a> definieren.</p><p><strong>Ein "normaler" jQuery AJAX Aufruf:</strong></p> <p>Aus der <a href="http://api.jquery.com/jQuery.ajax/">jQuery AJAX</a> Dokumentation:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:1390eb17-c394-4c86-ab32-909ea871cf0d" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">$.ajax({
   type: "POST",
   url: "some.php",
   data: "name=John&amp;location=Boston",
   success: function(msg){
     alert( "Data Saved: " + msg );
   }
 });</pre></div>
<p>Hier wird ein jQuery AJAX Aufruf an "some.php" mit ein paar Daten gemacht. Im Erfolgsfall wird die success Funktion aufgerufen. Für den Fehlerfall (und einige andere) bietet jQuery noch die Möglichkeit Funktionen zu hinterlegen. (einfach eine error Funktion ähnlich wie success hinterlegen)</p>
<p><strong>Das Problem dabei:</strong> </p>
<p>In einem größeren Team wird es sicher einige Teammitglieder geben, die nicht an die Error-Funktion denken. Im Fehlerfall sollte dem Nutzer wenigstens gesagt werden, dass <a href="{{BASE_PATH}}/2009/04/28/howtocode-keep-it-simple-was-fliegt-dass-fliegt/">etwas schief gelaufen</a> ist. </p>
<p><strong>Die Lösung für jQuery:</strong></p>
<p>Bei jQuery kann man <a href="http://api.jquery.com/category/ajax/global-ajax-event-handlers/">"globale" Events</a> abfangen. Über <a href="http://api.jquery.com/ajaxError/">ajaxError</a> kann man z.B. elegant Fehlermeldungen ausgeben - auch wenn ein "alert" nicht unbedingt elegant ist ;)</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:57baa8b7-6fa9-4771-82ba-5c54eb596a01" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#"> $(document).ajaxError(function(e, xhr, settings, exception) {
                alert('Error!');
            });</pre></div>
<p>Die ganze Sache ist in 5 Minuten gemacht und gibt dem Nutzer in einem Fehlerfall jedenfalls eine Meldung aus - besser als nix :)</p>
<p><strong>Problemfall ASP.NET AJAX: </strong></p>
<p>Da die <strong>ASP.NET MVC AJAX</strong> Helper mit dem <strong>Microsoft AJAX</strong> gemacht sind, springt leider der jQuery ajaxErrorevent <strong>nicht</strong> an. Hat hier jemand eine clientseitige, globale Errorhandling Methode gefunden ohne diesen fürchterlichen Scriptmanager? </p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/globalajaxerrorhandling/globalajaxerrorhandling.zip">[ Download Democode ]</a></strong></p>
