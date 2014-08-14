---
layout: post
title: "IIS & Windows Authentication – Troubleshooting mit Negotiate & NTLM"
date: 2013-05-12 20:50
author: robert.muehsig
comments: true
categories: [Fix]
tags: [IIS, Troubleshooting, Windows Auth]
---
{% include JB/setup %}
<p>Windows Authentifizierung ist eine einfache (und naheliegende) Authentifizierungs-Option für “Haus-interne” Webapplikationen. </p> <h3>Setup</h3> <p>Im IIS selbst kann man die Windows Authentifzierung sehr leicht anschalten:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/iis1.gif"><img title="iis" style="display: inline" alt="iis" src="{{BASE_PATH}}/assets/wp-images/iis_thumb1.gif" width="582" height="365"></a></p> <p>Natürlich kann man dies auch über die <a href="http://msdn.microsoft.com/en-us/library/ff647405.aspx">web.config</a> steuern:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;"> &lt;system.web&gt;
  ...
  &lt;authentication mode="Windows"/&gt;
  ...
 &lt;/system.web&gt;
 ...</pre>
<h3>Fehlermeldung “HTTP Error 401.2 – Unauthorized”:</h3>
<p>Dies kann (wie fast immer) viele Gründe haben, z.B. weil man nicht die erforderten Rechte hat. Wenn man dies als Fehlerquelle ausschliessen kann, sollte man überprüfen ob überhaupt die Windows Authentifzierung angeschalten ist und ob das Feature in den Windows-Komponenten aktiviert ist:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1839.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb990.png" width="572" height="476"></a></p>
<h3>Providers:</h3>
<p>Im Normalfall gibt es zwei Provider: Negotiate und NTLM. Negotiate sagt einfach nur, dass Server und Client sich abstimmen. Allerdings hatte ich bislang zweimal das Problem, dass Server und Client sich auf Kerberos Authentifizierung geeinigt hatten, dies aber aus irgendeinem Grund nicht funktionierte. Als ich nur noch NTLM nutze ging es.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1840.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb991.png" width="540" height="467"></a> </p>
<h3>Troubleshooting Tipps:</h3>
<p>Ruft man die Seite direkt auf dem Server über den IE auf, wird immer NTLM genommen (und nicht Kerberos).</p>
<p>Alle nicht IE-Browser versuchen sich über NTLM zu authentifizieren. Zum Testen nehm ich sowohl IE als auch Chrome.</p>
<p>Wer im IE eine automatische Anmeldung möchte, d.h. kein Login Prompt, muss die URL in der Intranet-Zone eintragen (oder die Policies verändern)</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1841.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb992.png" width="568" height="345"></a> </p>
<p>Windows Authentifizierung ist eine nette Sache – wenn sie funktioniert ;)</p>
