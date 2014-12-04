---
layout: post
title: "HowTo: Interfaces/Schnittstellen einsetzen - Gute Gründe für den Einsatz von Schnittstellen"
date: 2008-08-12 22:22
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Dependency Injection, DI, HowTo, Interfaces, TDD, UnitTests]
language: de
---
{% include JB/setup %}
<p>In <a href="{{BASE_PATH}}/2007/11/28/howto-interfacesschnittstellen-verstehen-mal-auf-simple-art-und-weise/">einem HowTo</a> ging es darum, was Interface eigentlich sind und wo man sowas einsetzen könnte. In vielen <a href="http://de.wikipedia.org/wiki/Objektorientierte_Programmierung">OOP</a> Büchern wird immer wieder hervorgehoben, warum es so wichtig ist, "<strong>auf eine Schnittstelle zu programmieren</strong>" und nicht "<strong>auf eine konkrete Klasse</strong>". Bis vor kurzem war es mir selber noch nicht ganz klar, wozu dieser Aufriss mit den ganzen Schnittstellen, bis ich mit "<a href="http://de.wikipedia.org/wiki/Testgetriebene_Entwicklung">Test Driven Development</a>" angefangen habe.</p> <p><strong>Häufige Argumentation für Interfaces:</strong></p> <p>Wenn man sich etwas mit den Interfaces beschäftigt, dann kommt man immer wieder zum Datenbankbeispiel. "Stellen wir uns doch mal vor, die Datenquelle wechselt!"</p> <p><strong>Wie könnte ein Interface an dieser Stelle helfen?</strong></p> <p>An dieser Stelle können Interface helfen, indem sie wie eine Art "Vertrag" wirken:</p> <p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:42081a2e-dfab-4e36-8c90-2d1dcced7b9c" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c">interface IDataProvider
{
	List&lt;string&gt; GetData();
}

class OracleDataProvider : IDataProvider
{
	List&lt;string&gt; GetData()
	{
	// Oracle Zeugs
	}
}

class SqlDataProvider : IDataProvider
{
	List&lt;string&gt; GetData()
	{
	//MS Sql Zeugs
	}
}</pre></div></p>
<p>Clients die diesen Code nutzen möchten brauchen, ähnlich wie beim <a href="{{BASE_PATH}}/2007/11/28/howto-interfacesschnittstellen-verstehen-mal-auf-simple-art-und-weise/">ersten HowTo um Schnitt</a>stellen, nur noch das Interface nutzen:</p>
<p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b6285396-cc7f-4e46-956b-ce0ff01d2ab2" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">class ClientCode
{
	public IDataProvider provider;
}</pre></div></p>
<p>Dadurch kann man theoretisch die Datenbank nun wechseln so oft man möchte - unser ClientCode benötigt keine Änderung.</p>
<p><strong>Allerdings...</strong></p>
<p>ist dieses Beispiel meiner Meinung nach sehr "dürftig". Zwar kann man es daran sehr gut erklären, aber bei wie vielen Applikationen wird sowas überhaupt mit betrachtet? Bei vielen Projekten steht fest, welche DB genommen werden soll/genommen wird - die Datenbank wird sich sicherlich nicht ändern (und wenn doch, wird dies halt ein riesiger Change Request ;) ).</p>
<p>Was viele nicht betrachten ist, dass durch den Einsatz von Interfaces auch die Testbarkeit einer Applikation steigert.</p>
<p><strong>Beispielanwendung:</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image520.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="220" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb498.png" width="210" border="0"></a> </p>
<p>Unser "Data" gibt Daten an den Service, dieser verarbeitet diese und reicht die weiter (<a href="{{BASE_PATH}}/2008/07/09/howto-3-tier-3-schichten-architektur/">3-Tier</a>). Wie hier zu sehen ist, gibt es nur die konkrete Klasse "PersonService" (unser Service) und "Person" (unser Model) - alles andere sind Schnittstellen:</p>
<p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:36136e9d-8194-4d29-8427-bc2c1c06bf37" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public class PersonService : IPersonService
    {
        private IAuthenticationService authentication;
        private IPersonDataProvider personProvider;

        public PersonService(IAuthenticationService authSrv, IPersonDataProvider provider)
        {
            authentication = authSrv;
            personProvider = provider;
        }

        public List&lt;Person&gt; GetPersons()
        {
            if (authentication.IsAuthenticated())
            {
                return personProvider.GetPersons();
            }
            
            return null;
        }

        public void AddPerson(Person p)
        {
            if (authentication.IsAuthenticated())
            {
                personProvider.AddPerson(p);
            }
        }

    }</pre></div>Unser Service kennt nur die Interface vom AuthenticationServie und vom DataProvider - diese werden im Konstruktor mit übergeben. <br><strong>Anmerkung</strong>: Diese Form der Übergabe von den "Abhängigkeiten" ist dem Feld der "<a href="http://de.wikipedia.org/wiki/Dependency_Injection">Dependency Injection</a>" zuzuordnen und werde ich in einem anderen HowTo genauer definieren. </p>
<p>Unser Service kann die Daten nur ausgeben, wenn wir authentifiziert sind.</p>
<p><strong>Szenario:</strong></p>
<p>Wenn wir nun ein größeres Projekt angehen und der Authentifizierungsmechanismus nicht so einfach ist und auch Fremdsysteme mit einbezieht, dann wäre es ja nett, wenn man während der Entwicklung eine Art "Fake" aufsetzen kann. Durch die Interface ist es sehr einfach, sowas zu machen:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image521.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="132" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb499.png" width="244" border="0"></a> </p>
<p>In meinem <a href="{{BASE_PATH}}/2008/05/22/howto-einfache-tests-unittests-oder-keine-angst-vor-unittests/">UnitTest</a> Projekt will ich meinen Service testen - und <a href="{{BASE_PATH}}/2008/08/05/howto-unittests-und-einfhrung-in-mocking-mit-rhinomocks/">nur diesen(!).</a> dafür habe ich mit ein "TestPersonDataProvider" erstellt, der "IPersonDataProvider" implementiert und jeweils ein AuthenticationService, welcher mir sagt, dass ich authentifiziert bin, oder nicht.</p>
<p><strong>Mein Testcode:</strong></p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:2fce7e11-72f3-4da6-94fa-e71eb33229d0" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    [TestClass]
    public class PersonServiceUnitTest
    {
        [TestMethod]
        public void PersonService_ReturnPersons_Work_With_Authentication()
        {
            TestPersonDataProvider provider = new TestPersonDataProvider();
            PersonService srv = new PersonService(new TrueTestAuthenticationService(), provider);
            Assert.AreEqual(provider.InMemoryPersonCollection.Count, srv.GetPersons().Count);
        }

        [TestMethod]
        public void PersonService_Should_Return_Null_Without_Authentication()
        {
            TestPersonDataProvider provider = new TestPersonDataProvider();
            PersonService srv = new PersonService(new FalseTestAuthenticationService(), provider);
            Assert.IsNull(srv.GetPersons());
        }
    }</pre></div>
<p>In meinem Testcode kann ich nun einfach die jeweiligen "Fakes" übergeben - ohne den Clientcode ändern zu müssen.</p>
<p><strong>Fazit:</strong></p>
<p>Durch den Einsatz von Interfaces kann man sehr erweiterbare Systeme machen - ein Beispiel ist z.B. das <a href="http://asp.net/mvc">MVC Framework von Microsoft</a>. Der Nebeneffekt ist natürlich auch, dass man die Datenquelle wechseln kann oder dass man einfache Fakes in den Tests, aber auch im Produktionscode verwenden kann (jedenfalls bevor auf "Release" gedrückt wird ;)).</p>
<p><strong>Schnittstellen erlauben erweiterbare und testbare Software!</strong></p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/whyinterfaces/whyinterfaces.zip">[ Download Democode ]</a></strong></p>
