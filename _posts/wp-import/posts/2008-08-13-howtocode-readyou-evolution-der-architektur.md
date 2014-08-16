---
layout: post
title: "HowToCode &quot;ReadYou&quot;: Evolution der Architektur"
date: 2008-08-13 22:05
author: robert.muehsig
comments: true
categories: [HowToCode]
tags: ["ReadYou", Architektur, Interfaces, UnitTests]
---
{% include JB/setup %}
<p>Mein kleines Projekt "<a href="http://code-inside.de/blog/category/howtocode/">ReadYou</a>" kommt in winzigen Schritten vorwärts - allerdings mehr auch nicht. Grund hierfür ist meist, dass wenn man sich in ein Thema mal versucht einzulesen, man sofort auf zwei neue interessante Sachen stößt. So z.B. die <a href="http://code-inside.de/blog/2008/08/05/howto-unittests-und-einfhrung-in-mocking-mit-rhinomocks/">Mockinggeschichte</a> um meine UnitTests besser zu gestalten.</p> <p><strong>Architekturumgestaltung</strong></p> <p>Meine Grundsätzliche Architektur war so aufgebaut wie in <a href="http://code-inside.de/blog/2008/07/09/howto-3-tier-3-schichten-architektur/">diesem Blogpost</a> beschrieben.</p> <p>Durch das gute Feedback zu dem 3-Schichten Architektur Blogpost habe ich es nun grob so eingeteilt:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image522.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="287" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb500.png" width="312" border="0"></a> </p> <p>Mein <strong>Model</strong> liegt nun nicht mehr im Data rum, sondern ist theoretisch auf allen Schichten erreichbar und daher in einer eigenen DLL zu finden. Das Model besteht aus einfachen <a href="http://en.wikipedia.org/wiki/POCO">POCOs</a> - die nichts anderes machen außer Daten halten. </p> <p>Da ich möglichst flexibel bin und auch <a href="http://code-inside.de/blog/2008/08/12/howto-interfacesschnittstellen-einsetzen-gute-grnde-fr-den-einsatz-von-schnittstellen/">alles fein säuberlich testen kann</a>, ist <strong>jede Schicht aufgeteilt</strong> in:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image523.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="115" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb501.png" width="346" border="0"></a> </p> <p>Bei Data ist natürlich genau dasselbe vorzufinden: Die Trennung zwischen den Interfaces und der eigentlichen Implementierung die ich vorgenommen habe.</p> <p><strong>Response &amp; Request bei den Services</strong></p> <p>Als ich mein Interface für den BookService vorbereitet habe, habe ich überlegt, was ich alles für "Aufrufe" brauche:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d4f6a7c6-1ee7-4324-bd3b-97844f4ac785" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public interface IBookService
    {
        IList&lt;Book&gt; GetBooks();
        IList&lt;Book&gt; GetBooksByAuthor(Author author);
        IList&lt;Book&gt; GetBooksByUser(User user);
        IList&lt;Book&gt; GetBooksByTag(Tag tag);
        IList&lt;Book&gt; GetBooksByCategory(Category cat);
       ....

    }</pre></div>
<p>Allerdings ist das nicht wirklich schön - mein Service hätte äußerst viele Methoden um Bücher ranzuholen. Einmal anhand des Autors, einmal nach Kategorie etc.<br>Komplexer wären noch Sachen wie: "GetBooksByCategoryAndUser" - heiei... für jeden Fall eine Methode zu schreiben, erscheint mir nicht sinnvoll.</p>
<p><strong>Meine Lösung: Request &amp; Response</strong></p>
<p>Wie ein "WebService" geben meine Services auch Responses zurück und verlangen ein Request Objekt:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image524.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="225" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb502.png" width="318" border="0"></a> </p>
<p>Diese Objekte habe ich in ReadYou.Service.Model hinterlegt - da sie nur im Service vorkommen, ich allerdings diese Definitionen und die Logik in seperaten DLLs trennen wollte:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image525.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="166" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb503.png" width="217" border="0"></a> </p>
<p>Dabei leitet der "GetBooksRequest" von "BaseRequest" ab und beim Response genauso.</p>
<p>Durch dieses Objekt kann ich später genau mein "GetBooksRequest" definieren:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:8c79badd-ddd3-4940-bc85-2dffd47507d0" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class GetBooksRequest : BaseRequest
    {
        public Tag Tag { get; set; }
        public Category Category { get; set; }
        public User User { get; set; }
        public Author Author { get; set; }
    }</pre></div>
<p> Jetzt könnte ich mir sowas wie "Gib mir alle Bücher vom Autor XYZ, des Users ABC mit der Kategory "Krimi"" - das erlaubt mir einige Freiheiten und sollte erweiterbar sein, falls mir wieder was neues einfällt. </p>
<p><strong>Wie sieht das im Projekt aus?</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image526.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="264" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb504.png" width="250" border="0"></a> </p>
<p>Alles ist aufgeteilt - dabei fehlen allerdings noch UnitTests für den "Data" Teil und für die WebApp (die hier noch nicht zu sehen ist). Unter "Common" befinden sich nur ein paar Extensions die mir das leben erleichtern :)</p>
<p>Mit dieser Ordnung bin ich gerade recht zufrieden - alles ist soweit getrennt und alles was Logik hat, hat auch ein Interface. Späße wie <a href="http://de.wikipedia.org/wiki/Dependency_Injection">Dependency Injection</a> und co. steht auch nichts im Wege. <br>Durch die Response / Request Sache bin ich später recht flexibel - auch wenn es etwas mehr Schreibaufwand ist.</p>
<p><strong>Das wichtigste ist allerdings:</strong></p>
<p>Wie seht ihr das? Ist die Idee mit den Response/Request Objekten vielleicht doch nicht so toll? Gebt einfach euer Feedback ab - den Code (sobald ich noch etwas weiter bin), werde ich auf Codeplex zur Verfügung stellen. Momentan ist diese Version noch nicht hochgeladen.</p>
