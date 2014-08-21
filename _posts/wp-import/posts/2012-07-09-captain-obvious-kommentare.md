---
layout: post
title: "Captain Obvious Kommentare"
date: 2012-07-09 22:57
author: robert.muehsig
comments: true
categories: [HowToCode]
tags: [Code Quality, Kommentare]
---
{% include JB/setup %}
<p>Den Code zu schreiben war schwer, daher machen wir fleissig Kommentare. Zudem sind Kommentare immer ein Zeichen von Qualitätssoftware, richtig?</p> <p><strong>Nein.</strong></p> <p>Code sinnvoll zu kommentieren ist eine kleine Kunst für sich – allerdings stur alles zu kommentieren führt zu solchen Kommentaren:</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:2f9faa4c-c1d6-4842-804d-c66c906ab524" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    /// &lt;summary&gt;
    /// Home Controller
    /// &lt;/summary&gt;
    public class HomeController : Controller
    {
        /// &lt;summary&gt;
        /// Index Method
        /// &lt;/summary&gt;
        /// &lt;returns&gt;&lt;/returns&gt;
        public ActionResult Index()
        {
            ViewBag.Message = "Welcome to ASP.NET MVC!";

            return View();
        }

        /// &lt;summary&gt;
        /// Guess what?
        /// &lt;/summary&gt;
        /// &lt;returns&gt;&lt;/returns&gt;
        public ActionResult About()
        {
            return View();
        }
    }</pre></div>
<p>&nbsp;</p>
<p>Der Mehrwert solcher Kommentare ist gleich 0 – ausser vielleicht das man eine bestimmte “Quality Code Metric” ausgetrickst hat oder eine Regel befolgt hat. <a href="{{BASE_PATH}}/2010/11/18/howto-stylecop-settings-auf-mehrere-projekte-anwenden/">StyleCop</a> &amp; co. machen es ziemlich einfach ein regides Regelwerk zu erstellen.</p>
<p><strong>Regeln und “weniger ist mehr”</strong></p>
<p>Eine “wir kommentieren alles”-Regel ist aus meiner Sicht völlig unnütze und verleitet sogar dazu “falsche” Kommentare zu erstellen. Kommentare sollen den Code erklären – warum gibts dies und jenes. Das das die “HomeController” Klasse ist sehe ich selber und wie ein Konstruktor aussieht erkenne ich auch noch. Aber warum wird diese oder jene Prüfung vorgenommen? Was versteckt sich fachlich hinter dem Code?<br>Wer Code Kommentare inflationär einsetzt verringert auch das Empfinden der Projektmitglieder sich um die Kommentare zu kümmern. Resharper kann clevere Refactorings durchführen – aber die Kommentare müssen von Hand nachgezogen werden und wenn das keiner macht, “weil es so viele Kommentare gibt”, dann sind sie nur noch eine Belastung.</p>
<p><strong>Meine Empfehlung beim Kommentieren:</strong></p>
<p>- Warum wurde der Code so entwickelt? Das “wie” sieht man im Code.</p>
<p>- Regeln verleiten zu unnötigen Kommentaren, welche Zeit während der Entwicklung brauchen und besonders in bei der Pflege des Codes. </p>
<p>- Innerhalb des Teams sollte man sich auf eine Sprache einigen. Deutsch / Englisch Gemischt hat einen unschönen Beigeschmack.</p>
<p>- Immer im Hinterkopf behalten: Wird der Code durch den Kommentar <strong><u>bereichert</u></strong>? Wenn nicht, dann gibts keinen Kommentar. Auch gut<strong>(! – Kommentare sind kein MUSS!)</strong></p>
<p><strong>Wenn Kommentare zu lang werden…</strong></p>
<p>In diesem Fall sollte man sich überlegen ob der Code am Ende nicht einfach zu kompliziert ist. Dutzende Zeilen der Erklärung können auch zeigen, dass eine Methode zu viele Aufgaben hat.</p>
<p><strong>Weitere Meinungen zum Thema</strong></p>
<p><a href="http://ayende.com/blog/1948/on-code-comments">Ayende Rahien</a> und Jeff Attwood haben ebenfalls über diese (doch schon recht alte Thema) <a href="http://www.codinghorror.com/blog/2008/07/coding-without-comments.html">gebloggt</a>. </p>
<p><strong>Eure Meinung würde mich interessieren</strong></p>
<p>Wie steht ihr dazu? Lieber alles kommentieren? Bin ich nur zu faul zum Schreiben? Welche Stilblüten habt ihr schon gesehen? Gibt es bei euch eine Code Kommentar Regel?&nbsp;&nbsp; </p>
