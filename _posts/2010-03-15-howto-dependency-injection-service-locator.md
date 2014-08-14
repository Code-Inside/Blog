---
layout: post
title: "HowTo: Dependency Injection & Service Locator"
date: 2010-03-15 23:22
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [DI, HowTo, IoC]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image935.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="135" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb120.png" width="179" align="left" border="0"></a> Vor gut zwei Wochen hat Alexander Groß bei der <a href="http://dd-dotnet.de/?p=77">.NET Usergroup Dresden</a> das Thema Dependency Injection in den Raum geworfen und es auch sehr anschaulich an Beispielen verdeutlicht. Er zeigte den <a href="http://de.wikipedia.org/wiki/Inversion_of_Control"><strong>IoC</strong></a> Container <a href="http://www.castleproject.org/container/index.html">Castle Windsor</a> und warum ein <a href="http://martinfowler.com/articles/injection.html#ServiceLocatorVsDependencyInjection"><strong>ServiceLocator</strong></a> keine so gute Idee ist. Mit dem Blogpost versuche ich mal diese scheinbare Raketenwissenschaft etwas aufzuschlüsseln.</p><!--more--> <p><strong>Dependency Injection? Service Locator? WTF?</strong></p> <p>Wenn man über das Thema sich etwas beließt, dann kommt man früher oder später zu den <a href="http://www.objectmentor.com/resources/articles/dip.pdf">riesigen Erklärungen</a> von <a href="http://martinfowler.com/articles/injection.html#FormsOfDependencyInjection">Martin Fowler</a> (<a href="http://martinfowler.com/articles/injection.html#ServiceLocatorVsDependencyInjection">ServiceLocator vs. DI</a>). Das ist bestimmt toll beschrieben und ich hab das schon x-mal angefangen, aber bis zu dem .NET Usergroup-Treffen war es mir noch nicht ganz bewusst wie das praktisch denn nun aussieht. Darum versuch ich es mal ganz einfach.</p> <p><strong>Worum geht es hier eigentlich?</strong></p> <p>Jede Software hat irgendwelche "Abhängigkeiten". Sei es eine Datenbank, sei es das Filesystem auf dem zugegriffen wird oder sei es ein interner Dienst oder Service der genutzt wird. Damit man das komplizierte Gebilde später auch vielleicht irgendwie testen kann, empfiehlt es sich auf eine <a href="http://code-inside.de/blog/2008/08/12/howto-interfacesschnittstellen-einsetzen-gute-grnde-fr-den-einsatz-von-schnittstellen/"><strong>Schnittstelle</strong> zu programmieren</a>. <br><strong>Kleines Szenario:</strong> Wir haben ein Formular wo sich User anmelden können. Nach dem anmelden soll eine Mail verschickt werden. Die Daten validieren und verarbeiten macht der "<strong>UserService</strong>". Dieser benutzt zum Mails versenden etwas vom Typ "<strong>IMailService</strong>".<br><u>Jetzt kommt aber genau der interessante Punkt:</u> Woher soll unser <strong>UserService</strong> wissen, woher er eine Instanz vom Typ "<strong>IMailService</strong>" bekommen soll?</p> <p><strong>Variante 1: Service Locator</strong></p> <p><em>Achtung: Jetzt folgt Code, wo der eine oder andere mit dem Kopf schüttelt -&nbsp; der Code ist heute noch so im Einsatz ;)</em></p> <p>Die erste Idee wie man solche Abhängigkeiten "kontrollieren" kann wäre wenn man eine Art "Gott-Klasse"/"Setup" hat, in dem man die Komponenten registriert. Mit dieser "Gott-Klasse" könnten wir uns auf Befehl jeden Typen erstellen:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ebc4849a-587f-4057-a150-d292542e28c0" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class InstanceFactory : IInstanceFactory
    {
        public T GetInstanceOf&lt;T&gt;()
        {
            if (typeof(T) == typeof(IMailService))
            {
                return (T)(object)new EmailService();
            }
        }
    }</pre></div>
<p>An der Stelle könnte man natürlich auch auf eine XML Datei oder irgendwas anderes zugreifen.</p>
<p>Angewendet würde diese Klasse im UserService dann so:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:3dace5a2-7cb2-41dc-a93b-01138f69fccb" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">IInstanceFactory factory = new InstanceFactory();
IMailService srv = factory.GetInstanceOf&lt;IMailService&gt;();</pre></div>
<p>Diese "Gott-Klasse" könnte natürlich auch eine statische Klasse sein, aber um den UserService testbar zu halten, können wir über den Konstruktor im UnitTest ein andere InstanceFactory reingeben:</p>
<p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5bb4aed8-fe60-4202-b5f8-31cd17c72a71" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c">        public UserService()
            : this(new InstanceFactory())
        {
        }

         public UserService(IInstanceFactory factory)
        {
            this._factory = factory;
        }</pre></div></p>
<p>Im Normalfall wird also unsere Implementation von oben genommen und ansonsten könnten wir auch eine TestInstanceFactory reingeben. Geht soweit auch, ist aber eigentlich nicht so gut wie ich feststellen musste.</p>
<p><strong>Wo liegt beim Service Locator das Problem?</strong></p>
<p>Bei dieser Variante weiß man nicht genau, welche Abhängigkeiten eine Klasse hat. Wenn man die Abhängigkeiten im Konstruktor sieht, dann weiß man, dass z.B. der UserService eine Instanz vom Typ IMailService benötigt. Durch diese "Gott-Klasse" kann man plötzlich kreuz und quer irgendwelche Services aufrufen. Das macht das debugging und testen schwieriger.</p>
<p><strong>Die bessere Methode: Inversion of Control Container</strong></p>
<p><em>Hier gilt (wie immer) : Solides Halbwissen ist vorhanden - wenn ich hier Quatsch erzähle, dann berichtigt mich ruhig.</em></p>
<p>Um nicht zu weit auszuschweifen: Um die Abhängigkeiten auf den ersten Blick zu erkennen, ist es meiner Meinung nach gut, wenn diese über den Konstruktor definiert werden. Eine andere Art wäre dies über Properties zu machen. Das ist aber IMHO nicht so einleuchtend wie im Konstruktor.</p>
<p>Rund um das <strong>Inversion of Control</strong> Thema gibt es bereits eine Vielzahl von Frameworks, die einem dabei helfen:</p>
<ul>
<li><a href="http://msdn.microsoft.com/en-us/library/cc468366.aspx">Unity</a></li>
<li><a href="http://lightcore.peterbucher.ch/">LightCore</a> von <a href="http://lightcore.peterbucher.ch/autor.aspx">Peter Bucher</a></li>
<li><a href="http://structuremap.github.com/structuremap/index.html">StructureMap</a></li>
<li><a href="http://www.castleproject.org/container/index.html">Castle Windsor</a></li></ul>
<p>Auf den ersten Blick ähneln sich die Konzepte vom Service Locator und diesen Frameworks. Bei Den IoC Container legt man immer eine Art "Konfiguration" nach dem Schema: "Wenn du nach Instanz von Typ X gefragt wirst, dann gibt ihm eine Instanz vom Typ X." an. Allerdings sind die benannten Frameworks hier weitaus cleverer als mein Code von oben. </p>
<p><strong>Wir spinnen das Szenario von oben weiter:</strong> Der UserService hat auch ein Interface IUserService und wird im UserController verwendet. Hier mal ein Beispiel mit Castle.Windsor:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:640550dc-f527-4829-9a24-669d6f976716" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">   WindsorContainer container = new WindsorContainer(new XmlInterpreter());
   IUserService srv = container.Resolve&lt;IUserService&gt;();</pre></div>
<p>Die "Resolve" Methode ist im Prinzip ähnlich wie das "GetInstanceOf" Methode. Allerdings hat unser UserService wiederrum eine Abhängigkeit auf den EmailService. Das wird allerdings alles vom Framework geregelt und alle Abhängigkeiten werden sauber aufgelöst.</p>
<p>Der Vorteil an der Methode ist, dass man im Unittest einfach so die Klassen benutzen kann und sofort die Abhängigkeiten durch den Konstruktor sieht. Das macht die Sache wesentlich durchschaubarer.</p>
<p>Ich erspare mir hier mal ein konkretes Beispiel, da es im Netz sehr viele gute HowTos zu den einzelnen Frameworks gibt.</p>
<ul>
<li>Für <a href="http://wiki.bittercoder.com/Default.aspx?Page=ContainerTutorials&amp;AspxAutoDetectCookieSupport=1">Castle.Windsor</a></li>
<li><a href="http://www.aspnetzone.de/blogs/robertobez/archive/2010/01/16/inversion-of-control-di-ioc-container-lightcore.aspx">Roberto Bez über LightCore</a></li></ul>
<p>Diese Frameworks können natürlich noch wesentlich mehr als pure Instanzen zurückgegeben, aber das würde jetzt zu weit führen. Ich hoffe ich konnte erstmal ein wenig Licht ins Dunkel bringen. Falls ich in diesem Post irgendwelche Sachen aber komplett falsch verstanden habe oder einfach Begrifflichkeiten verwechselt habe, dann korrigiert mich bitte :)</p>
