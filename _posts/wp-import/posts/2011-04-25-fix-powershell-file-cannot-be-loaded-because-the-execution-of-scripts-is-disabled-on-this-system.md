---
layout: post
title: "Fix: Powershell “File cannot be loaded because the execution of scripts is disabled on this system”"
date: 2011-04-25 13:45
author: robert.muehsig
comments: true
categories: [Fix]
tags: [Powershell]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image1251.png"><img style="border-right-width: 0px; margin: 0px 10px 0px 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb431.png" width="163" height="98" /></a> </p>  <p>Wenn man Powershell Scripts ausführen möchte, kann diese Fehlermeldung kommen: "File cannot be loaded because the execution of scripts is disabled on this system”. Grund dafür: Die Sicherheitsrichtlinien des Systems.</p>  <p><strong>Sicherheitsrichtlinien?</strong></p>  <p>Standardmäßig dürfen keine .ps1 Scripts aufgeführt werden. Folgende "Execution Policies” gibt es (von dieser <a href="http://www.itexperience.net/2008/07/18/file-cannot-be-loaded-because-the-execution-of-scripts-is-disabled-on-this-system-error-in-powershell/">Quelle</a> übernommen) :</p>  <ul>   <li>"<strong>Restricted</strong>”: Scripts, welche als .ps1 vorliegen können nicht ausgeführt werden. Jedoch können in der Powershell Befehle eingegeben werden. Das ist der Standardwert. </li>    <li>"<strong>AllSigned</strong>”: Scripte mit einer digitalen Signatur können ausgeführt werden. </li>    <li>"<strong>RemoteSigned</strong>”: Lokale .ps1 Scripts können ausgeführt werden, alle anderen (Scripts runtergeladen von irgendwo, welche nicht als "sicher” gekennzeichnet sind) benötigen eine Signatur. </li>    <li>"<strong>Unrestricted</strong>”: Alle Scripts können ausgeführt werden. </li> </ul>  <p><strong>Lösung - Sicherheitsrichtlinien setzen</strong></p>  <p>Die Powershell als Admin ausführen und die Execution Policy setzen:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:87e0ab39-2b1d-4b8f-b89e-a2ca9872d0d3" class="wlWriterEditableSmartContent"><pre name="code" class="c#">Set-ExecutionPolicy RemoteSigned</pre></div>

<p>bzw. die anderen Level. Allerdings sollte man von Unrestricted die Finger lassen. Danke an Ilker für den Wahrhinweis :)</p>
