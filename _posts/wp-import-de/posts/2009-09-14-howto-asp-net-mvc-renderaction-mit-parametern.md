---
layout: post
title: "HowTo: ASP.NET MVC RenderAction mit Parametern"
date: 2009-09-14 22:41
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC; MVC; Futures; RenderAction; Komponenten]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image816.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="148" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb.png" width="132" align="left" border="0"></a>Es gibt unter den MVC Futures ein nettes Feature namens "RenderAction". Damit kann man aus dem View heraus eine Controller-Action aufrufen und das Ergebnis wird in den Output geschrieben. Für MVC Puristen ist dies zwar der Tod schlecht hin, aber das Feature ist sehr praktisch um kleine "Widgets" auf eine Webseite zu bringen.</p><p><strong>Futures</strong></p> <p>Die <a href="http://aspnet.codeplex.com/Release/ProjectReleases.aspx?ReleaseId=24471#DownloadId=61773">ASP.NET MVC Futures</a> findet man (<a href="http://aspnet.codeplex.com/Release/ProjectReleases.aspx?ReleaseId=24471">mit Source Code</a>) auf Codeplex. Ob dieses Feature auch so in MVC V2 Einzug halten wird, bleibt abzuwarten. Ich denke jedoch, dass irgendwas in dieser Art kommen wird. Und falls nicht: Dann bleibt man bei den Futures und durch den Zugriff auf den Source Code kann man da sich auch selber helfen :)</p> <p>Nach dem <a href="http://aspnet.codeplex.com/Release/ProjectReleases.aspx?ReleaseId=24471#DownloadId=61773">Download</a> der Datei bekommt man die <strong>Microsoft.Web.Mvc.dll.</strong></p> <p><strong>Anwendung</strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image817.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="298" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb1.png" width="201" align="left" border="0"></a> Links zu sehen ist mein Demoprojekt. Wichtig ist eigentlich nur der HomeController und im Home - Viewordner die Index.aspx und die News.aspx.</p> <p>Die News.aspx:<br>Hier liegt der HTML Code unseres "Widgets".</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>In der Index.aspx machen wir folgenden Aufruf:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:8a4d47b2-14e7-491e-8b4a-50bc28166030" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">     &lt;% Html.RenderAction("News", "Home"); %&gt;</pre></div>
<p>Damit wird die "<strong>News</strong>" Actionmethod des "<strong>Home</strong>" Controller aufgerufen und das Ergebnis wird dort in den Output geschrieben:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d9dc17ef-20f8-404a-a8d5-86f5064dc13e" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public ActionResult News(int? count)
        {
            // Default Value
            int newsCount = 5;

            // Check if Parameter has value
            if(count.HasValue) {
                newsCount = count.Value;
            }

            // Prepare News
            List&lt;string&gt; newsEntry = new List&lt;string&gt;();

            for(int i = 0; i &lt;= newsCount; i++)
            {
                newsEntry.Add("Test " + i);
            }

            ViewData["News"] = newsEntry;

            return View();
        }</pre></div>
<p> Hier passiert keine große Magie: Ich habe einen <a href="http://msdn.microsoft.com/en-us/library/1t3y8s4s(VS.80).aspx">"optionalen"/nullable Parameter</a>. Wenn dieser nicht gesetzt ist, dann füge ich einfach 5 strings in mein ViewData["News"] und render nun die "News.aspx":</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:dae28b6e-7360-4b97-ac9d-ca29a5c3ad46" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %&gt;

&lt;%
  List&lt;string&gt; result = (List&lt;string&gt;)ViewData["News"];
      
  foreach (string item in result)
  { %&gt;
    &lt;%=item %&gt;
&lt;% } %&gt;
</pre></div>
<p><strong>Mit Parametern:</strong></p>
<p>Natürlich kann ich beim Aufruf von RenderAction auch Parameter mitgeben:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:df60636b-6379-491e-9c8b-382c200a72a9" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    &lt;% Html.RenderAction("News", "Home", new { count = 15 }); %&gt;</pre></div>
<p>Im letzten Abschnitt wird ein anonymer Typ mit dem Property "count" übergeben. Dies wird direkt auf den "count" Parameter gemappt.</p>
<p><strong>Nachlesen:</strong></p>
<p><a href="http://blog.codeville.net/">Steve Sanderson</a> hat in seinem <a href="http://books.google.de/books?id=tD3FfFcnJxYC&amp;pg=PT366&amp;lpg=PT366&amp;dq=asp.net+mvc+renderaction+paramter&amp;source=bl&amp;ots=IQeHzrzK-t&amp;sig=s8wKfU90MGOAdptLtJ6y-O4WbpI&amp;hl=de&amp;ei=UKmuSr_IJc2ssgbX2qH2Bw&amp;sa=X&amp;oi=book_result&amp;ct=result&amp;resnum=5#v=onepage&amp;q=&amp;f=false">Buch "Pro ASP.NET MVC Framework" den Mechanismus</a> sehr gut beschrieben.</p>
<p><strong>Ergebnis:</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image818.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="147" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb2.png" width="244" align="left" border="0"></a> </p>
<p>Um kleine "Komponenten" abzubilden finde ich dieses Werkzeug ideal. </p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/mvcrenderwithparameters/mvcrenderwithparameters.zip">[ Download Demoanwendung ]</a></strong></p>
