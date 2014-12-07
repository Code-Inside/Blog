---
layout: post
title: "Welchen Befehl verwendet Visual Studio für WebDeploy? Der “UseMsdeployExe” Switch..."
date: 2012-11-08 22:49
author: robert.muehsig
comments: true
categories: [HowTo]
tags: []
language: de
---
{% include JB/setup %}
<p>WebDeploy finde ich ein großartiges Tool um WebApplikationen zu publishen bzw Packages zu bauen, allerdings kann es manchmal schwer sein den Vorgang zu debuggen. </p> <p><em>Link zum Setup WebDeploy: Wer Probleme beim Aufsetzen von WebDeploy hat, der </em><a href="{{BASE_PATH}}/2012/11/06/setup-iis-8-fr-asp-net-webdeploy-auf-windows-8-und-windows-server-2012/"><em>kann auf diesen Post mal</em></a><em> ein Blick werfen.</em>&nbsp;</p> <p><strong>Publishing aus dem Visual Studio klappt, aber über die Cmd nicht? Mhh…</strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1636.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb795.png" width="134" height="131"></a> Wenn das Publishing über Visual Studio selbst klappt, aber über die Kommandozeile will es nicht und die Batch Datei will auch nicht wird es rätselhaft.</p> <p>Im Standardfall nutzt Visual Studio eine interne Web Deploy API sodass die MsDeploy.exe gar nicht aufgerufen wird. Allerdings kann man Visual Studio dazu bringen den Aufruf direkt an die MsDeploy.exe weiterzureichen. </p> <p><strong></strong>&nbsp;</p> <p><strong>Allerdings gibt es eine Lösung für das Problem:</strong></p> <p>Dafür muss man im selben Verzeichnis wie die Projektdatei eine<strong> {PROJECTNAME}.wpp.targets </strong>Datei mit diesem Inhalt anlegen:</p><pre>&lt;?xml version="1.0" encoding="utf-8"?&gt;
&lt;Project ToolsVersion="4.0" DefaultTargets="Build" 
         xmlns="http://schemas.microsoft.com/developer/msbuild/2003"&gt;
  &lt;PropertyGroup&gt;
    &lt;UseMsdeployExe&gt;true&lt;/UseMsdeployExe&gt;
  &lt;/PropertyGroup&gt;
&lt;/Project&gt;</pre>
<p>Man kann dieses Property auch direkt in der Projektdatei unterbringen, allerdings ist dies die schönere Lösung.</p>
<p><strong>Build Output</strong></p>
<p>Durch dieses Flag nutzt Visual Studio jetzt direkt MsDeploy.exe und der Aufruf kann im Build Output gesehen werden:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1637.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb796.png" width="575" height="304"></a>&nbsp;</p>
<p>Jetzt kann man vergleichen, was Visual Studio macht und was bislang das eigene Script nicht gesetzt hat.</p>
<p>Noch mehr Informationen erhält man, wenn man in den Optionen die Build Output Informationsmenge erhöht:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1638.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb797.png" width="533" height="322"></a> </p>
<p>Die Information hab ich aus dem <a href="http://sedodream.com/CommentView%2cguid%2c269EC8D3-9D71-400A-BD99-CC3EA5D0C834.aspx">Blog von Sayed Ibrahim Hashimi</a> – ein Microsofti, welcher sich um WebDeploy kümmert. Wer mehr über WebDeploy lernen will, sollte seinen Blog lesen.</p>
