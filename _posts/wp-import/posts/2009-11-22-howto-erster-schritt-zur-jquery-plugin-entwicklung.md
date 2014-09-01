---
layout: post
title: "HowTo: Erster Schritt zur jQuery Plugin-Entwicklung"
date: 2009-11-22 23:55
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, Javascript, jQuery, Plugin]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image872.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; margin: 0px 10px 0px 0px; border-right-width: 0px" height="68" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb57.png" width="159" align="left" border="0"></a> </p> <p>Wer mit Javascript irgendwelche tollen Sachen machen möchte, kann dies natürlich alles selbst schreiben oder er nimmt sich ein vorgefertiges Framework und fügt ein paar Features hinzu. In diesem Blogpost will ich nur sehr kurz mal den Einstieg in die <a href="http://jquery.com/">jQuery</a> Plugin Entwicklung zeigen.</p><p><strong>Javascript ist der Teufel!!!</strong></p> <p>Erstmal vorweg: Viele .NET Entwickler haben direkt Angst vor Javascript. So schwierig ist es nicht und <em>("im gewissen Sinne")</em> ist auch <a href="{{BASE_PATH}}/2007/11/16/howto-objektorientierte-programmierung-oop-in-javascript-eine-einfache-klasse-erstellen/">Objektorientierung</a> enthalten. Zudem kann man mit Javascript echt nette Sachen machen, wie man z.B. an den <a href="http://team.sfi.vn/post/37-More-Shocking-jQuery-Plugins.aspx">unzähligen jQuery Plugins</a> sieht.</p> <p><strong>jQuery Plugin - wie fängt man an:</strong></p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:01723f27-d4f7-487b-b49f-9ff06638a5b3" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    (function($) {
        $.fn.fooBarTest = function() {

	// plugin code

        };
    })(jQuery);</pre></div>
<p>Hiermit hängen wir nun an "$" eine Funktion "fooBarTest" an. Diese kann ich einfach über "$(SELEKTOR).fooBarTest()" aufrufen.</p>
<p><strong>Iterationen</strong></p>
<p>Durch den Selektor können natürlich mehrere Elemente von der Funktion "betroffen" sein. Dafür kann man innerhalb mit "each" die Elemente durchlaufen. Für jedes Element gebe ich einfach ein alert aus.</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:83894490-63b7-48d5-8e29-59e053c0f278" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    (function($) {
        $.fn.fooBarTest = function() {

            return this.each(function() {
                var $e = $(this);
                alert($e);
            });

        };
    })(jQuery);
</pre></div>
<p>Im Grunde sehr einfach. </p>
<p><strong>Anwendung:</strong></p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b177e97c-3d71-42a2-a2e7-3f51398dcf83" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    $(document).ready(function() {
        $(".page").fooBarTest();

        $("li").fooBarTest();
    });</pre></div>
<p><strong>Besseres Beispiel</strong></p>
<p>Auf <a href="http://woorkup.com">diesem Blog</a> gibt es eine wesentlich genauere Beschreibung und von da habe ich auch meine Informationen. Ich merke mir am besten was, wenn ich es einfach mal ausprobiere ;)<br>In einem der nächsten Blogposts möchte er auch zeigen, wie man z.B. Parameter mitgibt.<br><strong>Nachtrag: </strong><a href="http://woorkup.com/2009/11/29/jquery-lesson-series-how-to-add-options-to-plugins/">jQuery Lesson Series: How to Add Options to Plugins</a></p>
<p>Für alle Interessierten: <a href="http://woorkup.com/2009/11/19/jquery-lesson-series-how-to-implement-your-first-plugin/?utm_source=feedburner&amp;utm_medium=feed&amp;utm_campaign=Feed%3A+Woork+(Woork+Up+|+A+Fresh+Charge+of+Creativity)&amp;utm_content=Google+International">jQuery Lesson Series: How to Implement Your First Plugin</a></p>
<p><strong>jQuery Informationen</strong></p>
<p>Hier noch ein paar nette Blogs über jQuery:</p>
<ul>
<li><a href="http://jquery-howto.blogspot.com/">JQuery HowTo</a> 
<li><a href="http://jqueryfordesigners.com/">Welcome to jQuery for Designers</a> 
<li><a href="http://blog.jqueryui.com/">jQuery UI</a> 
<li><a href="http://blog.jquery.com/">jQuery Blog</a> 
<li><a href="http://ejohn.org/">John Resig (jQuery Erfinder)</a></li></ul>
