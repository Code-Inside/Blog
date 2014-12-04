---
layout: post
title: "HowTo: Fluent Interfaces - schöne APIs mit C# 3.0"
date: 2008-08-05 19:50
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [.NET 3.5, APIs, C# 3.0, Extension Methods, Fluent Interfaces, HowTo, Linq2Sql, Storefront]
language: de
---
{% include JB/setup %}
<p><a href="http://de.wikipedia.org/wiki/Programmierschnittstelle">APIs</a> (egal ob sie nur für interne Zwecke da sind oder auch an externe Entwicklern geht) sollten möglichst einfach und intuitiv zu bedienen sein. <br>Seit kurzem lese ich immer häufiger von "<a href="http://en.wikipedia.org/wiki/Fluent_interface">Fluent Interfaces</a>".</p> <p><strong>Was ist das denn?<br></strong>Schauen wir uns einfach mal das Wikipedia Beispiel an:</p> <p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c0c4ffea-0b8f-4e35-9709-1f2d95d2c728" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public class ExampleProgram
    {
        [STAThread]
        public static void Main(string[] args)
        {
            //Standard Example
            IConfiguration config = new Configuration();
            config.SetColor("blue");
            config.SetHeight(1);
            config.SetLength(2);
            config.SetDepth(3);
            //FluentExample
            IConfigurationFluent config = 
                  new ConfigurationFluent().SetColor("blue")
                                           .SetHeight(1)
                                           .SetLength(2)
                                           .SetDepth(3);
        }
</pre></div></p>
<p>Anstatt nur einzelne Methodenaufrufe zu haben, ist es doch viel angenehmer diese in "einem Satz" niederzuschreiben. Diese Technik findet auch in diversen Javascript-Bibliotheken Einsatz (z.b: <a href="http://jquery.com/">jQuery</a>)</p>
<p><strong>Sieht nicht schlecht aus - wie macht man sowas?</strong><br>Es gibt (wie in dem Wikipedia Beispiel) sicherlich ein paar Tricks wie man sowas machen kann - durch <a href="http://blog.wekeroad.com/">Rob Conerys</a> <a href="http://blog.wekeroad.com/mvc-storefront/">Storefront</a> Projekt bin ich konkret auf das "<a href="http://de.wikipedia.org/wiki/Pipes_and_Filters">Pipes and Filters</a>" Pattern gekommen.</p>
<p><strong>Die Idee (in der Rob Conery Version ;) )<br></strong>Wir haben einen großen Datenhaufen (unser Repository), wo wir über Filter bestimmte Sachen einfach uns abzapfen können, wie wir es brauchen.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image492.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="244" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb470.png" width="192" border="0"></a>&nbsp;</p>
<p>Das tolle nun daran: Man kann nicht nur ein Filter nehmen, sondern kann diese auch zusammenschließen um seine Ergebnisse noch weiter einzuengen:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image493.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="91" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb471.png" width="295" border="0"></a> </p>
<p>Rob Conery hat dies auch in einem <a href="http://blog.wekeroad.com/mvc-storefront/mvcstore-part-3/">Screencast</a> recht gut erklärt.</p>
<p><strong>Die Umsetzung in .NET mit C# 3.0:<br></strong>Als "Daten" haben wir in unserem Beispiel einfach eine simple Person Klasse:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c63c79e6-4315-41be-a293-c99355363c3d" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class Person
    {
        public int Age { get; set; }
        public string Name { get; set; }
    }</pre></div>
<p>Der Aufbau ist ähnlich empfunden wie bei diesem <a href="{{BASE_PATH}}/2008/07/09/howto-3-tier-3-schichten-architektur/">Blogpost</a> - allerdings etwas vereinfacht (und sollte so nicht verwendet werden (Schnittstellen einbauen!))</p>
<p>Unser DummyPersonRepository hat nur eine Methode, welche statisch ein paar Objekte erzeugt:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:6959de28-2f13-4cdc-ac22-507efaa38bec" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class DummyPersonRepository 
    {
        public IQueryable&lt;Person&gt; GetPersons()
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

            return returnValues.AsQueryable();
        }
    }</pre></div>
<p>Nun kommen unsere Filter ins Spiel - die <strong>nicht direkt ins</strong> <strong>Repository</strong> kommen! Diese werden über "<a href="http://en.wikipedia.org/wiki/Extension_method">Extension Methods</a>" in einer seperaten Klasse implementiert:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:99a5ac25-69b9-4fd6-a491-8c94d3948c6d" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public static class PersonFilters
    {
        public static IQueryable&lt;Person&gt; WithAge(this IQueryable&lt;Person&gt; qry, int age)
        {
            return (from x in qry
                    where x.Age == age
                    select x);
        }

        public static IQueryable&lt;Person&gt; NameStartsWith(this IQueryable&lt;Person&gt; qry, string start)
        {
            return (from x in qry
                    where x.Name.StartsWith(start)
                    select x);
        }
    }</pre></div>
<p>Hier fragen wir einmal nach dem Alter und ob der Name mit was bestimmten beginnt - beides als "Extension Method".</p>
<p>In unserem Service können wir nun so eine Methode bereitstellen:
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:301f66c2-29cd-476e-9c48-e146e3e2105d" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        public IList&lt;Person&gt; GetPersons(int age, string startsWith)
        {
            return this.PersonRep.GetPersons().WithAge(age).NameStartsWith(startsWith).ToList();
        }</pre></div></p>
<p>Sehr einfach und effektiv :)</p>
<p><strong>Ergebnis:<br></strong>Am Ende können wir einfach in einer Konsolenapplikation sowas aufrufen:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b9c3b661-25ca-4d7b-9997-102640e00574" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">static void Main(string[] args)
        {
            PersonService srv = new PersonService();
            List&lt;Person&gt; resultList = srv.GetPersons(20, "R").ToList();
            foreach (Person result in resultList)
            {
                Console.WriteLine("Name {0} - Age {1}", result.Name, result.Age);
            }

            Console.Read();
        }</pre></div>
<p><strong>Die Projektstruktur:</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image494.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="322" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb472.png" width="231" border="0"></a> </p>
<p>Natürlich ist das nur ein simples Beispiel, allerdings konnte ich dies bereits effektiv in einem Projekt einsetzen. </p>
<p>Neben Rob Conerys Storefront kann man sich auch diesen Democode von <a href="http://weblogs.asp.net/mikebosch/">Mike Bosch</a> anschauen (<a href="http://weblogs.asp.net/mikebosch/archive/2008/07/31/iqueryable-linq-to-sql-and-fluid-filters-for-data-access.aspx">Teil 1</a> &amp; <a href="http://weblogs.asp.net/mikebosch/archive/2008/08/01/part-ii-fluid-filters-iqueryable-and-linq-to-sql-for-easy-data-access.aspx">2</a>) - auch er findet diese Idee sehr cool :)</p>
<p>Insgesamt erlaubt ein solcher Programmierstil deutlich schickeren Code - wie bereits das Wikipedia Beispiel am Anfang gezeigt haben sollte.</p>
<p><strong>[ <a href="{{BASE_PATH}}/assets/files/democode/fluentinterfaces/fluentinterfaces.zip">Download Democode</a> ]</strong></p>
