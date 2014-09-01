---
layout: post
title: "HowTo: Vollständige Seiten via AJAX & normalen GET Request aufrufbar machen in ASP.NET MVC"
date: 2009-10-14 20:48
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [AJAX, ASP.NET MVC, HowTo]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image840.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="127" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb25.png" width="135" align="left" border="0"></a> ASP.NET MVC bietet einige nette <a href="{{BASE_PATH}}/2009/08/25/howto-ajax-und-aspnet-mvc/">AJAX Helper</a>, die einem das leben vereinfachen können. Über den AJAX Aufruf auf eine speziellen URL holt man sich nur den Teil, den man nur braucht. Problematisch wird es dann, wenn man die URL direkt mit dem Browser aufruft. In diesem Fall wird nur der "Partial" gerendert - da das nicht gerade für den User schön ist, kann man sich mit einem kleinen Trick behelfen...</p><p><strong>Szenario</strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image841.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="193" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb26.png" width="244" align="left" border="0"></a> Auf unserer Seite wollen z.B. "Tabs" darstellen. Der Inhalt der Tabs soll dynamisch geladen werden. In meinem Beispiel habe ich einfach mal 3 "Tabmenüpunkte" (die "Tab-Selection") gemacht und eine Region definiert, in dem der Content der Tabs dargestellt werden soll ("Tab-Content"). Das ist nicht schön, aber funktional.</p> <p>Wenn der User die Seite betritt, soll per Default Tab1 dargestellt werden. Über die URL "Home/Index/Tab2" bzw. "Home/Index/Tab3" soll entsprechend der entsprechende Tab dargestellt werden.</p> <p><strong>Anwendungsfall:</strong> Wenn jemand mit der mittleren Maustaste auf die Links klickt, soll entsprechend die vollständige Seite gerendert werden.</p> <p>Im Visual Studio haben wir die 3 Tabinhalte in Partial Views getan:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image842.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="111" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb27.png" width="154" border="0"></a>&nbsp;</p> <p><strong>Wenn man es vollständig auf AJAX Basis macht...</strong></p> <p>Wie in meinem anderen <a href="{{BASE_PATH}}/2009/08/25/howto-ajax-und-aspnet-mvc/">HowTo</a> beschrieben, machen wir für diese 3 "Tab"-Menüpunkte Ajax.ActionLinks:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:9333da67-2f55-4a67-87c1-7e7583d6aff3" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    &lt;ul&gt;
    &lt;li&gt;&lt;%=Ajax.ActionLink("Hier klicken für Tab1", "Tab1", "Home",new AjaxOptions()
                                                                   {
                                                                       HttpMethod = "GET",
                                                                       UpdateTargetId = "resultPanel",
                                                                       InsertionMode = InsertionMode.Replace,
                                                                   })%&gt;	&lt;/li&gt;		
    &lt;li&gt;&lt;%=Ajax.ActionLink("Hier klicken für Tab2", "Tab2", "Home", new AjaxOptions()
                                                                {
                                                                   HttpMethod = "GET",
                                                                   UpdateTargetId = "resultPanel",
                                                                   InsertionMode = InsertionMode.Replace
                                                               })%&gt;&lt;/li&gt;
   &lt;li&gt;&lt;%=Ajax.ActionLink("Hier klicken für Tab3", "Tab3", "Home", new AjaxOptions()
                                                                {
                                                                   HttpMethod = "GET",
                                                                   UpdateTargetId = "resultPanel",
                                                                   InsertionMode = InsertionMode.Replace
                                                               })%&gt;&lt;/li&gt;                                                           
    &lt;/ul&gt;</pre></div>
<p>Das "resultPanel" ist einfach ein Div was darunter liegt. Jetzt im Controller noch die 3 Actions anlegen:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:57cba929-040d-4b93-8032-56b824a75a6b" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public ViewResult Tab1()
        {
            return View();
        }

        public ViewResult Tab2()
        {
            return View();
        }

        public ViewResult Tab3()
        {
            return View();
        }
</pre></div>
<p>Das Resultat:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image843.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="350" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb28.png" width="411" border="0"></a> </p>
<p>Im Prinzip funktioniert es, aber was ist wenn ich nun auf den Link gehe und einen neuen Tab öffne (also direkt "Home/Tab2" aufrufe)?</p>
<p>Das ist das gesamte Ergebnis davon:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image844.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="44" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb29.png" width="63" border="0"></a> </p>
<p>In diesem Fall wird nur der Partial View zurückgegeben. </p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image845.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="66" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb30.png" width="240" border="0"></a> </p>
<p><strong>Wie man es besser machen kann.</strong></p>
<p>Anstatt für jeden Partial View einen eigene ActionMethod zu machen, packen wir dies noch mit in die Index ActionMethod:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:f80cb642-3dfe-4190-b432-132ec9514e90" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public ActionResult Index(string id)
        {
            if (id == string.Empty)
            {
                id = "Tab1";
            }

            // AJAX Request
            if(Request.IsAjaxRequest())
            {
                return View(id);
            }
            
            // Normal GET Request
            ViewData["ActivTab"] = id;

            return View();
        }</pre></div>
<p>Per Default wird "Tab1" gesetzt. </p>
<p>Wenn es ein AJAX Request ist (über die Methode "<a href="http://msdn.microsoft.com/en-us/library/system.web.mvc.ajaxrequestextensions.isajaxrequest.aspx">IsAjaxRequest</a>()") wird nur der entsprechende Partial View zurückgegeben. </p>
<p>Wenn es ein normaler Seitenaufruf ist, schreibe ich mir den "ActivTab" in das ViewData und gebe den Index View zurück. </p>
<p>Der Index View:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:91de793d-386b-44e6-abc6-beb206b3de4a" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;ul&gt;
    &lt;li&gt;&lt;%=Ajax.ActionLink("Hier klicken für Tab1", "Index", "Home", new { id = "Tab1" },new AjaxOptions()
                                                                   {
                                                                       HttpMethod = "GET",
                                                                       UpdateTargetId = "resultPanel",
                                                                       InsertionMode = InsertionMode.Replace,
                                                                   })%&gt;	&lt;/li&gt;		
    &lt;li&gt;&lt;%=Ajax.ActionLink("Hier klicken für Tab2", "Index", "Home", new { id = "Tab2" }, new AjaxOptions()
                                                                {
                                                                   HttpMethod = "GET",
                                                                   UpdateTargetId = "resultPanel",
                                                                   InsertionMode = InsertionMode.Replace
                                                               })%&gt;&lt;/li&gt;
   &lt;li&gt;&lt;%=Ajax.ActionLink("Hier klicken für Tab3", "Index", "Home", new { id = "Tab3" }, new AjaxOptions()
                                                                {
                                                                   HttpMethod = "GET",
                                                                   UpdateTargetId = "resultPanel",
                                                                   InsertionMode = InsertionMode.Replace
                                                               })%&gt;&lt;/li&gt;                                                           
    &lt;/ul&gt;
    &lt;div id="resultPanel"&gt;
    
    &lt;%if(ViewData["ActivTab"].ToString() == "Tab1") Html.RenderPartial("Tab1"); %&gt;
    &lt;%if(ViewData["ActivTab"].ToString() == "Tab2") Html.RenderPartial("Tab2"); %&gt;
    &lt;%if(ViewData["ActivTab"].ToString() == "Tab3") Html.RenderPartial("Tab3"); %&gt;      
    &lt;/div&gt;</pre></div>
<p>Wir gehen nun bei den Ajax.ActionLinks immer auf die Index ActionMethod und geben als <a href="{{BASE_PATH}}/2009/09/21/howto-asp-net-mvc-actionlinks-mit-parametern/">Parameter</a> den Tab mit.</p>
<p>Wenn jemand direkt auf "Index/Tab3" geht, wird im Controller ViewData["ActivTab"] auf "Tab3" gesetzt und somit wird Tab3 auch gerendert.</p>
<p><strong>Was hat man nun davon?</strong></p>
<p>Auf der einen Seite hat man die AJAX Funktionalität und auf der anderen Seite kann man trotzdem sehr einfach Direktlinks anbieten. Für Suchmaschinen ist dies sicherlich auch netter und es verlangt keine großer Javascriptspielerein und "Platzhalteranker" in der URL.</p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/mvctabboxen/mvctabboxen.zip">[ Download Democode ]</a></strong></p>
