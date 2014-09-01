---
layout: post
title: "HowTo: Fileupload mit ASP.NET MVC"
date: 2009-11-02 02:28
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, File, HowTo, Upload]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image862.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="95" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb47.png" width="136" align="left" border="0"></a> In diesem HowTo wird schnell erklärt, wie man mit Hilfe von&nbsp; ASP.NET MVC einen Fileupload implementieren kann. </p> <p>&nbsp;</p><p><strong>Der Controller</strong></p> <p>Auf der Controller-Seite stellen wir eine ActionMethod namens "FileUpload" bereit:</p> <p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:10a5f804-e096-4029-bf81-3ddd9d6c33c4" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult FileUpload(HttpPostedFileBase file)
        {
            ViewData["Message"] = file.FileName + " - " + file.ContentLength.ToString();
            return View("Index");
        }</pre></div></p>
<p><a href="http://msdn.microsoft.com/en-us/library/system.web.httppostedfilebase.aspx">HttpPostedFileBase</a> ist eine abstrakte Basisklasse und enthält dieselben Eigenschaften wie <a href="http://msdn.microsoft.com/en-us/library/system.web.httppostedfile.aspx">HttpPostedFile</a>. Sinn dahinter ist, dass man diese Funktionalität auch mit einem UnitTest hinterlegt und sich dabei eigene Ableitungen von der abstrakten Basisklasse machen kann. </p>
<p>Über "file" habe ich in dieser Methode Zugriff auf bestimmte Eigenschaften und kann das File z.B. auch speichern:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image863.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="189" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb48.png" width="158" border="0"></a> </p>
<p>Nun zum Frontend:</p>
<p><strong>Der View</strong></p>
<p>Im "Index" View erstelle ich über die HTML Helper ein Formular. <br><strong>Wichtig:</strong> Nur wenn enctype="multipart/form-data" angegeben ist, funktioniert der Fileupload!</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:07c678d2-78c8-46a6-adc2-e83086121726" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        &lt;%using(Html.BeginForm("FileUpload", 
                               "Home", 
                               FormMethod.Post,
                               new {enctype = "multipart/form-data"})) { %&gt;
        &lt;input type="file" name="file" id="file" /&gt;
        &lt;input type="submit" name="submit" value="Submit" /&gt;
        &lt;% } %&gt;</pre></div>
<p>Simpel und fix gemacht :)</p>
<p><strong>Dateigröße</strong></p>
<p>Im Standardfall dürfen nur Files bis 4MB hochgeladen werden. Dies kann aber in der Web.config geändert werden: <a href="http://msdn.microsoft.com/en-us/library/system.web.configuration.httpruntimesection.maxrequestlength.aspx">maxRequestSize</a></p>
<p><strong>Mehr Informationen</strong></p>
<p>Scott Hanselman hat <a href="http://www.hanselman.com/blog/ABackToBasicsCaseStudyImplementingHTTPFileUploadWithASPNETMVCIncludingTestsAndMocks.aspx">einen genialen Blogpost</a> darüber verfasst. Auch wie genau Unit-Tests in einem solchen Fall aussehen könnten. </p>
<p><a href="{{BASE_PATH}}/assets/files/democode/mvcfileupload/mvcfileupload.zip"><strong>[ Download Democode ]</strong></a></p>
