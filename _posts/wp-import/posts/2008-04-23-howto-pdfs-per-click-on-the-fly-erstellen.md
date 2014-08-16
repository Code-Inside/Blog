---
layout: post
title: "HowTo: PDFs per Click on-the-fly erstellen"
date: 2008-04-23 20:55
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Export, FO, Handler, HowTo, NFop, PDF, Xml, XSLT]
---
{% include JB/setup %}
<p>Vor einiger Zeit hat Oliver bereits ein nettes Beispiel gebracht wie man mit <a href="http://sourceforge.net/projects/nfop/">nFop</a> ein <a href="http://code-inside.de/blog/2007/12/06/howto-pdfs-erstellen-unter-net-mit-nfop/">PDF Dokument erzeugt</a>.</p> <p>In dem heutigen HowTo geht es darum, PDFs per "klick" auf einem normalen Link zu erzeugen, z.B. wenn man auf einer Webseite einen PDF Export möchte.</p> <p>Oliver hat mir freundlicherweise sehr geholfen und der Code stammt von ihm :)</p> <p><strong>Kurze Vorbereitung: J# dlls installieren</strong></p> <p>Ich hab nur VS 2008 installiert - dabei wurde allerdings wohl die J# Bibliotheken nicht mit installiert - die "vjslib.dll" kann hier aber runtergeladen werden: <a href="http://msdn2.microsoft.com/en-us/vjsharp/bb188598.aspx">Visual J# Redistributable Packages</a></p> <p><strong>Ein Generic Handler ist die Lösung</strong></p> <p>Da nFop allerdings auf die J# Bibliothek aufbaut, ist es etwas schwieriger das PDF in den content reinzuschreiben, hier der komplette Code:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:923ad05a-8302-4cec-9a70-ad42665e24b4" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;%@ WebHandler Language="C#" Class="PdfHandler" %&gt;

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
<p>Das komplette Projekt sieht so aus:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image397.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="169" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb376.png" width="202" border="0"></a> </p>
<p>Die helloworld.fo:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:6f1037ff-8db6-43ed-9cc4-a4361a05f04a" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;?xml version="1.0" encoding="utf-8"?&gt;
&lt;fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format”&gt;
  &lt;fo:layout-master-set&gt;
    &lt;fo:simple-page-master  master-name=”A4”³
                            page-width=”210mm” page-height=”297mm”&gt;
      &lt;fo:region-body region-name=”xsl-region-body”  margin=”2cm”/&gt;
    &lt;/fo:simple-page-master&gt;
  &lt;/fo:layout-master-set&gt;

  &lt;fo:page-sequence  master-reference=”A4”³&gt;
    &lt;!- (in Versionen &lt;2.0 "master-name”) -&gt;
    &lt;fo:flow flow-name=”xsl-region-body”&gt;
      &lt;fo:block&gt;Hallo Welt!&lt;/fo:block&gt;   
    &lt;/fo:flow&gt;
  &lt;/fo:page-sequence&gt;

&lt;/fo:root&gt;</pre></div>
<p>Am Ende kann man es einfach über den Link aufrufen:<br><a href="http://localhost:56602/Pdf/PdfHandler.ashx">http://localhost:56602/Pdf/PdfHandler.ashx</a></p>
<p>Fertig :)</p>
<p><a href="http://{{BASE_PATH}}/assets/files/democode/pdfonthefly/pdfonthefly.zip">[ Download Democode ]</a></p>
