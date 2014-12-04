---
layout: post
title: "HowTo: Session in ASP.NET & ASP.NET Session State Server"
date: 2010-03-21 22:12
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, Session]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image941.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="135" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb126.png" width="159" align="left" border="0"></a>Auf die Session ist in ASP.NET relativ simpel zuzugreifen. Im Standardfall läuft die Session im IIS Prozess mit. Wenn man also mal den IIS neustarten muss oder die web.config anpassen muss, dann wird der Prozess neugestartet und die Session geht verloren. Eine einfache Variante dies zu umgehen ist den ASP.NET Session State Server zu verwenden.</p><p><strong>Auf die Session zugreifen</strong></p> <p>Hier mal der wesentliche Session-Zugriff (im Controller einer ASP.NET MVC Anwendung)</p> <p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:8f58b937-1d06-419b-9683-f2ef103920f6" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        public ActionResult Index()
        {
            if(this.Session["Foobar"] != null) {
                ViewData["Message"] = "Session: " + this.Session["Foobar"];
            }
            else {
                ViewData["Message"] = "Session empty";
            }
            return View();
        }</pre></div></p>
<p>Session setzen:</p>
<p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:39c5346b-e4fc-4524-b914-6122439b6e30" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        public ActionResult SetSession()
        {
            this.Session["Foobar"] = "Yeah - " + DateTime.Now.ToShortTimeString() + ":" + DateTime.Now.Second.ToString();
            return RedirectToAction("Index");
        }</pre></div></p>
<p><strong>Resultat</strong></p>
<p>Foobar noch nicht in der Session gesetzt:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image942.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="101" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb127.png" width="201" border="0"></a> </p>
<p>Nach dem Klick auf *SetSession*</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image943.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="80" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb128.png" width="244" border="0"></a> </p>
<p><strong>Probleme bei "InProc"</strong></p>
<p>ASP.NET bietet mehrere <a href="http://msdn.microsoft.com/en-us/library/ms178586.aspx">Session State Modes</a>. Im Standardfall ist dieser auf "InProc" und hängt am IIS Prozess. Auch bei einer Web.config Änderung wird der Prozess für diese Website neugestartet und die Session ist wieder leer. Es gibt mehrere Szenarien wo dies zu Problemen führen kann:</p>
<ul>
<li>Man hat mehrere Webserver mit Loadbalancer. <a href="http://blog.maartenballiauw.be/">Maarten Balliauw</a> hat darüber eine nette Serie geschrieben:</li>
<ul>
<li><a href="http://blog.maartenballiauw.be/post/2007/11/22/ASPNET-load-balancing-and-ASPNET-state-server-(aspnet_state).aspx">ASP.NET load balancing and ASP.NET state server (aspnet_state)</a></li>
<li><a href="http://blog.maartenballiauw.be/post/2008/01/23/ASPNET-Session-State-Partitioning.aspx">ASP.NET Session State Partitioning</a></li>
<li><a href="http://blog.maartenballiauw.be/post/2008/01/24/ASPNET-Session-State-Partitioning-using-State-Server-Load-Balancing.aspx">ASP.NET Session State Partitioning using State Server Load Balancing</a></li></ul>
<li>Solange man die Struktur der Sessiondaten nicht ändert kann man im Hintergrund die web.config ändern oder die ganze WebApp austauschen. Das ist natürlich praktisch für kleinere Bugfixes.</li></ul>
<p><strong>Was muss man für den ASP.NET Session State Server konfigurieren?</strong></p>
<p>Der "ASP.NET Session State Service"/"ASP.NET <a href="http://www.microsoft.com/technet/prodtechnol/WindowsServer2003/Library/IIS/0d9dc063-dc1a-46be-8e84-f05dbb402221.mspx?mfr=true">Sitzungszustand</a> Dienst" muss laufen. Dieser Dienst wird mit dem .NET Framework mit installiert, allerdings nicht gestartet. Dann noch dieser Web.config Eintrag und wir sind schon fertig:</p>
<p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:dfb29f8c-9d0f-4c86-897b-157ad248f8a2" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    &lt;sessionState mode="StateServer"
      stateConnectionString="tcpip=localhost:42424"
      cookieless="false"
      timeout="20"/&gt;</pre></div></p>
<p>Wenn man mehrere Maschinen hat, sollte man sich an die <a href="http://blog.maartenballiauw.be/post/2007/11/22/ASPNET-load-balancing-and-ASPNET-state-server-(aspnet_state).aspx">Blogserie von Maarten Balliauw</a> halten. </p>
<p>Jetzt kann man die web.config ändern und den Server wild hoch und runterfahren - solange der ASP.NET Sitzungszustandsdienst läuft :)</p>
<p><strong>Andere Möglichkeiten: SQL Server, Custom</strong></p>
<p>Man kann die Session auch in den SQL Server packen, aber ich bin mir nicht sicher ob das wirklich schnell ist. Natürlich kann man auch seinen eigenen Mechanismus überlegen. <a href="http://www.hanselman.com/blog/">Scott Hanselman</a> hat in einem Blogpost mal eine nette <a href="http://www.hanselman.com/blog/TroubleshootingExpiredASPNETSessionStateAndYourOptions.aspx"><strong>Übersicht</strong> erstellt</a>.</p>
<p><strong>Ist das eigentlich noch aktuell oder gibt es schon neueres/tolleres?</strong></p>
<p>Da der Blogpost von Herrn Hanselman ja doch schon etwas älter ist, wollte ich mal in die Runde fragen ob diese Varainte irgendwelche Risiken birgt oder ob man heutzutage was anderes macht. Für Feedback wäre ich dankbar :)</p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/mvcsessionstateserver/mvcsessionstateserver.zip">[ Download Democode ]</a></strong> <em>(Achtung: Der Dienst muss gestartet sein)</em></p>
