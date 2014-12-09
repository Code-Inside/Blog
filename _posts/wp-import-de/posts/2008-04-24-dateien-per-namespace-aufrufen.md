---
layout: post
title: "Dateien per Namespace aufrufen"
date: 2008-04-24 09:31
author: oliver.guhr
comments: true
categories: [Allgemein]
tags: [.NET, ASP.NET, C#, Embedded Resource, Namespace, Xml, XmlSerializer]
language: de
---
{% include JB/setup %}
Ich hatte ver kurzem das Problem das ich auf eine XML Datei in meinem Projekt zugreifen musste aber den genauen Pfad nicht kannte. Das erzeugen eines dynamischen Pfades per "AppDomain.CurrentDomain.BaseDirectory" war nicht möglich da ich mit Usercontrols arbeitete und so nur den Pfad der Datei bekam die mein Uercontrol einbindet. 
Gelöst habe ich das Problem in dem ich über den Namespace auf die XML Datei zugegriffen habe:

<pre>
// XmlResource  = Namespace + Dateiname
string XmlResource = "CodeInside.WebApp." + "Daten.xml";

  using (Stream FileStream = System.Reflection.Assembly.
    GetExecutingAssembly().GetManifestResourceStream(XmlResource))
  {
    XmlSerializer Ser = new XmlSerializer(typeof(List<string>));
    StreamReader Sr = new StreamReader(FileStream );
    List<NameValue> Data = (List<string>)Ser.Deserialize(Sr);
    Sr.Close();              
  }
</pre>

Damit man auf die Datei auch zugreifen kann muss man in den Eigeschaften der Datei das Feld "Build Action" auf "Embedded Resource" stellen. 
<img src='{{BASE_PATH}}/assets/wp-images-de/xml.JPG' alt='Embedded Resource' />
