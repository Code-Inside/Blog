---
layout: post
title: "HowTo: Interfaces/Schnittstellen verstehen - mal auf simple Art und Weise"
date: 2007-11-28 21:11
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, OOP]
---
{% include JB/setup %}
<p>In dem HowTo geht es um ein sehr simples Thema, womit aber besonders Einsteiger in der Programmierung Probleme haben: Wozu sind Schnittstellen/Interfaces gut? Man kann doch auch genauso gut von einer Klasse erben - also wozu der Spaß und wo kann man das sinnvoll einsetzen?</p> <p>Wir machen das sehr kurz und schmerzlos an einem "praktischen" Beispiel aus der Natur ;)</p> <p>In unserem sehr einfachen Beispiel wollen wir bestimmte Klasse (<em>Train, Car, Human</em>) erstellen welche beweglich sind (<em>IMovable</em>) - jedoch bewegt sich ja alles auf eine unterschiedliche Art und Weise, daher ist das unsere Schnittstelle.<br>Jetzt gehen wir mal davon aus, dass es einen Gott (<em>God</em>) gibt, dann kann der&nbsp;auch ohne Probleme&nbsp;ein bewegliches Objekt "anstupsen". Genau das wollen wir jetzt implementieren - wie gesagt, sehr praxisnah ;).&nbsp;</p> <p><strong>Konsolenprojekt Struktur:</strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image170.png" atomicselection="true"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="186" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb149.png" width="240" border="0"></a> </p> <p>Das wichtigste ist erstmal unser Interface "<strong>IMovable</strong>" (Schnittstellen werden in .NET immer mit einem I davor geschrieben):</p> <div class="CodeFormatContainer"><pre class="csharpcode">    <span class="kwrd">public</span> <span class="kwrd">interface</span> IMovable
    {
        <span class="kwrd">void</span> Move();
    }</pre></div>
<p>Die Schnittstelle legt nur fest, welche Methoden, Eigenschaften oder Events etwas hat - wie dies jeweils implementiert ist entscheidet dann die Klasse.</p>
<div class="CodeFormatContainer"><pre class="csharpcode">    <span class="kwrd">public</span> <span class="kwrd">class</span> Human : IMovable
    {
        <span class="preproc">#region</span> IMovable Member

        <span class="kwrd">public</span> <span class="kwrd">void</span> Move()
        {
            Console.WriteLine(<span class="str">"Der Mensch macht einen Schritt vor."</span>);
        }

        <span class="preproc">#endregion</span>
    }</pre></div>
<p>Unser Mensch kann einen Schritt vor dem anderen machen - unser Zug fährt zum nächsten Bahnhof und unser Auto nur zur nächsten Ampel. In den einzelnen Klassen kann man nun die Methode implementieren wie man mag - wichtig ist nur, dass die Signatur (also Rückgabetyp, Parameter &amp; Name) gleich bleibt.</p>
<p>Jetzt wollen wir unseren Gott implementieren, welcher Objekte "anstupsen" kann. Allerdings wollen wir nicht X Methoden erstellen, die in dieser Form sind "MoveObject(Human human)", weil wir noch nicht genau wissen, was sonst noch für bewegliche Klassen hinzukommen.</p>
<p>Hier kommt jetzt unser Interface zum Einsatz:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">    <span class="kwrd">public</span> <span class="kwrd">class</span> God
    {
        <span class="kwrd">public</span> <span class="kwrd">static</span> <span class="kwrd">void</span> MoveObject(IMovable item)
        {
            Console.WriteLine(<span class="str">"Ein bewegliches Objekt wird bewegt..."</span>);
            item.Move();
        }
    }</pre></div>
<p>Die Methode "<strong>MoveObject</strong>" nimmt einfach "irgendwas" was "<strong>IMovable</strong>" impementiert - egal ob es ein Auto, Zug oder Mensch ist.<br>Allerdings kann man in dieser Version jetzt nur auf die Methoden, Eigenschaften etc. zugreifen, welche in der Schnittstelle definiert sind:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image171.png" atomicselection="true"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="144" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb150.png" width="429" border="0"></a> </p>
<p>Wenn man jetzt beim Auto noch eine spezial Methode implementiert hat, welche man unbedingt dort aufrufen will, muss man casten und über GetType prüfen, ob das Objekt von Typ "Car" ist - aber das geht zu weit und ist jetzt erstmal kein Thema hier.<br></p>
<p>Der Hauptvorteil jetzt liegt darin, dass unsere "<strong>MoveObject</strong>" Methode keine Ahnung haben braucht, was "<strong>item</strong>" einfach ist - hauptsache es ist beweglich. Was beweglich bei diesem Objekt heisst, ist dieser Methode egal.<br></p>
<p>Unser kleines Programm testen:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">    <span class="kwrd">class</span> Program
    {
        <span class="kwrd">static</span> <span class="kwrd">void</span> Main(<span class="kwrd">string</span>[] args)
        {
            Car BMW = <span class="kwrd">new</span> Car();
            Train ICE = <span class="kwrd">new</span> Train();
            Human Robert = <span class="kwrd">new</span> Human();

            God.MoveObject(BMW);
            God.MoveObject(ICE);
            God.MoveObject(Robert);

            Console.ReadLine();
        }
    }</pre></div>
<p>Wir haben ein BMW, ein ICE und mich - und diese bewegt unser Gott natürlich. Resultat:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image172.png" atomicselection="true"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="244" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb151.png" width="489" border="0"></a> </p>
<p>So - alle unsere 3 Objekte bewegen sich anders und es wird angezeigt. Jetzt kann man noch weitere Klassen hinzufügen, welche ebenfalls "IMovable" implementieren und wir brauchen die God.MoveObject Methode nicht anpassen.</p>
<p>OlÃ© ;)</p>
<p>PS: Nein, ich bin nicht religös, brauchte aber ein einfaches Beispiel.</p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/usinginterfaces/usinginterfaces.zip" target="_blank">[ Download Source Code ]</a></strong></p>
