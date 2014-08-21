---
layout: post
title: "Excel/CSV-Export über ASP.NET: Encoding / Darstellung von Umlaute & Render View To String mit Razor"
date: 2011-08-23 00:13
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET, ASP.NET MVC, CSV, Encoding, Excel, Razor]
---
{% include JB/setup %}
<p>Einfacher Task eigentlich: Auf einer Website soll es einen Excel Export oder besser gesagt einen CSV-Export geben. Allerdings hatte ich dabei (mal wieder) mit Umlauten zu kämpfen, daher hier der ultimative Tipp um sowas zu vermeiden (der Tipp und die Beispiele stammen von <a href="http://stackoverflow.com/questions/1679656/asp-net-excel-export-encoding-problem">dieser Stackoverflow Frage</a>) :</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1339.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb521.png" width="134" height="102"></a>“Eingabe Kosten je GerÃ¤t GerÃ¤t: GerÃ¤tebezeichnung: Betriebsmittel HeizÃ¶l in ‚¬:&nbsp;&nbsp;&nbsp; 4 Dieselverbrauch in ‚¬: 4”</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>Ich beschreibe mal die verschiedenen Punkte, wie ich die Anforderung gelöst habe.</p> <p><strong>Als erstes zum Umlautproblem - der funktionierende Code:</strong></p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:72a925dc-18a9-47fb-9e0e-752df49735f5" class="wlWriterEditableSmartContent"><pre name="code" class="c#">Response.Clear();
Response.AddHeader("content-disposition","attachment;filename=Test.xls");   
Response.ContentType = "application/ms-excel";
Response.ContentEncoding = System.Text.Encoding.Unicode;
Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());

System.IO.StringWriter sw = new System.IO.StringWriter();
System.Web.UI.HtmlTextWriter hw = new HtmlTextWriter(sw);

FormView1.RenderControl(hw);

Response.Write(sw.ToString());
Response.End();</pre></div>
<p>&nbsp;</p>
<p><strong>Was ist der Knackpunkt? </strong></p>
<p>In Zeile 5 wird das <a href="http://en.wikipedia.org/wiki/Byte_order_mark">BOM (Unicode.GetPreamble())</a> noch hinzugefügt. Nur dadurch schnallt Excel, dass es sich um Unicode handelt und stellt auch Umlaute dar. Laut Wikipedia Artikel gibt es allerdings ein paar Probleme mit "nicht-Excel” Anwendungen. Najo… </p>
<p><strong>Excel-Export über HTML Tabellen</strong></p>
<p>Eine andere, sehr simple Möglichkeit habe ich früher mal <a href="http://code-inside.de/blog/2010/01/29/howto-excel-export-mit-asp-net-mvc-und-render-view-to-string/">gebloggt</a>. Im Grunde schickt man Excel einen HTML Tabelle und Excel kann das recht gut darstellen, solange es nicht zu kompliziert wird. IMHO hat dies den Vorteil gegenüber OpenXML etc., dass man keine weiteren Bibliotheken nutzen muss. Die HTML Tabelle kann man auch schöner gestalten als ein CSV ;)</p>
<p><strong>Render View To String im Razor Zeitalter</strong></p>
<p>Der in meinem alten Post beschrieben Ansatz funktioniert nicht mehr ganz (bzw. geht es mit Razor deutlich einfacher).Auch hier wieder ein Hoch auf <a href="http://stackoverflow.com/questions/4692131/how-to-render-a-razor-view-get-the-html-of-a-rendered-view-inside-an-action">Stackoverflow</a> (ich war mal so frei, das Exception-Handling rauszubauen, da es mir nicht wirklich elegant vorkam) :</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:1d904a5d-c8e8-4b02-aea7-f9f46a05577e" class="wlWriterEditableSmartContent"><pre name="code" class="c#">public static string RenderPartialViewToString(Controller controller, string viewName, object model)
        {
            controller.ViewData.Model = model;

           using (StringWriter sw = new StringWriter())
           {
                ViewEngineResult viewResult = ViewEngines.Engines.FindPartialView(controller.ControllerContext, viewName);
                ViewContext viewContext = new ViewContext(controller.ControllerContext, viewResult.View, controller.ViewData, controller.TempData, sw);
                viewResult.View.Render(viewContext, sw);

            	return sw.GetStringBuilder().ToString();		
			}
        }</pre></div>
<p>&nbsp;</p>
<p><strong>Last Tipp: Ein eigenes ActionResult lohnt.</strong></p>
<p>Um das ganze in das ASP.NET MVC Universum gut einzubauen, lohnt es sich ein eigenes ActionResult zu bauen. Wie man das macht, sieht man <a href="http://stephenwalther.com/blog/archive/2008/06/16/asp-net-mvc-tip-2-create-a-custom-action-result-that-returns-microsoft-excel-documents.aspx">hier</a>. Dieses ActionResult war auch schon in meinem älteren <a href="http://code-inside.de/blog/2010/01/29/howto-excel-export-mit-asp-net-mvc-und-render-view-to-string/">Blogpost</a> zu sehen.</p>
