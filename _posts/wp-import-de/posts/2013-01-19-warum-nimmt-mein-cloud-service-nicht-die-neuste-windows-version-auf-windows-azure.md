---
layout: post
title: "Warum nimmt mein Cloud Service nicht die neuste Windows Version auf Windows Azure?"
date: 2013-01-19 14:34
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Azure, Windows Server]
language: de
---
{% include JB/setup %}
<p>Vor kurzem hatte ich mich per Remote Desktop auf eine Windows Azure Instanze eines “Cloud Projektes” verbunden und wurde überrascht: Es war ein Windows Server 2008 – und hatte mich prompt mit der Meldung begrüsst, dass ich doch bitte das Windows aktivieren sollte (?).</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1705.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb863.png" width="590" height="541"></a> </p> <p><strong>Warum läuft eine alte Windows Version auf Azure – sollte es nicht immer das aktuellste sein?</strong></p> <p>Eigentlich hatte ich dies auch gedacht, allerdings wird die Cloud Applikation nicht automatisch auf eine neue Windows Version installiert – dies muss man in der <a href="http://msdn.microsoft.com/en-us/library/windowsazure/ee758710.aspx">Cloud Service Configuration File (.cscfg)</a> festlegen.</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">&lt;ServiceConfiguration serviceName="&lt;service-name&gt;" osFamily="[1|2|3]" osVersion="&lt;os-version&gt;" schemaVersion="&lt;schema-version&gt;"&gt;
  &lt;Role …&gt;
         …
  &lt;/Role&gt;
  &lt;NetworkConfiguration&gt;  
         …
  &lt;/NetworkConfiguration&gt;
&lt;/ServiceConfiguration&gt;</pre>
<p><u>Wichtig hierbei:</u></p>
<p><strong>osFamily:</strong> Dies gibt die Windows Version an, wobei <strong>1 </strong>für <strong>Windows Server 2008</strong> steht, <strong>2</strong> für <strong>Windows Server 2008 R2</strong> und seit neustem gibts <strong>3</strong> für<strong> Windows Server 2012</strong>.</p>
<p><strong>osVersion:</strong> Dies sind bestimmte Patches und Updates die eingespielt werden. Empfehlenswerter Wert ist “*” – damit wird ein Windows mit den letzten Patches genommen.</p>
<p><strong>osFamily=”*” für die neuste Windows Version?</strong></p>
<p>Dies liegt zwar nah – funktioniert aber nicht:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1706.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb864.png" width="556" height="109"></a> </p>
<p><strong>Upgrade von der osFamily?</strong></p>
<p>Falls man einen Service, welcher aktuell auf Windows Server 2008 R2 läuft, auf Windows Server 2012 updaten möchte, bekommt eine Fehlermeldung, da dies aktuell nicht vorgesehen ist. Man muss also den Service komplett neu ausrollen.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1707.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb865.png" width="552" height="120"></a> </p>
<p></p>
<p></p>
<p></p>
<p><strong>Was passiert wenn man weder osFamily noch osVersion angibt?</strong></p>
<p>Beide Werte sind optional. Im moment wird osFamily=”1” und osVersion=”*” gesetzt – dies führt auch zu dem Windows aktivieren Screenshot – ich nehm an Microsoft wird mit der Zeit die Defaults ändern.</p>
<p><strong>Fazit</strong></p>
<p>Wer jetzt ein Windows Server 2012 nutzen möchte, muss die osFamily auf den Wert “3” stellen. Ansonsten würde ich den osVersion Wert immer auf “*” stellen. </p>
