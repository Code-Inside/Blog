---
layout: post
title: "Vergleichstest: String vs. StringBuilder"
date: 2007-07-11 19:03
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [.NET]
---
{% include JB/setup %}
Oft sieht man solchen Code:

<em>String simplestring = "Hallo ";
simplestring += "du ";</em>

Dieser Code ist, zwar recht einfach zu verstehen, allerdings unperformanter als die "richtige" Variante.
Lieber den StringBuilder mit der <em>Append</em> Methode benutzen:Â 

<strong>Meine Testapplikation </strong>

<em>(Entschuldigung für die miese Formatierung - ich muss mich mal nach einem netten Plugin umschauen)</em>

<font size="2">
<blockquote><font size="2" color="#0000ff">internal class</font><font size="2"> </font><font size="2" color="#2b91af">Program
</font><font size="2">{
</font><font size="2" color="#0000ff">Â Â Â Â  static</font><font size="2"> </font><font size="2" color="#0000ff">void</font><font size="2"> Main(</font><font size="2" color="#0000ff">string</font><font size="2">[] args)
Â Â Â Â  {
</font><font size="2" color="#2b91af">Â Â Â Â  Console</font><font size="2">.WriteLine(</font><font size="2" color="#a31515">"String vs. StringBuilder"</font><font size="2">);
</font><font size="2" color="#2b91af">Â Â Â Â  Console</font><font size="2">.WriteLine();
</font><font size="2" color="#2b91af">Â Â Â Â  Console</font><font size="2">.WriteLine(</font><font size="2" color="#a31515">"1. String mit +="</font><font size="2">);
Â Â Â Â  StringAppend();
</font><font size="2" color="#2b91af">Â Â Â Â  Console</font><font size="2">.WriteLine();
</font><font size="2" color="#2b91af">Â Â Â Â  Console</font><font size="2">.WriteLine(</font><font size="2" color="#a31515">"2. String mit StringBuilder"</font><font size="2">);
Â Â Â Â  StringBuilderAppend();
</font><font size="2" color="#2b91af">Â Â Â Â  Console</font><font size="2">.ReadLine();
Â Â Â Â  }</font><font size="2"><font size="2" color="#0000ff">Â Â Â Â  </font></font>

<font size="2"><font size="2" color="#0000ff">Â Â Â Â  public</font><font size="2"> </font><font size="2" color="#0000ff">static</font><font size="2"> </font><font size="2" color="#0000ff">void</font><font size="2"> StringAppend()
</font><font size="2">Â Â Â Â  {
</font><font size="2" color="#2b91af">Â Â Â Â Â Stopwatch</font><font size="2"> sw = </font><font size="2" color="#0000ff">new</font><font size="2"> </font><font size="2" color="#2b91af">Stopwatch</font><font size="2">();
Â Â Â Â  sw.Start();
</font><font size="2" color="#2b91af">Â Â Â Â  String</font><font size="2"> returnString = </font><font size="2" color="#a31515">"Test"</font><font size="2">;
</font><font size="2" color="#0000ff">Â Â Â Â  for</font><font size="2"> (</font><font size="2" color="#0000ff">int</font><font size="2"> i = 0; i &lt; 100; i++)
Â Â Â Â Â {
Â Â Â Â Â Â Â Â Â Â  returnString += <font color="#a31515">"Test"</font><font size="2">;
</font></font></font><font size="2"><font size="2">Â Â Â Â Â  }
Â Â Â Â Â  sw.Stop();
Â Â Â Â Â  </font><font size="2" color="#2b91af">Console</font><font size="2">.WriteLine(sw.Elapsed.TotalMilliseconds.ToString());
Â Â Â Â  }</font></font><font size="2"><font size="2" color="#0000ff">Â Â Â Â  </font></font>

<font size="2"><font size="2" color="#0000ff">Â Â Â Â Â  public</font><font size="2"> </font><font size="2" color="#0000ff">static</font><font size="2"> </font><font size="2" color="#0000ff">void</font><font size="2"> StringBuilderAppend()
Â Â Â Â  {
</font><font size="2" color="#2b91af">Â Â Â Â Â  Stopwatch</font><font size="2"> sw = </font><font size="2" color="#0000ff">new</font><font size="2"> </font><font size="2" color="#2b91af">Stopwatch</font><font size="2">();
Â Â Â Â Â  sw.Start();
</font><font size="2" color="#2b91af">Â Â Â Â Â  StringBuilder</font><font size="2"> returnString = </font><font size="2" color="#0000ff">new</font><font size="2"> </font><font size="2" color="#2b91af">StringBuilder</font><font size="2">(</font><font size="2" color="#a31515">"Test"</font><font size="2">);
</font><font size="2" color="#0000ff">Â Â Â Â Â  for</font><font size="2"> (</font><font size="2" color="#0000ff">int</font><font size="2"> i = 0; i &lt; 100; i++)
Â Â Â Â Â Â {
Â Â Â Â Â Â Â Â Â Â Â  returnString.Append(</font><font size="2" color="#a31515">"Test"</font><font size="2">);
Â Â Â Â Â Â  }
Â Â Â Â Â  sw.Stop();
</font><font size="2" color="#2b91af">Â Â Â Â  Console</font><font size="2">.WriteLine(sw.Elapsed.TotalMilliseconds.ToString());
Â Â Â Â Â }
</font><font size="2">}</font></font></blockquote>
<em>Ergebnisse:</em>

PC Konfiguration:
- Windows Vista
- Visual Studio 2005
- Centrino 2Ghz
- 1GB Arbeitsspeicher

<strong>1. Durchlauf:
</strong>String Verknüpfung durch "+=": 0,7654 Millisekunden
String Verknüpfung mit dem StringBuilder: 0,0371 Millisekunden

<strong>2. Durchlauf:
</strong>String Verknüpfung durch "+=": 1,3686 Millisekunden
String Verknüpfung mit dem StringBuilder: 0,0609 Millisekunden

</font><strong>3. Durchlauf:</strong>
String Verknüpfung durch "+=": 0,7886M illisekunden
String Verknüpfung mit dem StringBuilder: 0,0259 Millisekunden

Fazit:
Der StringBuilder ist hier (trotz der Schwankungen) doch wesentlichÂ schneller. Man könnte den Code noch weiter Optimieren, da man dem StringBuilder im Konstruktor noch einen Integer übergeben kann, damit bereits mehr Speicher reserviert wird.
