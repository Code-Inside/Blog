---
layout: post
title: "HowTo: Form Values/Inputs über AJAX mit jQuery serialize übertragen"
date: 2010-02-09 08:45
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [AJAX, Form, HowTo, jQuery, serialize]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image927.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="96" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb112.png" width="127" align="left" border="0"></a>Wenn man viele Daten über AJAX übertragen möchte muss man ein klein wenig basteln - oder <a href="http://api.jquery.com/serialize/">jQuery.serialize()</a> nehmen. Damit kann man Form Daten sehr einfach in einen String serialisieren und via AJAX absenden.</p><!--more--> <p><strong>Das Problem</strong></p> <p>Wir haben bestimmte Daten die wir per AJAX versenden müssen. Wenn die Anzahl auch noch variable ist und vielleicht vom Benutzer beeinflusst werden kann, wird es noch etwas kniffliger.</p> <p>Hier mal ein ganz normaler <a href="http://api.jquery.com/jQuery.ajax/">AJAX Call mit jQuery</a>:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:537ecc04-0f33-4c30-860e-28e5da2abfae" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">$.ajax({
   type: "POST",
   url: "some.php",
   data: "name=John&amp;location=Boston",
   success: function(msg){
     alert( "Data Saved: " + msg );
   }
 });</pre></div>
<p>Im "Data" werden die Daten mitgegeben, welche gesendet werden sollen. Wenn man nun eine variable Länge an Daten hat muss man sich diesen string ja selbst erzeugen und das kann etwas mühe machen (gut - für die jQuery Experten ein 3 Zeiler ;) ).</p>
<p><strong>jQuery.serialize()</strong></p>
<p>Mit <a href="http://api.jquery.com/serialize/">jQuery.serialize()</a> geht es aber auch in einem Einzeiler. Man übergibt einen <a href="http://api.jquery.com/category/selectors/">jQuery Selector</a> und jQuery baut einen string zusammen, den wir als Data verwenden können:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:8363cf57-c484-4cfc-bbd4-89f706acc388" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        function sendFormvalues() {
        
            var data = $("form :input").serialize();
            alert(data);
            $.ajax({
                type: "POST",
                url: "&lt;%=Url.Action("LogOn","Account") %&gt;",
                data: data,
            });
        }</pre></div>
<p>In der ersten Zeile der Funktion geb ich mittels eines <a href="http://api.jquery.com/category/selectors/">Selectors</a> an, welche Daten ich alles haben möchte (alle Input Felder) und über serialize bekomm ich meinen String. Den kann ich dann als Data mit angeben und fertig :)</p>
<p>Hier mal zur Verdeutlichung was jQuery mit dieser Form macht:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image928.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="222" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb113.png" width="244" border="0"></a> </p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image929.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="123" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb114.png" width="489" border="0"></a></p>
<p>Bis auf die Checkbox ergibt das auch alles sinn. Ich nehme an bei der Checkbox ist der ASP.NET MVC Helper etwas seltsam. </p>
<p><strong>jQuery rockt :)</strong></p>
<p>Wenn man also seine Forms oder nur Teile davon via AJAX versenden will -&gt; der serializer fetzt.</p>
<p><strong><a href="http://{{BASE_PATH}}/assets/files/democode/mvcjqueryformvalues/mvcjqueryformvalues.zip">[ Download Democode ]</a></strong></p>
