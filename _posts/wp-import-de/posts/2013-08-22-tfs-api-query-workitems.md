---
layout: post
title: "TFS API: Query WorkItems"
date: 2013-08-22 00:15
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [HowTo, TFS, WorkItems]
language: de
---
{% include JB/setup %}
<p>Nachdem wir schon <a href="{{BASE_PATH}}/2013/08/19/tfs-api-query-build-definitions/">Build-Informationen</a> und <a href="{{BASE_PATH}}/2013/08/20/tfs-api-query-changesets-team-foundation-version-control/">Changesets</a> über die API geholt haben kommen wir nun zu den WorkItems – wobei hiermit alles gemeint ist, was der TFS zu bieten hat: User Stories, Issues etc.</p> <h3>Benötigte Assemblies</h3> <p>Es gibt wieder eine Reihe von Assemblies die man aus dem Installationsverzeichnis (<em>C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\ReferenceAssemblies\v2.0 – für VS 2012</em>) kopieren muss. Eine Besonderheit gibt es noch: Scheinbar ist eine Assembly im GAC höher als in dem Ordner, daher muss man diese Assembly direkt aus dem GAC kopieren, ansonsten kommt es zu einer Exception.</p> <p>- Microsoft.TeamFoundation.Client.dll<br>- Microsoft.TeamFoundation.Common.dll<br>- Microsoft.TeamFoundation.WorkItemTracking.Client.DataStoreLoader.dll<br>- Microsoft.TeamFoundation.WorkItemTracking.Client.dll<br>- Microsoft.TeamFoundation.WorkItemTracking.Common.dll<br>- Microsoft.TeamFoundation.WorkItemTracking.Proxy.dll (diese ist die GAC dll!) <p>Zusätzlich muss noch “Microsoft.WITDataStore.dll” mit ausgeliefert werden – dies ist allerdings keine .NET Assembly.</p> <p>Den Fehler habe ich in einem ReadMe im GitHub Projekt näher erklärt – evtl. ist die mit einem späteren Update ohnehin nicht mehr relevant.</p> <p>Ohne jetzt in diesem Fall genau nachgeschaut zu haben: Im Falle von einer IIS WebApp müsste vermutlich “Enable 32bit Applications” auf true stehen – wie bei den anderen Samples.</p> <h3>Gleich zum Code…</h3> <p>Ziel der Übung soll es sein die WorkItems anzuzeigen, welche sich in den letzten 48 Stunden geändert haben. Für diese WorkItems möchten wir zusätzlich noch die einzelnen Revisions anschauen – also was hat sich genau geändert.</p> <p><strong>…etwas Konfiguration….</strong></p> <p>Das Vorgehen hier ist ähnlich wie bei den anderen Beispielen, allerdings nutzt mein Beispiel einen Query der vorher definiert sein muss. Man kann über die API auch direkt einen <a href="http://msdn.microsoft.com/en-us/library/bb140399.aspx">Query</a> absetzen – dies muss aber in der <a href="http://msdn.microsoft.com/en-us/library/bb130198(v=vs.90).aspx">Work Item Query Language</a> verfasst sein.</p> <p>Da mir dies zu “kompliziert” war, habe ich den Query über die Webapp erstellt:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1905.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1046.png" width="570" height="233"></a> </p> <h3>Code:</h3> <p>Die API ist etwas komplexer, da man erst in den “Query-Folder” wechseln muss (jedenfalls habe ich nichts anderes gefunden – ausser über eine GUID zu gehen, die nirgends angezeigt wird). Mein Query hier liegt und “My Queries” und heisst “New Query 1” im TFS Projekt “Grocerylist”. Man muss den @Project Platzhalter im Code mit dem richtigen Projektnamen ersetzen – mit @Today hat er keine Probleme.</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">            TfsTeamProjectCollection tfs = new TfsTeamProjectCollection(new Uri("https://code-inside.visualstudio.com/DefaultCollection"));


            // http://stackoverflow.com/questions/10748412/retrieving-work-items-and-their-linked-work-items-in-a-single-query-using-the-tf/10757338#10757338
            var workItemStore = tfs.GetService&lt;WorkItemStore&gt;();

            var project = workItemStore.Projects["Grocerylist"];
            QueryHierarchy queryHierarchy = project.QueryHierarchy;
            var queryFolder = queryHierarchy as QueryFolder;
            QueryItem queryItem = queryFolder["My Queries"];
            queryFolder = queryItem as QueryFolder;

            if (queryFolder != null)
            {
                Dictionary&lt;string, string&gt; variables = new Dictionary&lt;string, string&gt;();
                variables.Add("project", "Grocerylist");

                var myQuery = queryFolder["New Query 1"] as QueryDefinition;
                if (myQuery != null)
                {
                    var wiCollection = workItemStore.Query(myQuery.QueryText, variables);
                    foreach (WorkItem workItem in wiCollection)
                    {
                        Console.WriteLine("WorkItem -----------------------------");
                        Console.WriteLine(workItem.Title);

                        foreach (Revision rev in workItem.Revisions)
                        {
                            Console.WriteLine("  - Revition: " + rev.Index);

                            foreach (Field f in rev.Fields)
                            {
                                if (!Object.Equals(f.Value, f.OriginalValue))
                                {
                                    Console.WriteLine("  - Changes: {0}: {1} -&gt; {2}", f.Name, f.OriginalValue, f.Value);
                                }
                            }
                            Console.WriteLine("  ------------------");

                        }

                    }
                }
            }</pre>
<h3>Ergebnis:</h3>
<p>Der Query lieft mir ein WorkItem zurück und ich iteriere noch über alle Revisions dieses Items. Hier könnte man noch filtern, da ja nicht alle Revisions in den letzten 48 Stunden gemacht wurden, aber das sind Details ;)</p>
<p>Man kann auch recht einfach ausgeben lassen, welche Felder sich geändert haben. Im Grunde merkt man hier recht schnell, warum auch Visual Studio zum Teil in der WorkItem History so viele Einträge drin hat – es wird recht schnell unübersichtlich.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1906.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1047.png" width="580" height="613"></a> </p>
<p><strong>Fazit:</strong></p>
<p>Ein klein wenig mehr Arbeit, aber auch dies ging relativ problemlos. Zumindest die Daten lesen ist recht einfach gemacht.</p>
<p>Das Sample ist wie immer in unserem <a href="https://github.com/Code-Inside/Samples/tree/master/2013/TfsApi.WorkItems"><strong>Sample-Repo auf GitHub</strong></a>.</p>
