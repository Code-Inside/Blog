---
layout: post
title: "HowTo: Generisches speichern und laden von XML Dateien bzw. wozu sind Generics gut?"
date: 2008-06-04 10:05
author: oliver.guhr
comments: true
categories: [Allgemein, HowTo]
tags: [.NET, C#, generics, Generische Datentypen, Xml]
language: de
---
{% include JB/setup %}
<p>Immmer wenn ich eine Xml Datei lesen oder schreiben will fange ich wieder an <a href="http://dotnet-snippets.de/dns/objekt-in-xml-speichern-serialisieren-SID150.aspx">das Code-Snippet dafür zu suchen</a> und an meine Objekttypen anzupassen. Also habe ich mir jetzt mal eine generische Version geschrieben. Das T steht dabei für den noch unbekannten Typ der erst zur Laufzeit übergeben wir.<br><code></p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:db548ef4-2a78-4439-8dfa-52dd184f0766" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public static void Save&lt;T&gt;(String path, T obj)
        {
            XmlSerializer Serializer = new XmlSerializer(typeof(T));
            FileStream Stream = new FileStream(path, FileMode.Create);
            Serializer.Serialize(Stream, obj);
            Stream.Close();
        }

        public static T Load&lt;T&gt;(String path)
        {
            XmlSerializer Serializer = new XmlSerializer(typeof(T));
            StreamReader Stream = new StreamReader(path);
            T myObject = (T)Serializer.Deserialize(Stream);
            Stream.Close();
            return myObject;
        }</pre></div>
<p></code>Der Zugriff erfolgt so:<br>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:f6852ae0-3ef3-4f29-82e0-1b9aa943efdf" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">// Daten
            String TestString = "Hallo Xml Welt";
            //schreiben..
            Save&lt;String&gt;("C:\\test.xml", TestString);
            //und lesen
            Debug.WriteLine(Load&lt;String&gt;("C:\\test.xml"));</pre></div></p>
