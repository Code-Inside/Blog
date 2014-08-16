---
layout: post
title: "Einheiten und Schnittstellen"
date: 2012-10-24 16:11
author: oliver.guhr
comments: true
categories: [FailCode, HowToCode]
tags: [C#, Datentypen, Klassen, Schnisttellen]
---
{% include JB/setup %}
<p>Aufgrund der Objektorientierung beschreibt man als Entwickler seine zu bearbeitenden Daten in Objekte. Logisch. Das sieht dann so aus:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">public List&lt;Product&gt; GetProducts()</pre>
<p>Doch was ist mit grundlegenden Einheiten? Für das Datum gibts im Framework ja das DateTime Objekt, aber was ist mit all den anderen Einheiten: Liter, Meter, Gigabyte usw. ? Die einfachste Antwort der Entwickler ist: Naja, das sind ja meist ganze Zahlen, also nehme ich ein Integer. <br>Eine Schnittstelle sieht dann so aus: </p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">public void SetMailboxSize(int mailboxSize)</pre>
<p>Das ist natürlich sehr unglücklich und wirft sofort die Frage auf: Was muss ich jetzt da rein geben? Die Antwort des Kollegen sieht dann (oft) so aus: </p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;"><p>public void SetMailboxSize(int sizeInKilobyte)</p></pre>
<p>Ok, jetzt wissen wir was da rein muss alles klar. In meinem Fall hatte das so lange funktioniert bis wir feststellten, dass ich in <a href="http://de.wikipedia.org/wiki/Bit">Kibibit (also zur Basis 2) und er in Kilobit (zur Basis 10)</a> gerechnet hatte, was natürlich zu suboptimalen Ergebnissen führt. Das gemeine ist das dieser Fehler erst bei großen Datenmengen auffällt da der Unterschied beim 1 Gigabyte ja nur 24 Megabyte beträgt.</p>
<p>Ein weiteres Problem ist, dass man dieser Methode auch eine falsche Einheit übergeben kann. So könnte ein Entwickler einfach eine 1 übergeben, weil der Nutzer auf der Oberfläche ja auch 1 Gigabyte ausgewählt hat. Das Problem ist das ein Integer keine Aussagekraft über die Einheit hat und sie deshalb auch nicht validiert werden kann. Tja, und alles was schief gehen kann, geht auch irgendwann schief...</p>
<p>Deshalb ist es besser sich für alle Einheiten die man braucht auch eine Klasse anzulegen. </p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">public void SetMailboxSize(DataSize mailboxSize)</pre>
<p>Das hat nicht nur den Vorteil, dass man keine falschen Einheiten übergeben kann, sondern auch das man sämtlichen Code zum Umrechnen und Konvertieren der Einheit an einer Stelle hat. </p>
<p>Hier ein Beispiel wie so eine DataSize Klasse aussehen kann:</p>
<p>&nbsp;</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">  /// &lt;summary&gt;
    /// Stores information about the size of data. The base unit is Byte, multiples are expressed in powers of 2.
    /// &lt;/summary&gt;
    class DataSize
    {
        public enum Unit
        {            
            Kilo = 1,
            Mega = 2,
            Giga = 3,
            Terra = 4,
            Peta = 5,
            Yotta = 6
        }
        public DataSize()
        { }
        /// &lt;summary&gt;
        /// Create a new DataSize Object
        /// &lt;/summary&gt;
        /// &lt;param name="bytes"&gt;number of bytes&lt;/param&gt;
        public DataSize(UInt64 bytes)
        {
            Bytes = bytes;
        }

        /// &lt;summary&gt;
        /// Size of the data in Bytes 
        /// &lt;/summary&gt;
        public UInt64 Bytes { get; set; }

        /// &lt;summary&gt;
        /// converts the current value into 
        /// &lt;/summary&gt;
        /// &lt;param name="unit"&gt;&lt;/param&gt;
        /// &lt;returns&gt;&lt;/returns&gt;
        public Decimal ConvertTo(Unit unit)
        {            
            return Decimal.Divide(Bytes, (Decimal)Math.Pow(1024 ,(int)unit));
        }

        /// &lt;summary&gt;
        /// Loads an amount of bytes
        /// &lt;/summary&gt;
        /// &lt;param name="unit"&gt;unit to load&lt;/param&gt;
        /// &lt;param name="value"&gt;bytes to load&lt;/param&gt;
        public void GetFrom(Unit unit, Decimal value )
        {
            Bytes = Decimal.ToUInt64(value * (Decimal)Math.Pow(1024, (int)unit));
        }
    }</pre>
<p>Die Information wird intern in einer Basiseinheit, in diesem Fall Byte gespeichert und bei Bedarf umgerechnet. Das Ganze kann man natürlich für alle möglichen Einheiten tun und wesentlich erweitern. Wichtig ist nur, dass reale Einheiten auch einen eigenen Datentypen bekommen der klar macht um was es sich handelt. </p>
