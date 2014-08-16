---
layout: post
title: "Was sind RavenDB Indexes und wie kann ich diese Unit-testen?"
date: 2012-01-18 22:18
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, Index, NoSQL, RavenDB, Unit Test]
---
{% include JB/setup %}
<p>Wer mit <a href="http://www.knowyourstack.com/what-is/ravendb">RavenDB</a> arbeitet kommt automatisch zu einem sehr mächtigen Mittel: Den Indexen. Der Hauptfokus des Posts liegt hierbei auf dem Unit-Testen von RavenDB. Unit-Testing in Datenbank-Projekten ist mehr als anstrengend und zeitfressend. RavenDB lässt sich allerdings recht einfach in einen “Test” Modus versetzen, sodass die Funktionalität erhalten bleibt. </p> <p><em>Achtung: Streng genommen darf ein Unit-Test auch keine Datenbank berühren, da man damit mehr als die eigentliche Test-Einheit testet. Richtiger wäre Integrationstests, allerdings redet die halbe Softwarewelt generell von Unit-Tests. Daher belassen wir es mal bei der unschärfe.</em></p> <p>Der Code selbst ist unter Mithilfe von <a href="http://daniellang.net/">Daniel Lang</a> entwickelt, als er mir bei einem RavenDB Index <a href="http://code-inside.de/blog/2012/01/16/gitpull-request-mergen-fr-anfnger/">geholfen</a> hat.</p> <p><strong>Was ist ein RavenDB Index?</strong></p> <p>Ein <a href="http://ravendb.net/documentation/how-indexes-work">RavenDB Index</a> kann man sich als gespeicherte Abfrage vorstellen, welche von RavenDB im Hintergrund ausgeführt wird und das entsprechende Result zwischenspeichert. Über RavenDB Indexe können Abfragen über mehrere Dokumente gemacht werden und über Map/Reduce die Ergebnismenge angepasst werden. </p> <p><strong>Bsp: </strong></p> <p>Ein ganz simpler Index sieht so aus:</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:8a2a1586-9e7f-41da-9a0c-c8185a0151de" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    public class SearchIndex : AbstractIndexCreationTask&lt;Term&gt;
    {
        public SearchIndex()
        {
            Map = terms =&gt; from term in terms
                            select new { term.Title };

            Index(x =&gt; x.Title, FieldIndexing.Analyzed);
        }
    }</pre></div>
<p>&nbsp;</p>
<p>Was das ganze überhaupt macht, ist <a href="http://daniellang.net/searching-on-string-properties-in-ravendb/">hier gut erklärt</a>. Wenn ich den Code anwenden möchte:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d3ce19f0-938f-4b6b-9bbb-fc4991c007c4" class="wlWriterEditableSmartContent"><pre name="code" class="c#">Session.Query&lt;Term, SearchIndex&gt;().Where(x =&gt; x.Title.StartsWith(searchTerm)).ToList();</pre></div>
<p>&nbsp;</p>
<p><strong>Unit-Test dazu (gemacht mit xUnit)</strong></p>
<p>&nbsp;</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:2ea25287-ed20-47c2-93ca-bb2ce35be1f8" class="wlWriterEditableSmartContent"><pre name="code" class="c#">public abstract class RavenTest
    {
        protected IDocumentStore GetDatabase()
        {
            var documentStore = new EmbeddableDocumentStore
                                    {
                                        RunInMemory = true
                                    };
            documentStore.Initialize();

            return documentStore;
        }
    } 

public class SearchIndexTest : RavenTest
    {
        [Fact]
        public void TitleContainsSearch()
        {
            using (var documentStore = GetDatabase())
            {
                IndexCreation.CreateIndexes(typeof(UserActivityFeedIndex).Assembly, documentStore);

                using (var documentSession = documentStore.OpenSession())
                {
                    documentSession.Store(new Term
                                              {
                                                  Title = "RavenDB",
                                              });
                    documentSession.Store(new Term
                                              {
                                                  Title = "ASP.NET MVC",
                                              });

                    documentSession.Store(new Term
                                            {
                                                Title = "Twitter Bootstrap",
                                            });

                    documentSession.SaveChanges();

                    var result = documentSession.Query&lt;Term, SearchIndex&gt;().Where(x =&gt; x.Title.StartsWith("Boot"))
                                                                           .Customize(x =&gt; x.WaitForNonStaleResults())
                                                                           .ToList();

                    Assert.Equal(1, result.Count);

                    Assert.Equal("Twitter Bootstrap", result[0].Title);
                }
            }
        }
    }</pre></div>

<p>&nbsp;</p>
<p>Die RavenTest Klasse erstellt die Connection zur RavenDB “embedded” Datenbank. Über “<strong>RunInMemory</strong>” wird dies auch nur im Arbeitsspeicher gehalten. Vorteil: Sehr schnell und kein Cleanup nach dem Test. </p>
<p>In der Testmethode wird erst der Index angelegt (über Reflection wird die Assembly durchsucht) und dann werden Testdaten in diese DB abgespeichert. Am Ende erfolgt die Abfrage und das Ergebnis wird überprüft. Bei der Abfrage wird noch ein <strong>WaitForNonStaleResults</strong> dazugehangen um auch die gerade eben gespeicherten Daten mit abzufragen (RavenDB speichert die Index-Ergebnisse zwischen, sodass es zu einer kurzen Verzögerung kommen kann. Ist im Unit-Testing allerdings ungünstig.)</p>
<p>Sehr einfach und wesentlich eleganter als bei einer klassischen DB.</p>
