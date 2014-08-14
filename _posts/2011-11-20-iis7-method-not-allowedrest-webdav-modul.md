---
layout: post
title: "IIS7 “Method not allowed”–REST + WebDAV Modul"
date: 2011-11-20 18:44
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [IIS7, REST]
---
<p>Wer mit “REST” Services im IIS arbeitet, wird den Fehler kennen: <strong>“Method not allowed”</strong>. In <a href="http://code-inside.de/blog/2011/10/11/http-putdelete-via-web-config-im-iis7-fr-asp-net-mvc-erlauben/">diesem Blogpost</a> hatte ich beschrieben, wie man die richtige Konfiguration per Web.config setzen kann. Allerdings hatte ich nun den Fall, dass das RavenDB Studio nicht so wollte und ich wollte die web.config auch nicht groß editieren.</p> <p><strong>Häufige Fehlerquelle: Das WebDAV Modul</strong></p> <p>Wenn im IIS noch WebDAV aktiviert ist, dann kommt dies Fehlermeldung meistens, weil es Überschneidungen mit dem WebDAV Modul gibt. Daher sollte man sicher gehen, dass man es entweder via web.config deaktiviert hat:</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:3651b7ab-87db-4cd1-be7f-aa92b14b0580" class="wlWriterEditableSmartContent"><pre name="code" class="c#">	&lt;system.webServer&gt;
		...
        &lt;modules&gt;
            &lt;remove name="WebDAVModule" /&gt;
        &lt;/modules&gt;
	&lt;/system.webServer&gt;</pre></div>
<p>… und wenn dies nicht hilft, dann nochmal kontrollieren ob die Einstellung auch greift. Zur Not kann man das Modul auch über den IIS Manager entfernen:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1390.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb572.png" width="412" height="324"></a></p>
<p><strong>Wichtig: Es kann viele Fehlerquellen geben. </strong></p>
<p>Im IIS kann man jedem Modul die entsprechenden Verben zuordnen:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1391.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb573.png" width="498" height="504"></a></p>
<p>Allerdings ist das recht kompliziert und im Regelfall sollte man nicht alles verstellen ;)</p>
