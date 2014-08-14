---
layout: post
title: "SASS, LESS & Coffeescript in Visual Studio mit der Web Workbench"
date: 2012-05-13 22:05
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [.LESS, CoffeeScript, Combres, Sass, Visual Studio]
---
<p>CSS und Javascript sind die “kleinste” Schnittmenge von allen Browsern für die Erstellung von Web-Applikationen. Leider geht dabei etwas komfort verloren, daher lieben alle Webentwickler jQuery! SASS und LESS sind zwei Varianten, wie man “schöner” CSS schreiben kann und Coffeescript versucht Javascript Entwicklung zu vereinfachen. Aber immer der Reihe nach…</p> <p><strong>Was ist SASS?</strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1544.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb708.png" width="214" height="240"></a></p> <p>SASS steht für Syntactically Awesome Stylesheets und kommt ursprünglich aus der Ruby Welt. SASS ist eine Erweiterung von CSS3 und erweitert den Syntax um einige praktische funktionionen, wie z.B. definition von Variablen oder erweiterte Verschachtelung von Style. Eine komplette Liste <a href="http://sass-lang.com/">kann man hier</a> sehen.</p> <p>Grundsätzlich war hier die Idee: Man schreibt seinen Stylecode in SASS und er wird während der Entwicklung stetig nach CSS “kompiliert” bzw. transformiert (was man auch immer dazu sagen möchte).</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>Bsp:</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b3cd36e7-0c39-4df6-8af3-a79b9bebfaaa" class="wlWriterEditableSmartContent"><pre name="code" class="xml">$blue: #3bbfce;
$margin: 16px;

.content-navigation {
  border-color: $blue;
  color:
    darken($blue, 9%);
}

.border {
  padding: $margin / 2;
  margin: $margin / 2;
  border-color: $blue;
}</pre></div>
<p>&nbsp;</p>
<p>Wird zu:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:0697f785-9653-4b4d-8c45-3906e9111520" class="wlWriterEditableSmartContent"><pre name="code" class="c#">/* CSS */

.content-navigation {
  border-color: #3bbfce;
  color: #2b9eab;
}

.border {
  padding: 8px;
  margin: 8px;
  border-color: #3bbfce;
}</pre></div>
<p>&nbsp;</p>
<p><strong>Was ist LESS?</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1545.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 5px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb709.png" width="212" height="117"></a></p>
<p><a href="http://lesscss.org/">LESS</a> “the dynamic stylesheet language” hat einen ähnlichen Funktionsumfang wie SASS und verfolgt dasselbe Ziel. Ursprünglich war die Idee hier, dass der Client (über Javascript) das CSS erzeugt. Ich habe auch schon über LESS <a href="http://code-inside.de/blog/2011/06/28/lessdynamische-stylesheets-fr-net-entwickler/">hier gebloggt</a> und dort eine Serverseitige Variante mit dem Framework Combres gezeigt.</p>
<p>&nbsp;</p>
<p>Bsp:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c0366225-9d70-4966-a1c9-ebf1afc47fbc" class="wlWriterEditableSmartContent"><pre name="code" class="c#">@color: #4D926F;

#header {
  color: @color;
}
h2 {
  color: @color;
}</pre></div>
<p>Wird zu:</p>
<p>&nbsp;</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ee28986a-0b7c-414c-b72c-d7595785110d" class="wlWriterEditableSmartContent"><pre name="code" class="c#">#header {
  color: #4D926F;
}
h2 {
  color: #4D926F;
}</pre></div>
<p>&nbsp;</p>
<p><strong>Was ist CoffeeScript?</strong></p>



<p><a href="{{BASE_PATH}}/assets/wp-images/image1546.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb710.png" width="240" height="48"></a></p>
<p><a href="http://coffeescript.org/">CoffeeScript</a> soll die Entwicklung mit Javascript vereinfachen. Javascript hat einige Tücken zu bieten und einige Schreibweisen sind etwas seltsam. CoffeeScript sieht für C# Entwickler etwas seltsam aus, da man bewusst auf einige Syntax-Elemente verzichtet. Am Ende soll natürlich wieder Javascript Code verstehen, sodass man es auch in allen Browsern ohne Probleme ausführen kann. Insbesondere könnte diese “Sprache” für Node.js Entwickler interessant sein – rein aus der Natur heraus :)</p>
<p>Bsp:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5a02a471-7d0f-4c62-a76d-ed9714596be8" class="wlWriterEditableSmartContent"><pre name="code" class="c#"># Assignment:
number   = 42
opposite = true

# Conditions:
number = -42 if opposite

# Functions:
square = (x) -&gt; x * x

# Arrays:
list = [1, 2, 3, 4, 5]

# Objects:
math =
  root:   Math.sqrt
  square: square
  cube:   (x) -&gt; x * square x

# Splats:
race = (winner, runners...) -&gt;
  print winner, runners

# Existence:
alert "I knew it!" if elvis?

# Array comprehensions:
cubes = (math.cube num for num in list)</pre></div>
<p>&nbsp;</p>
<p>Wird zu:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:1ee8ab20-a996-4995-ba9f-e57f0ffb569a" class="wlWriterEditableSmartContent"><pre name="code" class="c#">var cubes, list, math, num, number, opposite, race, square,
  __slice = [].slice;

number = 42;

opposite = true;

if (opposite) {
  number = -42;
}

square = function(x) {
  return x * x;
};

list = [1, 2, 3, 4, 5];

math = {
  root: Math.sqrt,
  square: square,
  cube: function(x) {
    return x * square(x);
  }
};

race = function() {
  var runners, winner;
  winner = arguments[0], runners = 2 &lt;= arguments.length ? __slice.call(arguments, 1) : [];
  return print(winner, runners);
};

if (typeof elvis !== "undefined" &amp;&amp; elvis !== null) {
  alert("I knew it!");
}

cubes = (function() {
  var _i, _len, _results;
  _results = [];
  for (_i = 0, _len = list.length; _i &lt; _len; _i++) {
    num = list[_i];
    _results.push(math.cube(num));
  }
  return _results;
})();</pre></div>

<p><strong>Schön und gut, aber wie passt das in meine Visual Studio Welt?</strong></p>
<p>Hier gibt es eine gute und eine schlechte Nachricht. Die Gute: Es gibt ein Plugin. Die Schlechte: Für den vollen (oder nützlichen) funktionsumfang benötigt man eine Lizenz, welche 39$ kostet.</p>
<p><a href="http://www.mindscapehq.com/products/web-workbench"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image1547.png" width="598" height="219"></a></p>
<p>Die Rede ist von der <a href="http://www.mindscapehq.com/products/web-workbench">Web Workbench von Mindscape</a>.</p>
<p><strong>Wie ich auf das Tool kam…</strong></p>
<p>Ich hatte bislang immer Combres genutzt. Für KnowYourStack.com nutze ich Twitter Bootstrap als UI Baukasten. Nun wollte ich allerdings den Style des UIs etwas verändern, allerdings sieht man im generierten Twitter Bootstrap UI CSS Source nicht so recht durch und zudem kann man ohnehin viele Sachen leichter direkt in den .less Dateien fixen. Hiermit kam allerdings Combres nicht zurecht, da Twitter für jede einzelne Komponente eine eigene .less Datei erstellt hatte und diese in einer Master-Datei importierte. Alles in allem: Combres mochte nicht und ich musste eine Alternative suchen.</p>
<p><strong>Wie man mit der Web Workbench Twitter Bootstrap bearbeitet</strong></p>
<p>Auf dem <a href="http://www.mindscapehq.com/blog/index.php/2012/04/10/building-twitter-bootstrap-with-web-workbench/">Blog von Mindscape ist auch ein Post, der beschreibt, wie man Twitter Bootstrap damit bearbeiten kann</a> und ich kann es bezeugen: Es funktioniert wirklich. .LESS Datei bearbeiten –&gt; Speichern –&gt; neue .CSS Datei fällt heraus. Combres nutz nur noch die originale CSS Datei und alles ist gut.</p>
<p>Die kostenlose Variante von der Web Workbench hat bei mir (bis auf das Syntaxhighlighting), allerdings nix gemacht, daher war ich erst mal etwas enttäuscht. Die <a href="http://www.mindscapehq.com/products/web-workbench">Pro Version</a> lohnt sich aber, wenn man mit .LESS arbeitet :)</p>
<p>Auch <a href="http://www.hanselman.com/blog/CoffeeScriptSassAndLESSSupportForVisualStudioAndASPNETWithTheMindscapeWebWorkbench.aspx">Scott Hanselman hatte bei dem ersten Release darüber gebloggt</a>, da ich damit aber noch nichts direktes zutun hatte, kam ich jetzt erst wieder darauf.</p>
<p>Es gibt noch andere Tools, allerdings musste man dort meist ein eigenen Build-Mechanismus einbauen, was das ganze schnell komplizierter werden ließ.</p>
<p><strong>Eure Meinungen zu CoffeeScript, Sass oder LESS?</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1548.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb711.png" width="96" height="71"></a></p>
<p>Wer schon Erfahrungen mit den Sprachen gemacht hat, kann dies gerne auf KnowYourStack kund tun: <a href="http://www.knowyourstack.com/what-is/coffeescript">CoffeeScript</a>, <a href="http://www.knowyourstack.com/what-is/less">LESS</a> &amp; <a href="http://www.knowyourstack.com/what-is/sass">Sass</a>.</p>
<p>Feedback zur Seite oder zu dem Blogpost ist natürlich auch immer willkommen :)</p>
