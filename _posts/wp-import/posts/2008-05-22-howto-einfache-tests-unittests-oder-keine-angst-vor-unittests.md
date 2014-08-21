---
layout: post
title: "HowTo: Einfache Tests - UnitTests (oder keine Angst vor UnitTests...)"
date: 2008-05-22 22:33
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [MS Test, TDD, Test, Unit Tests, Visual Studio 2008]
---
{% include JB/setup %}
<p><strong>Einführung</strong></p> <p>Das Konzept der <a href="http://de.wikipedia.org/wiki/Modultest">UnitTests</a> (es gibt noch ein paar weitere Formen) ist bereits seit etlichen Jahren (oder Jahrzehnten?) bekannt. Es gibt viele Testframeworks für fast jede Sprache. <br>Im Visual Studio 2008 (jedenfalls der Professional/Team System Edition) sind UnitTests sehr einfach zu erstellen - und trotzdem hab ich erst vor kurzem die UnitTests für mich entdeckt. Trotz der Gründe für UnitTests und der Einfachheit kenn ich etliche Projekte, wo diese nicht existieren oder angewendet werden.<br>Die meisten Entwickler denken, dass UnitTests ziemlich komplex sind und eigentlich unnötig.<br>Die Gründe der Entwickler sind vielfältig (auch ich hab früher so oder so ähnlich gedacht ;) ) : </p> <ul> <li>"Warum nicht einfach ein Konsolenprogramm erstellen oder per Debugger prüfen?"  <li>"Ich seh es doch wenn eine bestimmte Komponente nicht funktioniert."  <li>"Für den extra Aufwand hab ich leider keine Zeit."  <li>"UnitTests klingt doch recht kompliziert, da ist mir die Einarbeitungszeit zu hoch."  <li>...</li></ul> <p>Ich bin kein Experte in UnitTests, allerdings haben sie mich bereits nach wenigen Minuten begeistert :)</p> <p><strong>UnitTests sind sehr schnell gemacht</strong></p> <p>(<em><strong>Achtung</strong></em>: Diese Aussage nicht auf die Goldwaage legen. Gute und durchdachte UnitTests sind keine leichte Aufgabe - darum gibt es ja z.B. auch eine extra Test Edition von Visual Studio wo sich)<br>Aber für den Anfang wollen wir die Behauptung mal so stehen lassen - Einfache Tests können sehr schnell durchgeführt werden)</p> <p>Im Visual Studio 2008 wurde ein extra Template für Tests bereitgestellt:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image406.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="208" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb385.png" width="269" border="0"></a> </p> <p>Zudem kann man direkt in einem Projekt per Kontextmenü auf eine Klasse/Methode ein UnitTest erstellen:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image407.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="95" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb386.png" width="244" border="0"></a> </p> <p>Aber erst mal zur Grundfrage:</p> <p><strong>Warum sollte ich Tests machen?</strong></p> <p>Jeder Entwickler will (hoffentlich) gute und funktionstüchtige Software schreiben, die möglichst fehlerfrei ihren Dienst tut. <br>In der Zeit wo die Software entwickelt wird, werden sicherlich an vielen Ecken (oder Software-Schichten) Änderungen eingepflegt oder die Applikation muss erweitert werden. Insbesondere in einem Team oder wenn eine größere Umstellung ansteht (Datenbasis wechselt, Logik muss abgeändert werden) wird es kritisch: <u>Laufen alle Komponenten noch wie erhofft?</u> <br>Je größer die Anwendung, desto größer wird der Aufwand der Betrieben muss, um sicherzustellen, dass alles noch läuft. <br>Ein Test im UserInterface ist zwar machbar, ist allerdings meist sehr anstrengend und zeit intensiv (sollte natürlich auch gemacht werden).<br>Es wäre doch viel schöner, wenn die Tests automatisch erfolgen könnten - ohne viel Zeit mit Klicken zu verlieren - auch das die Tests jederzeit ausgeführt werden können wäre doch nett, oder?<br><u>Hier kommen die UnitTests:</u> Genau sowas machen UnitTests (und noch mehr ;) ). </p> <p><strong>Stellen wir uns mal vor...</strong></p> <p>... dass wir eine nicht ganz triviale Software haben, welche verschiedene Layer (Data/Business etc.) hat. Die Software funktioniert gut - der Kunde ist zufrieden und als Entwickler fühlt man sich wohl.<br>Wie es meistens ist: Der Kunde möchte eine Änderung. Ein neues Attribut soll hier und da angefügt werden, eine Abfragelogik verändert werden und die Validation der Daten soll anders verlaufen.<br><u>Das Problem:</u> Die Änderungen können viele Bereiche betreffen, sodass es leicht passieren kann, dass plötzlich garnichts mehr geht. Aber wo genau hakt es denn? Erstmal überall den Debugger ansetzen und nachverfolgen... hoffentlich übersicht man kein Fehler.<br><u>Ergebnis:</u> An dieser Stelle ist es meist für den Entwickler ein etwas mulmiges Gefühl - wird die Software noch genauso funktionieren wie vorher (natürlich mit den Änderungen)? </p> <p><strong>... nun mal mit Tests vorstellen (ein Gedankenspiel) :</strong></p> <p>Die verschiedenen Methoden wurden während der Entwicklung der Version 1 bereits mit UnitTests getestet. Daten eintragen, löschen, verändern, laden, validieren, Fehler abfangen usw. - alle Aspekte die wichtig sind, wurden als Test hinterlegt.<br><u>Nun kommen die Änderungen:</u> Es werden einige kritische Bereiche verändert, aber nach jeder Veränderung kann man automatisch alle Tests abspielen - schlägt der Test fehl, weiß man, wo Handlungsbedarf besteht. Die eben gemachte Änderung war wohl anscheinend nicht so gut. <br><u>Nach einer ganzen Weile:</u> Die Tests werden wieder bestanden - das Herz des Entwicklers schlägt höher. Es können zwar immer noch Fehler auftreten (vielleicht muss ein neuer Test für einen neuen Aspekt noch hinzugefügt werden), aber die Grundzüge der Applikation stimmen noch.</p> <p><strong>Klingt doch eigentlich gut, aber wie sieht das in der Praxis aus:</strong></p> <p>Ein sehr (zugegeben) doofes Beispiel:</p> <p></p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ae522095-f015-45c0-8ab7-eea7cb4e4d85" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class DataManager
    {
        public bool ConnectToData()
        {
            return true;
        }

        public List&lt;int&gt; GetData()
        {
            return new List&lt;int&gt;() { 1, 2, 3, 4, 5, 6, 7 };
        }
    }</pre></div>
<p></p>
<p>Unser DataManager kann sich zu einer beliebigen Datenquelle verbinden - in unserem Fall sagen wir einfach mal, dass die Verbindung geklappt hat.<br>Die GetData Methode gibt Daten zurück - in unserem Beispiel ein paar statische Daten.</p>
<p>Da sich die Datenabfrage-Logik ja ändern könnte und da auch die Datenquelle vielleicht sich noch ändert, implementieren wir lieber einen Test dafür:</p>
<p>Create Unit Test...</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image408.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="78" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb387.png" width="244" border="0"></a>&nbsp;<br>Methoden auswählen, welche man testen möchte (beide in unserem Fall)...</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image409.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="225" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb388.png" width="361" border="0"></a>&nbsp;<br>Name eingeben...</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image410.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="81" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb389.png" width="244" border="0"></a>&nbsp;</p>
<p>Ein TestProjekt ist entstanden:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image411.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="152" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb390.png" width="244" border="0"></a> </p>
<p><strong>Generierter Test (dort steht eigentlich bereits das wichtigste drin) :</strong></p>
<p>Visual Studio nutzt MSTest - das Test-Framework von Microsoft. Es ist ähnlich zu <a href="http://www.nunit.org/index.php">nUnit</a> und co.</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ab5daeab-dcdb-489f-99b8-dfe5b04dc17a" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">using DoNot.Fear.UnitTests.Data;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections.Generic;

namespace DoNot.Fear.UnitTests.Test
{
    
    
    /// &lt;summary&gt;
    ///This is a test class for DataManagerTest and is intended
    ///to contain all DataManagerTest Unit Tests
    ///&lt;/summary&gt;
    [TestClass()]
    public class DataManagerTest
    {


        private TestContext testContextInstance;

        /// &lt;summary&gt;
        ///Gets or sets the test context which provides
        ///information about and functionality for the current test run.
        ///&lt;/summary&gt;
        public TestContext TestContext
        {
            get
            {
                return testContextInstance;
            }
            set
            {
                testContextInstance = value;
            }
        }

        #region Additional test attributes
        // 
        //You can use the following additional attributes as you write your tests:
        //
        //Use ClassInitialize to run code before running the first test in the class
        //[ClassInitialize()]
        //public static void MyClassInitialize(TestContext testContext)
        //{
        //}
        //
        //Use ClassCleanup to run code after all tests in a class have run
        //[ClassCleanup()]
        //public static void MyClassCleanup()
        //{
        //}
        //
        //Use TestInitialize to run code before running each test
        //[TestInitialize()]
        //public void MyTestInitialize()
        //{
        //}
        //
        //Use TestCleanup to run code after each test has run
        //[TestCleanup()]
        //public void MyTestCleanup()
        //{
        //}
        //
        #endregion


        /// &lt;summary&gt;
        ///A test for GetData
        ///&lt;/summary&gt;
        [TestMethod()]
        public void GetDataTest()
        {
            DataManager target = new DataManager(); // TODO: Initialize to an appropriate value
            List&lt;int&gt; expected = null; // TODO: Initialize to an appropriate value
            List&lt;int&gt; actual;
            actual = target.GetData();
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// &lt;summary&gt;
        ///A test for ConnectToData
        ///&lt;/summary&gt;
        [TestMethod()]
        public void ConnectToDataTest()
        {
            DataManager target = new DataManager(); // TODO: Initialize to an appropriate value
            bool expected = false; // TODO: Initialize to an appropriate value
            bool actual;
            actual = target.ConnectToData();
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }
    }
}
</pre></div>
<p>Die Kommentare und auch den TestContext kann man löschen - ich hab ihn bisher nicht gebraucht ;)<br><strong><em>Achtung:</em></strong> Ich bin kein Experte in den Unit Tests - sondern ist nur eine Art Erfahrungsbericht :)</p>
<p>Machen wir doch erstmal einen einfachen Test ob die Verbindung klappt:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:7cb0d21c-3af0-4595-9763-bb64b4a1cc3d" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        [TestMethod()]
        public void DataManager_ConnectToData_IsTrue()
        {
            DataManager man = new DataManager();
            Assert.IsTrue(man.ConnectToData());
        }</pre></div>
<p>Sehr schlicht, aber genau das was ich wissen muss. Der Name des Tests sollte ungefähr das beschreiben was er macht - damit man sich später noch zurechtfindet. In diesem Fall prüfe ich einfach, ob die Verbindung zustande kommt.<br>Die Assert-Klasse hat mehrere Methoden:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image412.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="196" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb391.png" width="244" border="0"></a> </p>
<p>Jetzt können wir diesen Test durchlaufen und sehen:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image413.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="114" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb392.png" width="341" border="0"></a> </p>
<p>Jetzt prüfen wir noch die andere Methode:</p>
<p></p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:6bcbc3e2-ea45-43b0-9c99-53684c4701d5" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        [TestMethod()]
        public void DataManager_GetData_IsNotNull()
        {
            DataManager man = new DataManager();
            Assert.IsNotNull(man.GetData());
        }

        [TestMethod()]
        public void DataManager_GetData_CheckForZero()
        {
            DataManager man = new DataManager();
            List&lt;int&gt; result = man.GetData();
            foreach (int number in result)
            {
                Assert.AreNotEqual(0, number);
            }
        }</pre></div>
<p></p>
<p>Die erste Methode prüft, ob überhaupt Werte zurückkommen. Mit dem zweiten Test wollte ich nur mal eine primitive Business-Logik Test machen ("kein Element darf 0 sein").</p>
<p>Jetzt kann man alle Abspielen:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image414.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="78" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb393.png" width="244" border="0"></a> </p>
<p>Ergebnis:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image415.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="115" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb394.png" width="322" border="0"></a> </p>
<p>Schön, oder? :)</p>
<p><strong>Ein Gedankenspiel: </strong></p>
<p>Angenommen in unseren Daten schleicht sich tatsächlich eine 0 ein (Datenabfrage könnte zum Beispiel falsch sein oder es wurden falsche Daten eingetragen), dann schauen wir mal was passiert:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image416.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="60" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb395.png" width="300" border="0"></a> </p>
<p>Ergebnis:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image417.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="102" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb396.png" width="578" border="0"></a> </p>
<p>Fail!</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image418.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="183" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb397.png" width="244" border="0"></a></p>
<p>Idealerweise sollten Tests möglich häufig (sie können sogar automatisch nach jedem Build laufen!) machen - um die Fehlerquelle einzugrenzen. <br>Angenommen wir haben bei uns einen Fehler in der Abfragelogik oder die Methode (die bei uns nicht existiert, aber existieren könnte) die Daten schreibt, war fehlerhaft oder die Validation fehlgeschlagen ist... (es kann ja viele Quelle geben).</p>
<p>Wir beheben also diesen Fehler (den wir vielleicht sonst nur sehr schlecht gefunden hätten), bis wir wieder das sehen:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image419.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="57" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb398.png" width="414" border="0"></a> </p>
<p>Resultat beim Entwickler (&amp; beim zufriedenen Kunden) :</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image420.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="244" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb399.png" width="178" border="0"></a> </p>
<p>Der Testcode:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:2f5780f9-c7b7-42a1-ac1b-4177db0eea90" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">[TestMethod()]
        public void DataManager_ConnectToData_IsTrue()
        {
            DataManager man = new DataManager();
            Assert.IsTrue(man.ConnectToData());
        }

        [TestMethod()]
        public void DataManager_GetData_IsNotNull()
        {
            DataManager man = new DataManager();
            Assert.IsNotNull(man.GetData());
        }

        [TestMethod()]
        public void DataManager_GetData_CheckForZero()
        {
            DataManager man = new DataManager();
            List&lt;int&gt; result = man.GetData();
            foreach (int number in result)
            {
                Assert.AreNotEqual(0, number);
            }
        }</pre></div><strong><br>Ergebnis: </strong>
<p>Die Vorteile von UnitTests werden sicherlich erst nach und nach bei einem Projekt sichtbar, aber wenn man dies stetig fortführt, reduziert sich die Fehleranfälligkeit erheblich.<br>Das was ich hier gezeigt habe, ist sicherlich nicht das Ende der Fahnenstange - es gibt neben Unit Tests auch noch andere Tests. Das ist auf der <a href="http://msdn.microsoft.com/en-us/library/aa292191(VS.71).aspx">MSDN Testing Seite</a> recht gut beschrieben.</p>
<p><strong>Test Driven Development (TDD) :</strong></p>
<p><a href="http://de.wikipedia.org/wiki/Testgetriebene_Entwicklung">TDD</a> beschreibt ein Entwicklungsstil, wo auf Tests besonders viel Wert gelegt wird. Hier werden die Tests <strong>immer</strong> vor der eigentlichen Implementation geschrieben. Man trifft seine Annahmen und da die Methode (oder die zu testende Komponente) ja noch <strong>keine Logik</strong> enthält, wird der Test erst fehlschlagen. <br>Nun geht es darum, den Test erfolgreich zu bestehen. Sobald dies geschafft ist, kann man die <strong>Implementation hinterher nochmal überarbeiten</strong>. (<a href="http://de.wikipedia.org/wiki/Refactoring">Refactoring</a>). Nun kann man immer wieder prüfen, ob der Test noch funktioniert oder nicht - wenn er nicht mehr stimmt, dann haben wir wohl was falsch gemacht.<br>Am Ende haben wir (in der Theorie) jede Methode / Komponente mit Tests ausgestattet.</p>
<p><strong>Unit Tests in ASP.NET MVC, Silverlight &amp; co.:</strong></p>
<p>Eine Klassenbibliothek lässt sich relativ leicht testen. In ASP.NET (WebForms) ist dies allerdings nicht ganz so leicht. In ASP.NET MVC wurde darauf ein <a href="{{BASE_PATH}}/2007/11/15/was-das-aspnet-mvc-modell-bringt/">besonderer Augenmerk gelegt</a>.<br>Auch in Silverlight 2 wurde das Thema <a href="http://weblogs.asp.net/scottgu/archive/2008/04/02/unit-testing-with-silverlight.aspx">angegangen</a>. </p>
<p><strong>Weitere Links:</strong></p>
<p>Wer nun etwas neugierig geworden ist, der kann sich auch diese Links anschauen:</p>
<ul>
<li><a href="{{BASE_PATH}}/2008/05/18/mvc-storefront-real-world-application-building-excercise-aspnet-mvc-tdd-more/">MVC Storefront - Real World Application Building Excercise: ASP.NET MVC, TDD &amp; more</a> 
<li><a href="http://www.agiledata.org/essays/tdd.html">Introduction to Test Driven Design (TDD)</a> 
<li><a href="http://www.sharpregion.com/post/Fun-with-Continuous-Integration-BILTONS.aspx">Fun with Continuous-Integration. Introducing: BILTONS</a> 
<li><a href="http://haacked.com/archive/2008/01/14/tdd-is-also-an-organizational-process.aspx">TDD Is Also An Organizational Process</a> 
<li><a href="http://www.programmersheaven.com/user/pheaven/blog/128-Why-automated-testing-matters/">Why automated testing matters</a> 
<li><a href="http://chadmyers.com/Blog/archive/2007/11/27/tdd-with-asp.net-mvc-3.5-extensions.aspx">TDD with ASP.NET MVC 3.5 Extensions</a> 
<li><a href="http://haacked.com/archive/2007/12/09/writing-unit-tests-for-controller-actions.aspx">Writing Unit Tests For Controller Actions</a>
<li><a href="http://www.csharptocsharp.com/visual-studio-automate-unit-testing">Use Visual Studio's Post-Build Events to Automate Unit Testing Running</a>
<li><a href="http://dotnet-forum.de/blogs/rainerschuster/archive/2008/05/16/was-rollt-im-bereich-unittesting-auf-uns-zu.aspx">Was rollt im Bereich Unittesting auf uns zu?</a>
<li><a href="http://www.gridviewguy.com/ArticleDetails.aspx?articleID=398_Using_Post-Build_Event_to_Execute_Unit_Tests">Using Post-Build Event to Execute Unit Tests</a></li></ul>
<p><strong>Download:</strong></p>
<p><a href="http://{{BASE_PATH}}/assets/files/democode/donotfearunittests/DoNot.Fear.UnitTests.zip"><strong>Sample Code</strong></a></p>
