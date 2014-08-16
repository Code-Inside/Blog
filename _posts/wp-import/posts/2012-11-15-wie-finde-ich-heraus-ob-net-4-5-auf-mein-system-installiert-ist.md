---
layout: post
title: "Wie finde ich heraus ob .NET 4.5 auf mein System installiert ist?"
date: 2012-11-15 22:33
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [.NET 4.5]
---
{% include JB/setup %}
<p>Eine scheinbar einfache Frage, welche allerdings einige Fallen in sich birgt. <br>Grund hierfür liegt darin, dass man theoretisch zwischen CLR Version und Framework Version unterscheiden kann. So war es in den .NET 3.5 Zeiten üblich, dass die CLR Version weiterhin auf Version 2.0 blieb, weil nur neue Libraries in das Framework gekommen sind. </p> <p>Allerdings ist meist mit “.NET Framework 4.5” die Kombination aus der “neusten” Framework- und CLR Version gemeint. Allerdings ist .NET 4.5 ein “in-place upgrade” für .NET 4.0. Was die ganze Sache nicht einfacher macht. </p> <p>Guter Einstieg (und ich komme weiter unten nochmal darauf zurück) ist der Post von Scott Hanselman:</p> <p><a href="http://www.hanselman.com/blog/NETVersioningAndMultiTargetingNET45IsAnInplaceUpgradeToNET40.aspx">.NET Versioning and Multi-Targeting - .NET 4.5 is an in-place upgrade to .NET 4.0</a><strong></strong></p> <p><strong>Einfacher Check für: Ist die .NET Framework Version 4.5 installiert?</strong></p> <p>Um festzustellen, welche Version installiert ist, liefert die Registry den entscheidenden Hinweis unter dem Pfad “Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full”</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1661.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb819.png" width="542" height="219"></a> </p> <p>In meinem Fall: Jepp - .NET 4.5 ist installiert. Diese Prüfung geht vermutlich nur wenn man selber System-Admin ist und eine volle Kontrolle über das System und die Anwendungen hat. </p> <p>Mit der Information wissen wir schonmal: Das Framework ist auf dem System installiert.</p> <p><strong>Läuft meine Applikation unter .NET 4.5?</strong></p> <p>Hiermit ist jetzt nicht gemeint ob die Applikation “kompatibel” zu .NET 4.5 ist, sondern ob die Applikation überhaupt .NET 4.5 Features nutzen kann.</p> <p>Diese Frage ist schon etwas schwer zu beantworten, da dies z.B. von der app.config bzw. web.config abhängig ist und wenn der IIS im Spiel ist muss der AppPool entsprechend eingestellt sein. </p> <p><em>Wer den <a href="http://www.hanselman.com/blog/NETVersioningAndMultiTargetingNET45IsAnInplaceUpgradeToNET40.aspx">Hanselman Post</a> gelesen hat, der wird jetzt eine sehr verkürzte Fassung dessem lesen ;)</em></p> <p>Wer eine Desktop Applikation ausführt und nicht die geeignete Framework-Version, welche im <a href="http://msdn.microsoft.com/en-us/library/w4atty68.aspx">supportedRuntime Element</a> der app.config ausführt, der bekommt eine Fehlermeldung. Damit sage ich der Runtime, dass meine App .NET 4.5 benötigt:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">&lt;?xml version="1.0" encoding="utf-8" ?&gt;
&lt;configuration&gt;
    &lt;startup&gt; 
        &lt;supportedRuntime version="v4.0" sku=".NETFramework,Version=v4.5" /&gt;
    &lt;/startup&gt;
&lt;/configuration&gt;</pre>
<p>Falls kein .NET 4.5 vorhanden ist wird, kommt diese Fehlermeldung:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1662.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb820.png" width="415" height="211"></a> </p>
<p> Für Web-Applikationen gibt es ein ähnliches Element in der web.config:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">&lt;configuration&gt;
    &lt;system.web&gt;
        &lt;compilation debug="true" strict="false" explicit="true" targetFramework="4.5" /&gt;
    &lt;/system.web&gt;
&lt;/configuration&gt;</pre>
<p>Falls die im TargetFramework vorgegebene Runtime nicht da ist, gibts eine Fehlermeldung beim Aufruf der Webapp.</p>
<p><strong>Best Practice: Feature Detection zur Laufzeit</strong></p>
<p>Da das Framework immer mehr Libraries umfasst und jede der Libraries eine andere Versionsnummer haben können und sich die Runtime unterscheiden kann, ist es wohl am besten, wenn man genau prüft, ob z.B. eine bestimmte Klasse vorhanden ist.</p>
<p><strong>Empfehlenswerte Links</strong></p>
<p>Der Blogpost von <a href="http://www.hanselman.com/blog/NETVersioningAndMultiTargetingNET45IsAnInplaceUpgradeToNET40.aspx">Scott Hanselman ist zu dem Thema</a> sehr aufschlussreich und verweisst auf eine sehr <a href="http://stackoverflow.com/questions/8517159/how-to-detect-at-runtime-that-net-version-4-5-currently-running-your-code/8543850#8543850">gute Erklärung der Problematik auf Stackoverflow</a>.</p>
