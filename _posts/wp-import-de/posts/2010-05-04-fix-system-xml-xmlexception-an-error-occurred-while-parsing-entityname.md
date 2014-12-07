---
layout: post
title: "Fix: “System.Xml.XmlException: An error occurred while parsing EntityName.”"
date: 2010-05-04 23:48
author: robert.muehsig
comments: true
categories: [Fix]
tags: [Error, Exception, Xml]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image966.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb151.png" width="199" height="108" /></a> </p>  <p>Ich hatte heute mit einem kleinen XML Problem zu kämpfen. Bei der Generierung des XMLs trat der oben genannte Fehler auf. Problemlösung in kurz: "&amp;”, "&lt;” &amp; "&gt;” maskieren wenn man <a href="http://msdn.microsoft.com/de-de/library/system.xml.xmlelement.innerxml.aspx">InnerXml</a> setzt oder "vollständiges” Xml Element setzen.</p>  <p><strong>Problemfall:</strong></p>  <p>   <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:69aa5c86-11b8-440b-b9b9-30673e674f2e" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    class Program
    {
        static void Main(string[] args)
        {
            XmlDocument doc = new XmlDocument();
            XmlElement element = doc.CreateElement("element");
            element.InnerXml = "hello &amp; good bye";
        }
    }</pre></div>
Dieser Code endet mit einer Exception. Entweder man setzt InnerText oder maskiert das "&amp;”. Das gleiche gilt auch für "&lt;” bzw. "&gt;” z.B. mit <a href="http://msdn.microsoft.com/de-de/library/system.web.httputility.htmlencode.aspx">HttpUtility.HtmlEncode</a>. Wenn man komplettes, valides XML reingibt funktioniert es auch:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b65ad8f3-87d9-46d4-a119-7c3c2d9f3c11" class="wlWriterEditableSmartContent"><pre name="code" class="c#">        static void Main(string[] args)
        {
            XmlDocument doc = new XmlDocument();
            XmlElement element = doc.CreateElement("element");
            element.InnerXml = "hello &lt;test&gt;&lt;/test&gt; good bye";
        }</pre></div>

<p></p>

<p>Eigentlich völlig logisch. Problematisch wird es nur wenn man z.B. HTML Markup wie "&lt;br/&gt;” und vom User eingegebene Texte (wo auch ein "&amp;” oder "&lt;” drin stehen könnte) auftauchen. Da die Fehlermeldung mir recht nichtsagend war, hab ich mir gedacht es zu bloggen. :)</p>
