---
layout: post
title: "HowTo: Create PDF by click - on the fly"
date: 2008-04-23 22:06
author: codemin
comments: true
categories: [HowTo]
tags: [Export, FO, Handler, HowTo, nFop, PDF, Xml, XSLT]
language: en
---
{% include JB/setup %}
<p>My college Oliver Guhr wroted a <a href="http://code-inside.de/blog/2007/12/06/howto-pdfs-erstellen-unter-net-mit-nfop/">nice blogpost about PDF creation</a> with <a href="http://sourceforge.net/projects/nfop/">nFop</a>. The post is in german - but just scroll down to download the soure code. </p>  <p>Today I wanted to show you, how you could create a PDF by just clicking a link on a webpage. Oliver helped me again and wrote the source code of this blog post:</p>  <p><strong>First step: J# dlls</strong></p>  <p>I only have Visual Studio 2008 installed - without the Visual J# library - the &quot;vjslib.dll&quot;. You need this dll for nFop. If you don&#180;t have this dll, just download it here: <a href="http://msdn2.microsoft.com/en-us/vjsharp/bb188598.aspx">Visual J# Redistributable Packages</a></p>  <p><strong>The solution: A generic handler</strong></p>  <p>It&#180;s a bit tricky to write the PDF content in the context - here is the complete source code from my ASHX:</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:923ad05a-8302-4cec-9a70-ad42665e24b4" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;%@ WebHandler Language="C#" Class="PdfHandler" %&gt;

using System;
using System.Data;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using java.io;
using org.xml.sax;
using org.apache.fop.apps;
using System.IO;


[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class PdfHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/pdf";                     
        FileInputStream input = new FileInputStream(context.Request.PhysicalApplicationPath+"helloworld.fo");
        InputSource source = new InputSource(input);

        java.io.ByteArrayOutputStream output = new ByteArrayOutputStream();

        Driver driver = new Driver(source, output);
        driver.setRenderer(Driver.RENDER_PDF);
        driver.run();
        output.close();

        sbyte[] Pdf = output.toByteArray();
        BinaryWriter bw = new BinaryWriter(context.Response.OutputStream);           
        for (int i = 0; i &lt; Pdf.Length; i++)
        {
            bw.Write(Pdf[i]);
        }

        bw.Close();
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}

</pre></div>

<p>A look into the solution explorer:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image18.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="169" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb18.png" width="202" border="0" /></a> </p>

<p>The helloworld.fo:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:3d382950-0f8c-4337-93d9-18df49daa38c" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;?xml version="1.0" encoding="utf-8"?&gt;
&lt;fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format"&gt;
  &lt;fo:layout-master-set&gt;
    &lt;fo:simple-page-master  master-name="A4"³
                            page-width="210mm" page-height="297mm"&gt;
      &lt;fo:region-body region-name="xsl-region-body"  margin="2cm"/&gt;
    &lt;/fo:simple-page-master&gt;
  &lt;/fo:layout-master-set&gt;

  &lt;fo:page-sequence  master-reference="A4"³&gt;
    &lt;!- (in Versionen &lt;2.0 "master-name") -&gt;
    &lt;fo:flow flow-name="xsl-region-body"&gt;
      &lt;fo:block&gt;Hallo Welt!&lt;/fo:block&gt;   
    &lt;/fo:flow&gt;
  &lt;/fo:page-sequence&gt;

&lt;/fo:root&gt;</pre></div>

<p>Now you can create the &quot;helloworld&quot; PDF by just clicking this link: 
  <br /><a href="http://localhost:56602/Pdf/PdfHandler.ashx">http://localhost:56602/Pdf/PdfHandler.ashx</a></p>

<p>Easy :)</p>

<p><a href="{{BASE_PATH}}/assets/files/democode/pdfonthefly/pdfonthefly.zip">[ Download Democode ]</a></p>
