---
layout: post
title: "TFS-API: Query TestRuns - Test-Ergebnisse und Unit-Test Ergebnisse bekommen"
date: 2013-08-25 20:59
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [TestRuns, Tests, TFS]
language: de
---
{% include JB/setup %}
<p>Über die TFS API kann man Allerlei Informationen dem TFS entlocken. In den Vorangegange Blogposts habe ich bereits gezeigt wie man <a href="{{BASE_PATH}}/2013/08/19/tfs-api-query-build-definitions/"><strong>Build</strong></a>, <a href="{{BASE_PATH}}/2013/08/20/tfs-api-query-changesets-team-foundation-version-control/"><strong>Changeset</strong></a> oder <a href="{{BASE_PATH}}/2013/08/22/tfs-api-query-workitems/"><strong>WorkItem</strong></a> Informationen abrufen kann. Als letzten “Über-Punkt” kommt das Thema <strong>Testing</strong>.</p> <h3>Testing? Was heisst das?</h3> <p>Ganz im Groben würde ich erstmal “Code”-Tests (Unit-Tests / Coded-UI Tests) und die Testpläne aus dem Test Manager unterscheiden – allerdings bin ich an der Stelle kein TFS Experte, daher könnte man Wording auch falsch an dieser Stelle sein – aber zur Veranschaulichungen reicht es.</p> <p><strong>Zu den “Code”-Tests:</strong></p> <p>Das sind im Grunde normale Unit-Tests:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1907.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1048.png" width="535" height="274"></a> </p> <p>&nbsp;</p> <p><strong>Die Tests vom Test Manager:</strong></p> <p>Der TFS kennt neben den “normalen” Unit-Tests noch wesentlich mehr – man kann Testpläne mit TestCases erstellen und diese haben wiederum Testschritte. Man kann damit sehr umfangreiche Tests anlegen, welche manuell als auch automatisiert basierend auf verschiedenen Umgebungen und Builds anwenden kann. Dies ist aber vermutlich der Teil des TFS den ich am wenigsten wirklich kenne. Zur Veranschaulichung gibt es auch ein eigenen Client nur für die Tests – der Microsoft Test Manager. Diese Tests können auch via API maniupuliert und abgefragt werden:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1908.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1049.png" width="565" height="221"></a> </p> <p>Im Web-Interface vom TFS sieht man dies ebenfalls:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1909.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1050.png" width="569" height="168"></a>&nbsp;</p> <h3>Das Szenario: UnitTests &amp; TestRuns der letzten Tage abrufen</h3> <p>Der Demo-Code soll die Test-Ergebnisse der letzten TestRuns (die, die man im Test Manager definiert) und die letzten Unit-Test Durchläufe anzeigen.</p> <p><strong>Im Grunde diese Ergebnisse aus dem Test Manager:</strong></p> <p>Das sind alle Testdurchläufe für den einen Testplan den ich erstellt habe. Darunter sind die konkreten Ergebnisse für jeden Test-Step:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1910.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1051.png" width="569" height="244"></a> </p> <p>… und die Ergebnisse aus diesem Build:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1911.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1052.png" width="571" height="538"></a> </p> <h3>Code:</h3> <p>Für den Code werden folgende Assemblies benötigt:</p> <p>- Microsoft.TeamFoundation.Client<br>- Microsoft.TeamFoundation.Common<br>- Microsoft.TeamFoundation.TestManagement.Client<br>- Microsoft.TeamFoundation.TestManagement.Common<br>- Microsoft.TeamFoundation.WorkItemTracking.Client</p> <p>Alle Assemblies finden sich im ReferenceAssemblies Ordner (<em>C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\ReferenceAssemblies\v2.0</em> für VS 2012)</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">class Program
    {
        static void Main(string[] args)
        {
            TfsTeamProjectCollection tfs = new TfsTeamProjectCollection(new Uri("https://code-inside.visualstudio.com/DefaultCollection"));
            ITestManagementService testManagement = (ITestManagementService)tfs.GetService(typeof(ITestManagementService));

            // WIQL for Test: http://blogs.msdn.com/b/duat_le/archive/2010/02/25/wiql-for-test.aspx?Redirected=true
            string query = "SELECT * FROM TestRun WHERE TestRun.CompleteDate &gt; '" + DateTime.Now.AddDays(-3).Year + "-" + DateTime.Now.AddDays(-3).Month + "-" + DateTime.Now.AddDays(-3).Day + "'";

            var testRuns = testManagement.QueryTestRuns(query);

            foreach (var testPlan in testRuns)
            {
                Console.WriteLine("------------------");
                Console.WriteLine("TestPlan-Title: {0}", testPlan.Title);
                Console.WriteLine("Overall State: {0}", testPlan.State);
                Console.WriteLine("Overall DateCreated: {0}", testPlan.DateCreated);
                Console.WriteLine("Overall PassedTests: {0}", testPlan.PassedTests);


                var testRunResults = testPlan.QueryResults();

                Console.WriteLine("Test Run Results:");
                foreach (var testRunResult in testRunResults)
                {
                    Console.WriteLine("  TestRun: {0}", testRunResult.TestCaseTitle);
                    Console.WriteLine("  State: {0}", testRunResult.State);

                    if (testRunResult.TestCaseId != 0)
                    {
                        var testCaseDetail = testManagement.GetTeamProject("Grocerylist").TestCases.Find(testRunResult.TestCaseId);

                        foreach (var steps in testRunResult.Iterations)
                        {
                            foreach (var action in steps.Actions)
                            {
                                var actionFromTestCase = (ITestStep)testCaseDetail.FindAction(action.ActionId);
                                Console.WriteLine("    " + actionFromTestCase.Title + " : " + action.Outcome);
                            }
                        }
                    }
                    else
                    {
                        Console.WriteLine("  No TestCase behind this Testrun");
                    }
                }

            }

            Console.ReadLine();
        }</pre>
<p><strong>Erklärung:</strong></p>
<p>Es gibt einen <a href="http://blogs.msdn.com/b/duat_le/archive/2010/02/25/wiql-for-test.aspx?Redirected=true">SQL-ähnlichen Syntax um alle TestRuns abzufragen</a> – in dem Falle Grenz ich dies noch anhand des Datums ein.</p>
<p>Als Ergebnisse von <a href="http://msdn.microsoft.com/de-de/library/microsoft.teamfoundation.testmanagement.client.itestmanagementservice.querytestruns(v=vs.100).aspx">QueryTestRuns</a> kommen sowohl Unit-Tests (die z.B. bei einem Build angestossen wurden) als auch die Tests aus dem Test Manager als <a href="http://msdn.microsoft.com/en-us/library/microsoft.teamfoundation.testmanagement.client.itestrun.aspx">ITestRun Objekt</a>. Etwas schwieriger ist es wirklich die konkreten TestSteps bei einem Test Manager Test zu bekommen. Interessanterweise gibt die API auch nur die Titel mit HTML Tags aus – eine andere Art habe ich nicht gefunden.</p>
<p><strong>Als Ergebnisse des Codes kommt dies:</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1912.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1053.png" width="586" height="533"></a> </p>
<p>Hierbei hatte ich vorher ein Build mit Unit-Tests angestossen und 3 Testläufe vom “Blogpost Testplan” durchgeführt. Über die API bekommt man auch mit ob es ein automatischer oder manueller Test ist. In den Properties sieht man auch ob der Test aufgrund eines Builds angestossen wurde – alles was man im Visual Studio sieht, bekommt man irgendwie auch über die API hin.</p>
<p><strong>Hier gibt es zudem noch einige Code-Snippets:</strong></p>
<p><a href="http://blogs.msdn.com/b/aseemb/archive/2012/08/07/code-snippets-on-test-management-apis.aspx">Code snippets on Test Management APIs?</a></p>
<p>Den gesamten Code gibt es auch auf <a href="https://github.com/Code-Inside/Samples/tree/master/2013/TfsApi.TestRuns"><strong>GitHub</strong></a>.</p>
