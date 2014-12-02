---
layout: post
title: "HowTo: Fileupload with ASP.NET MVC"
date: 2011-02-23 20:49
author: antje.kilian
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, fileupload]
---
{% include JB/setup %}
<p>&#160;</p>  <p><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" border="0" alt="image" align="left" src="http://code-inside.de/blog/wp-content/uploads/image_thumb47.png" width="136" height="95" />In this HowTo I´m going to give you a short invitation how to implement a fileupload with ASP.NET MVC.</p>  <p><b></b></p>  <p><b></b></p>  <p><strong></strong></p>  <!--more-->  <p><b>The Controller</b></p>  <p>On the controller-side we create an ActionMethod named "FileUpload":</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:eeae8ff0-79eb-4c11-95bf-645067d3aba9" class="wlWriterEditableSmartContent"><pre name="code" class="c#">        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult FileUpload(HttpPostedFileBase file)
        {
            ViewData["Message"] = file.FileName + " - " + file.ContentLength.ToString();
            return View("Index");
        }</pre></div>

<p><a href="http://msdn.microsoft.com/en-us/library/system.web.httppostedfilebase.aspx">HttpPostedFileBase</a> is an abstract basic-class and has the same characteristics like <a href="http://msdn.microsoft.com/en-us/library/system.web.httppostedfile.aspx">HttpPostedFile</a>. That´s because you are able to make this with a UnitTest as well and create your own deductions from the abstract basic-class.</p>

<p>With "file" I´m able to reach several characteristics with this method and if I want to I can save the file:</p>

<p><a href="http://code-inside.de/blog-in/wp-content/uploads/image128.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://code-inside.de/blog-in/wp-content/uploads/image_thumb37.png" width="158" height="189" /></a></p>

<p>Now the Frontend:</p>

<p><b>The View </b></p>

<p>In the "index" view I create a formulary with the HTML Helper. </p>

<p><b>Important: </b>The fileupload only works when enctype="multipart/form-data" is activated!</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:da6c002d-7155-4b8b-98da-c8db77c3ff07" class="wlWriterEditableSmartContent"><pre name="code" class="c#">        &lt;%using(Html.BeginForm("FileUpload",
                               "Home",
                               FormMethod.Post,
                               new {enctype = "multipart/form-data"})) {%&gt;
        &lt;input type="file" name="file" id="file" /&gt;
        &lt;input type="submit" name="submit" value="Submit" /&gt;
        &lt;% } %&gt;</pre></div>

<p>Simple and fast <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-smile" alt="Smiley" src="http://code-inside.de/blog-in/wp-content/uploads/wlEmoticon-smile4.png" />&#160;</p>

<p><b>File size:</b></p>

<p>Usually you won´t be able to upload files with more than 4MB. But you can change this in the web.config: <a href="http://msdn.microsoft.com/en-us/library/system.web.configuration.httpruntimesection.maxrequestlength.aspx">maxRequestSize</a> </p>

<p><b></b></p>

<p><b>More Information´s</b></p>

<p>Scott Hanselman has written a <a href="http://www.hanselman.com/blog/ABackToBasicsCaseStudyImplementingHTTPFileUploadWithASPNETMVCIncludingTestsAndMocks.aspx">fantastic Blogpost</a> about this subject. It also includes how Unit-Tests could look like in such a case. </p>

<p><a href="http://code-inside.de/files/democode/mvcfileupload/mvcfileupload.zip">[Download Democode]</a></p>
