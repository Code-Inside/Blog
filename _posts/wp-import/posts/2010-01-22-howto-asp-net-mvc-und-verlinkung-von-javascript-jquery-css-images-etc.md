---
layout: post
title: "HowTo: ASP.NET MVC und Verlinkung von Javascript, jQuery, CSS, Images etc."
date: 2010-01-22 00:06
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, HowTo, Linking, SEO]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image903.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="135" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb88.png" width="197" align="left" border="0"></a><a href="http://asp.net/mvc">ASP.NET MVC</a> brachte ein neues Feature mit: Das <a href="http://www.asp.net/(S(pdfrohu0ajmwt445fanvj2r3))/learn/mvc/tutorial-05-cs.aspx">Routing</a>. Dieses Feature erlaubt es, dass man ohne Zusatzlibraries sich seine <a href="http://de.wikipedia.org/wiki/Suchmaschinenoptimierung">SEO</a> URLs zusammenbauen kann, ohne auf die physische Ordnerstruktur rücksicht zu nehmen. Das kann aber zu Problemen führen wenn man Javascript, Bilder oder CSS Datein einbinden möchte. Warum und was es da für schöne Helper gibt, möchte ich in diesem HowTo kurz zeigen.</p><!--more--> <p><strong>Das Standard ASP.NET MVC Projekttemplate</strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image904.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="368" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb89.png" width="203" align="left" border="0"></a></p> <p>Das Standard ASP.NET MVC Projekttemplate sieht so aus. Angedacht für CSS ist der Content Ordner. Für Javascript wurde der Scripts Ordner ausgesucht. Natürlich kann man seine "Content" Datein speichern wo man mag, aber das soll nur als Beispiel dienen.</p> <p>Wie in ASP.NET "gewohnt" wird nun der Entwickler einfach die Datein nehmen und auf die Masterpage per Drag-n-Drop ziehen.</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>Das ist dabei das Resultat:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:7de91553-7a0c-450d-aecc-522a56efd109" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    &lt;link href="../../Content/Site.css" rel="stylesheet" type="text/css" /&gt;
    &lt;script src="../../Scripts/jquery-1.3.2.min.js" type="text/javascript"&gt;&lt;/script&gt;
    &lt;script src="../../Scripts/MicrosoftAjax.js" type="text/javascript"&gt;&lt;/script&gt;
    &lt;script src="../../Scripts/MicrosoftMvcAjax.js" type="text/javascript"&gt;&lt;/script&gt;</pre></div>
<p><strong>Das funktioniert auch...</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image905.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="49" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb90.png" width="244" border="0"></a> </p>
<p><strong>Die Falle: Routing</strong></p>
<p>Wir möchten nun angenommen die Routing Funktion nutzen und bauen uns eine einfache Action:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:8cd915a0-847d-49ea-af57-3a00aaf7fc99" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">
        public ActionResult Blog(string year, string month, string day)
        {
            ViewData["Message"] = year + " " + month + " " + day;

            return View("Index");
        }</pre></div>
<p>Am Ende wollen wir so eine URL ermöglichen (z.B. bei einem Blog etc.) <a title="http://localhost:49656/Home/Blog/2010/01/21" href="http://localhost:49656/Home/Blog/2010/01/21">http://localhost:49656/Home/Blog/2010/01/21</a></p>
<p>Das ganze setzt man in die Global.asax, wo das Routing definiert wird:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:27995d15-61ce-46ff-a5ed-f2cbe4587741" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">            routes.MapRoute("Calendar",
                            "Home/Blog/{year}/{month}/{day}",
                            new { controller = "Home", action = "Blog"});
            </pre></div>
<p>Das ganze rendert auch im Browser, allerdings werden die Javascript Files <strong>nicht</strong> geladen:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image906.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="56" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb91.png" width="483" border="0"></a> </p>
<p>Das Problem ist: Die relative Verlinkung</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image907.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="28" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb92.png" width="388" border="0"></a> </p>
<p>Die original Datei liegt unter localhost/Scripts/jquery-1.3.2.min.js!</p>
<p><strong>Fehlerbehebung: Die Helper</strong></p>
<p>Über URL.Content kann man sehr einfach "statischen" Content einbinden. Der Helper prüft dabei von wo aus die Anfrage kommt und passt so die Verlinkung an:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:23bef4f0-6e5e-4a1c-878d-1d4540e41b27" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    &lt;link href="&lt;%=Url.Content("~/Content/Site.css") %&gt;" rel="stylesheet" type="text/css" /&gt;
    &lt;script src="&lt;%=Url.Content("~/Scripts/jquery-1.3.2.min.js") %&gt;" type="text/javascript"&gt;&lt;/script&gt;
    &lt;script src="&lt;%=Url.Content("~/Scripts/MicrosoftAjax.js") %&gt;" type="text/javascript"&gt;&lt;/script&gt;
    &lt;script src="&lt;%=Url.Content("~/Scripts/MicrosoftMvcAjax.js") %&gt;" type="text/javascript"&gt;&lt;/script&gt;</pre></div>
<p><a href="{{BASE_PATH}}/assets/wp-images/image908.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="48" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb93.png" width="244" border="0"></a> </p>
<p><strong>Meidet "feste" URL Angaben. Versucht immer über die Helper zu gehen um die URL dynamisch zu erzeugen. Wenn sich das Routing mal ändern sollte, ist man auf der sichern Seite.</strong></p><a href="{{BASE_PATH}}/assets/files/democode/mvclinkingdoitright/mvclinkingdoitright.zip"><strong>[ Download Democode ]</strong></a>
