---
layout: post
title: "HowTo: UnitTests und Einführung in Mocking mit Rhino.Mocks"
date: 2008-08-05 22:23
author: robert.muehsig
comments: true
categories: [HowTo]
tags: []
---
{% include JB/setup %}
<p>In dem letzten <a href="{{BASE_PATH}}/2008/05/22/howto-einfache-tests-unittests-oder-keine-angst-vor-unittests/">UnitTest HowTo</a> haben wir den ersten Schritt in Richtung "bessere Software" getan. </p> <p><strong>Was bei Unit Tests beachtet werden sollte:</strong> <u>Ein Unit Test soll genau eine Sache testen</u> - abgeschottet von allen anderen Sachen. <br><a href="http://haacked.com/">Phil Haack</a> hat einen sehr guten <a href="http://haacked.com/archive/2008/07/22/unit-test-boundaries.aspx">Blogpost</a> darüber geschrieben (<a href="http://haacked.com/archive/2008/08/04/what-integrated-circuits-say-about-testing-your-code.aspx">und noch einen anderen ;)</a> ) - der auch mich etwas "wachgerüttelt" hat. </p> <p><a href="{{BASE_PATH}}/assets/wp-images/image495.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="184" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb473.png" width="244" border="0"></a></p> <p><strong>Was bedeutet das:</strong><br>Wenn wir angenommen eine <a href="{{BASE_PATH}}/2008/07/09/howto-3-tier-3-schichten-architektur/">3-Schichten Architektur</a> haben und unseren Service Layer testen möchten, sollten wir tunlichst vermeiden über den Data Access Layer zu gehen und so direkt zur DB zu reden. Die DB kann sich verändern!</p> <p><strong>Warum?</strong><br>Wenn man direkt mit der DB redet, muss man sich auf bestimmte Daten verlassen - d.h. statische Daten laden in den Tests. Falls die Daten in der DB mal verloren gehen, gehen leider die UnitTests nicht mehr (selber in einem Projekt soeben bemerkt ;) ).</p> <p><strong>Ich mach eine Testdatenbank!<br></strong>Man kann natürlich eine direkte Testdatenbank habe - allerdings ist es dann trotzdem recht schwierig eine "valides" Umfeld bei jedem einzelnen Test zu haben. Oder man resettet nach jedem Test die TestDB - allerdings laufen dann die Unit-Tests sehr zäh ab und es ist auch recht schwierig zu managen.</p> <p><strong>Mein Idealbild:<br></strong>Bei jedem Unit Test möchte ich meine Umgebung exakt auf den Testfall konstruieren - sodass ich genau das Verhalten testen und daraufhin implementieren kann.</p> <p><strong>Das Zauberwort: Mocking<br></strong>Durch den Einsatz von Schnittstellen usw. kann man natürlich überall Fake / Dummy Klassen erstellen - wie z.B. ich es <a href="{{BASE_PATH}}/2008/08/05/howto-fluent-interfaces-schne-apis-mit-c-30/">hier</a> getan hab mit den statischen Daten. Darunter kann man schonmal grob <a href="http://en.wikipedia.org/wiki/Mock_object">Mocking</a> verstehen.</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image496.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="184" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb474.png" width="244" border="0"></a> </p> <p>Allerdings ist es ziemlich umständlich für alles und jeden Test die Umgebung entsprechend durch solche Fake-Implementationen komplett zu mimen. Zudem fehlt etwas die Verbindung zwischen der Mockklasse und dem tatsächlichen Einsatzort.</p> <p><u>Die Magie der Frameworks</u><br>Wie für fast jedes Problem, gibt es auch hier kleine Helferlein, welche durch Magie (es ähnelt Magie ;) ) dir den kompletten Implementationsaufwand der einzelnen konkreten Klassen abnehmen. <br>Es gibt in der .NET Welt einige Mocking Frameworks: <a href="http://code.google.com/p/moq/">Moq</a>, <a href="http://www.ayende.com/projects/rhino-mocks.aspx">Rhino.Mocks</a>, <a href="http://www.typemock.com/">TypeMock</a> usw. <br>Ich bezieh mich nun auf Rhino.Mocks.</p> <p><strong>In die Praxis:<br></strong>Wir haben wieder den ähnlichen Aufbau wie die <a href="{{BASE_PATH}}/2008/08/05/howto-fluent-interfaces-schne-apis-mit-c-30/">letzten Male</a>:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image497.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="317" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb475.png" width="216" border="0"></a>&nbsp; </p> <p>Wer genauer hinschaut, sieht, dass es keine konkrete Implementation von IPersonRepository zu sehen ist - keine DummyRepository, auch nicht im Test.</p> <p><strong>Der Aufbau:</strong><br>In unserem "PersonFilter" haben wir diesmal nur den "WithAge" Filter. Unser "IPersonRepository" hat eine "GetPersons" Methode.</p> <p>Den PersonService haben wir nun so implementiert:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b02f8c85-bd1d-4ea2-8cb1-1111097b4a96" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">
namespace RhinoMocks.Services
{
    public class PersonService
    {
        private IPersonRepository PersonRep { get; set; }

        public PersonService(IPersonRepository rep)
        {
            this.PersonRep = rep;
        }

        public IList&lt;Person&gt; GetPersonsByAge(int age)
        {
            return this.PersonRep.GetPersons().WithAge(age).ToList();
        }
    }
}
</pre></div>
<p>Im Konstruktur übergeben wir unser PersonRepository und in der GetPersonsByAge Methode fragen wir quasi über unseren Filter das entsprechende Repository ab.</p>
<p>Ich benutze die <a href="http://www.ayende.com/projects/rhino-mocks/downloads.aspx">Rhino.Mocks Version 3.5</a> - welche die aktuellste ist. Diese einfach referenzieren.</p>
<p>Im Test möchten wir nun genau diese eine Methode testen:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:4165c505-62a5-4b66-8c71-c892b592b219" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">
        [TestMethod]
        public void PersonService_GetPersonByAge_Works()
        {
            MockRepository mock = new MockRepository();
            IPersonRepository rep = mock.StrictMock&lt;IPersonRepository&gt;();

            using (mock.Record())
            {
                List&lt;Person&gt; returnValues = new List&lt;Person&gt;()
                {
                    new Person() { Age = 11, Name = "Bob" },
                    new Person() { Age = 22, Name = "Alice" },
                    new Person() { Age = 20, Name = "Robert" },
                    new Person() { Age = 40, Name = "Hans" },
                    new Person() { Age = 20, Name = "Peter" },
                    new Person() { Age = 20, Name = "Oli" },
                };
                Expect.Call(rep.GetPersons()).Return(returnValues.AsQueryable());
            }
            using (mock.Playback())
            {
                PersonService service = new PersonService(rep);
                List&lt;Person&gt; serviceResults = service.GetPersonsByAge(20).ToList();

                Assert.AreNotEqual(0, serviceResults.Count);

                foreach (Person result in serviceResults)
                {
                    Assert.AreEqual(20, result.Age);
                }
            }
        }</pre></div>
<p>Achtung: Wie es genau funktioniert wieß ich auch noch nicht - allerdings tut es ;)</p>
<p>Schauen wir es uns mal genauer an:<br>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:108af5a4-2c4c-40a8-829f-0f48c2deb8b9" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">            MockRepository mock = new MockRepository();
            IPersonRepository rep = mock.StrictMock&lt;IPersonRepository&gt;();</pre></div></p>
<p>Dieser Codeschnipsel erstellt uns dynamisch ein Objekt vom Typ "IPersonRepository".</p>
<p>Jetzt kommt der "Record" Mode:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:3863b410-b762-4eb3-96c3-c207cddc6de1" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">using (mock.Record())
            {
                List&lt;Person&gt; returnValues = new List&lt;Person&gt;()
                {
                    new Person() { Age = 11, Name = "Bob" },
                    new Person() { Age = 22, Name = "Alice" },
                    new Person() { Age = 20, Name = "Robert" },
                    new Person() { Age = 40, Name = "Hans" },
                    new Person() { Age = 20, Name = "Peter" },
                    new Person() { Age = 20, Name = "Oli" },
                };
                Expect.Call(rep.GetPersons()).Return(returnValues.AsQueryable());
            }</pre></div>
<p>Alles was innerhalb von diesem Using ist, wird "aufgezeichnet". Als erstes erstelle ich mir meine PersonCollection (mein Umfeld in dem in den Test laufen lassen möchte).<br>In "Expect.Call" geb ich die Methode an, die aufgerufen wird und was dabei als Returnvalue zurückgegeben wird (in meinem Fall meine PersonCollection).</p>
<p>Im letzten "Playback" Abschnitt:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:3d0d7d38-4ac5-41a4-b2e1-8d829e73cfb4" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">using (mock.Playback())
            {
                PersonService service = new PersonService(rep);
                List&lt;Person&gt; serviceResults = service.GetPersonsByAge(20).ToList();

                Assert.AreNotEqual(0, serviceResults.Count);

                foreach (Person result in serviceResults)
                {
                    Assert.AreEqual(20, result.Age);
                }
            }</pre></div>
<p>Hier wird das, was wir vorher definiert haben bei den entsprechenden Calls "abgespielt". <br>Wie die Magie direkt funktioniert, weiß ich nicht, allerdings wird dynamisch zur Laufzeit dieser Typ generiert:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image498.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="204" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb476.png" width="514" border="0"></a> </p>
<p>Ergebnis:<br>Der Test läuft durch und ich hab durch diesen Mock genau nur eine Sache getestet - ob der Service läuft oder nicht. Ob die DB verrückt spielt ist mir an dieser Stelle egal :)</p>
<p><strong>Andere Beispiele:</strong></p>
<p>Ich hab am Anfang ein einfaches "<a href="http://www.buddylindsey.com/Blog/post/Hello-World-of-Rhino-Mocks.aspx">Hello World</a>" Beispiel gefunden. Einige Screencasts findet man <a href="http://www.dimecasts.net/Casts/ByTag/Rhino%20Mocks">hier</a> und ein kleines <a href="http://en.wikibooks.org/wiki/How_to_Use_Rhino_Mocks">Wiki</a> hat auch noch ein paar Artikel darüber.</p>
<p>Wenn mein Beispiel komplett falsch ist (oder ich eine falsche Erklärung hab), dann einfach melden - ich arbeite mich erst in diese Materie ein :)</p>
<p><a href="{{BASE_PATH}}/assets/files/democode/rhinomocks/rhinomocks.zip"><strong>[ Download Democode ]</strong></a></p>
