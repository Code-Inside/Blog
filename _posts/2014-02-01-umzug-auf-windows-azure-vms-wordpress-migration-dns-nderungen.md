---
layout: post
title: "Umzug auf Windows Azure – VMs, WordPress Migration, DNS Änderungen"
date: 2014-02-01 14:08
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [Blog, VM, Windows Azure, WordPress]
---
{% include JB/setup %}
<p>Seit ca. 2 Wochen läuft dieser Blog auf einer Wordpress Installation in einer Azure VM. Da ich mir das Thema erst recht kompliziert vorgestellt hatte, hier mal ein Blick hinter die Kulissen.</p> <h3>Warum umziehen?</h3> <p>Bislang lief dieser Blog (und die englischsprachige Variante) bei einem Hoster irgendwo in Deutschland. Grösstes Problem war aber, dass der Hoster kein Windows Server 2012 R2 angeboten hat und der Vertrag nur jährlich Kündigungen zu liess. Die “jährliche” Kündigung war damals mein “Versehen”, es gab auch eine monatliche Variante, die ich aber damals nicht in betracht gezogen hatte. Die Kommunikation lief aber auch immer via Email oder schlimmer via Fax ab, sodass ich nicht mehr davon angetan war.</p> <p>Anderer grosser Grund auf Azure zu gehen: Aktuell besitze ich eine MSDN Ultimate Lizenz samt 150€ Guthaben im Monat. Damit lässt sich schon was anstellen.</p> <p>In einem älteren Blogpost hatte ich zudem schonmal über die <a href="http://blog.codeinside.eu/2012/03/09/cloud-computing-vs-traditionelle-hoster-fr-eine-web-app/">Unterschieder der “traditionellen” Hoster und Cloud Computing Anbieter geschrieben</a>.</p> <h3>Windows Azure – eine VM für die Blogs</h3> <p>Die Migration auf Azure musste relativ schnell erfolgen und im Laufe der Jahre hatte ich an der WordPress Installation rumgeschraubt und war mir nicht sicher ob der Blog unter Azure Websites laufen würde. Zudem war da das Problem der Datenbank: Die beiden MySQL Datenbanken sind nicht gerade “klein”, sodass ich am Ende für den MySQL Hoster mehr bezahlt hätte als mit der puren VM. Daher habe ich in diesem Fall zu einer Azure VM gegriffen. Ansonsten würde ich immer eine Azure Website empfehlen.</p> <p><em>Es gibt eine <a href="http://wordpress.brandoo.pl/">WordPress Variante die auch mit SQL Azure</a> läuft, hab ich aber aktuell noch nicht genauer angeschaut.</em></p> <p>Das Erstellen der VM war kinderleicht und nach wenigen Minuten auch Einsatzbereit:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1976.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb1112.png" width="576" height="272"></a> </p> <h3>WordPress installieren über den Web Platform Installer</h3> <p>Wie bereits erwähnt läuft der Blog auf WordPress und bislang hatte ich nur sehr wenig Problem mit IIS/Windows/PHP/MySQL (nur manche WP Plugins kommen nicht mit Windows klar).</p> <p>Die Installation ist über den <a href="http://www.microsoft.com/web/downloads/platform.aspx">Web Platform Installer</a> auch schnell erledigt:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1977.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb1113.png" width="573" height="397"></a> </p> <h3>Daten Migration: wp-uploads / Datenbanken</h3> <p>Nach der “puren” Installation habe ich meine Daten aus der alten Installation rübergeholt. Darunter war das “wp-uploads” Verzeichnis sowie das Theme. Meine MySQL Datenbanken hatte ich als Sql Script über ein <a href="http://blog.codeinside.eu/2011/06/12/mysql-datenbanken-sichern-ber-powershell/"><strong>Powershell Script</strong></a>&nbsp;<strong>(nutz ich auch für das Backup der MySQL DBs)</strong> erzeugt. Die Scripts habe ich dann jeweils über <a href="http://www.heidisql.com/">HeidiSQL</a> auf der Azure VM eingespielt.</p> <p>Danach die entsprechenden Daten in der wp-config.php hinterlegen und es lief schonmal.</p> <h3>DNS Migration: code-inside.de/blog auf blog.codeinside.eu</h3> <p>Mit der Migration wollte ich auch mal das Thema Domains angehen. Bislang lief der Blog unter “code-inside.de/blog” und seit einiger Zeit wollte ich eigentlich weg von dem “Subdirectory” hin zu einer “Subdomain”. Das Thema ist in <a href="http://blog.codeinside.eu/2013/04/08/subdomain-vs-subdirectory/">diesem Blogpost</a> näher erklärt. Ziel war es: Hin zu Subdomains und die neue Domain soll “codeinside.eu” sein (ganz im Sinne des europäischen Gedanken ;))</p> <p> Die “www.code-inside.de” zeigt einfach auf die öffentliche IP der Azure VM. “blog.codeinside.eu”, “blogin.codeinside.eu”, “cdn.codeinside.eu” zeigt via CName auf codeinside.cloudapp.net – was ebenfalls auf die Azure VM zeigt. </p> <h4> Im IIS ist da folgende Struktur hinterlegt:</h4> <p><a href="{{BASE_PATH}}/assets/wp-images/image1978.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; margin: 0px 10px 0px 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb1114.png" width="175" align="left" height="153"></a> </p> <p>ci-blog hört auf den Hostname “blog.codeinside.eu”</p> <p>ci-blogin hört auf den Hostname “blogin.codeinside.eu”</p> <p>ci-cdn hört auf den Hostname “cdn.codeinside.eu”</p> <p>redirects ist meine “Catchall” Anwendung</p> <p>&nbsp;</p> <p>&nbsp;</p> <h4>Der eigentliche Redirect – gesteuert über die web.config</h4> <p>Ziel mit der Umleitung war es alle Links am Leben zu erhalten:</p> <p>- code-inside.de/blog musste auf blog.codeinside.eu verweisen<br>- code-inside.de/blog-in musste auf blogin.codeinside.eu verweisen<br>- code-inside.de/files musste auf cdn.codeinside.eu verweisen<br>- alles andere sollte auf die neu Startseite “www.codeinside.eu” weitergeleitet werden</p> <p>Die “redirects” App im IIS beinhaltet nur eine web.config mit folgenden Inhalt:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;configuration&gt;
    &lt;system.webServer&gt;
        &lt;rewrite&gt;
            &lt;rules&gt;
                &lt;clear /&gt;
                &lt;rule name="code-inside.de blog-in" stopProcessing="true"&gt;
                    &lt;match url="blog\-in(.*)" /&gt;
                    &lt;conditions logicalGrouping="MatchAll" trackAllCaptures="false"&gt;
                        &lt;add input="{HTTP_HOST}" pattern="code-inside.de" /&gt;
                    &lt;/conditions&gt;
                    &lt;action type="Redirect" url="http://blogin.codeinside.eu{R:1}" redirectType="Permanent" /&gt;
                &lt;/rule&gt;
                &lt;rule name="code-inside.de blog" stopProcessing="true"&gt;
                    &lt;match url="blog(.*)" /&gt;
                    &lt;conditions logicalGrouping="MatchAll" trackAllCaptures="false"&gt;
                        &lt;add input="{HTTP_HOST}" pattern="code-inside.de" /&gt;
                    &lt;/conditions&gt;
                    &lt;action type="Redirect" url="http://blog.codeinside.eu{R:1}" redirectType="Permanent" /&gt;
                &lt;/rule&gt;
                &lt;rule name="code-inside.de files" stopProcessing="true"&gt;
                    &lt;match url="files(.*)" /&gt;
                    &lt;conditions logicalGrouping="MatchAll" trackAllCaptures="false"&gt;
                        &lt;add input="{HTTP_HOST}" pattern="code-inside.de" /&gt;
                    &lt;/conditions&gt;
                    &lt;action type="Redirect" url="http://cdn.codeinside.eu/files{R:1}" redirectType="Permanent" /&gt;
                &lt;/rule&gt;
                &lt;rule name="catch all" stopProcessing="true"&gt;
                    &lt;conditions logicalGrouping="MatchAll" trackAllCaptures="false" /&gt;
                    &lt;action type="Redirect" url="http://www.codeinside.eu" /&gt;
                &lt;/rule&gt;
            &lt;/rules&gt;
        &lt;/rewrite&gt;
    &lt;/system.webServer&gt;
&lt;/configuration&gt;
</pre>
<p>WordPress selbst speichert an mehreren Orten was die “öffentliche” URL ist – daher musste ich zum Teil über HeidiSQL (weil ich immer auf das alte Admin Dashboard umgeleitet wurde ;) ) oder über die Weboberfläche die Werte in der Konfiguration ändern. </p>
<h3>Feedburner Einstellung anpassen</h3>
<p>Der RSS Feed des Blogs wird nach wie vor über Feedburner ausgeliefert. Durch die DNS Einstellung musste ich da auch die Daten ändern.</p>
<h3>Mission Completed</h3>
<p>Soweit bin ich ziemlich zufrieden mit dem Ergebnis. Falls jemand einen Fehler bemerkt oder irgendwas “nicht mehr so geht wie früher”, dann einfach in die Kommentare oder via Email/Twitter etc. bescheid geben.</p>
<p>Wesentlich schicker als bei einem traditionellen Hoster ist natürlich das Dashboard:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1979.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb1115.png" width="578" height="206"></a> </p>
<p>Beide Blogs laufen derzeit auf einer Small (1 core, 1.75 GB memory) VM (zwei VMs wäre Aufgrund der MySQL Installation auch komplizierter) und bislang sieht das ganz gut aus. Nach einem Monat möchte ich euch noch ein Update liefern, sodass man sieht was Azure in dieser Konstellation mit dem Traffic auf dem Blog überhaupt kostet. Bei Fragen immer her damit :)</p>
