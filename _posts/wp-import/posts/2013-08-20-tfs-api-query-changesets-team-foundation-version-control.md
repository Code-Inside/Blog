---
layout: post
title: "TFS API: Query Changesets (Team Foundation Version Control)"
date: 2013-08-20 23:28
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, TFS]
---
{% include JB/setup %}
<p>Passend zum letzten Blogpost “<a href="{{BASE_PATH}}/2013/08/19/tfs-api-query-build-definitions/">TFS API: Query Build-Definitions</a>” möchte ich heute Team Foundation Server die letzten Changesets über die .NET API entlocken.</p> <p>Der Code funktioniert allerdings nur wenn man die Version Control vom Team Foundation Server nutzt. Git basierte Projekte (welche man ganz einfach im Cloud TFS anlegen kann) haben eine andere API – dazu aber in einem späteren Blogpost. Diese APIs sind unter dem Namespace Microsoft.TeamFoundation.Git.* zu finden. Die <a href="http://msdn.microsoft.com/en-us/library/bb130146(v=vs.120).aspx">Dokumentation</a> ist allerdings aktuell noch in Preview.</p> <h3>Benötigte Assemblies</h3> <p>Die Assemblies die benötigt werden sind fast dieselben wie bei der Build API, wobei ich hier noch eine Assemblie zusätzlich benötige. Die Assemblies befinden sich im Visual Studio Installationsverzeichnis (<em>C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\ReferenceAssemblies\v2.0 – für VS 2012</em>). </p> <p>Hier die Liste der Assemblies: <p>- Microsoft.TeamFoundation.Client.dll<br>- Microsoft.TeamFoundation.Common.dll<br>- Microsoft.TeamFoundation.VersionControl.Common.dll<br>- Microsoft.TeamFoundation.VersionControl.Client.dll<br>- Microsoft.TeamFoundation.Build.Common.dll<br>- Microsoft.TeamFoundation.Build.Client.dll</p> <p><strong>Achtung: Im IIS AppPool (falls man dies via einer WebApp nutzen möchte) muss “Enable 32bit Applications” aktiv sein!</strong> Die Assemblies scheinen mindestens zum Teil 32bit Assemblies zu sein bzw. ging es ohne diese Einstellung einfach nicht. <h3>Demo Code:</h3> <p>In diesem Fall verwende ich die <a href="http://msdn.microsoft.com/en-us/library/microsoft.teamfoundation.versioncontrol.client.versioncontrolserver.queryhistory.aspx">QueryHistory</a> Methode des <a href="http://msdn.microsoft.com/en-us/library/Microsoft.TeamFoundation.VersionControl.Client.VersionControlServer.aspx">VersionControlServer</a> Objekts. Vermutlich gibt es noch “effektiviere” Varianten. Der Query gibt als Resultat alle Changesets unter dem Pfad “$/Grocerylist” zurück (wobei Grocerylist ein Demo-Projekt war). Ein Parameter gibt die Zeitspanne an. Im Beispiel hole ich mir alle Changesets die im letzten Jahr gemacht wurden. Was jeder einzelne Parameter kann, weiss ich leider nicht – aber die <a href="http://msdn.microsoft.com/en-us/library/microsoft.teamfoundation.versioncontrol.client.versioncontrolserver.queryhistory.aspx">Dokumentation</a> vielleicht schon eher ;)</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">class Program
    {
        static void Main(string[] args)
        {
            TfsTeamProjectCollection tfs = new TfsTeamProjectCollection(new Uri("https://code-inside.visualstudio.com/DefaultCollection"));

            VersionControlServer vcs = (VersionControlServer)tfs.GetService(typeof(VersionControlServer));

            //Following will get all changesets since 365 days. Note : "DateVersionSpec(DateTime.Now - TimeSpan.FromDays(20))"
            System.Collections.IEnumerable history = vcs.QueryHistory("$/Grocerylist", 
                                                                      LatestVersionSpec.Instance,
                                                                      0,
                                                                      RecursionType.Full,
                                                                      null,
                                                                      new DateVersionSpec(DateTime.Now - TimeSpan.FromDays(365)),
                                                                      LatestVersionSpec.Instance,
                                                                      Int32.MaxValue,
                                                                      false,
                                                                      false);

            foreach (Changeset changeset in history)
            {
                Console.WriteLine("Changeset Id: " + changeset.ChangesetId);
                Console.WriteLine("Owner: " + changeset.Owner);
                Console.WriteLine("Date: " + changeset.CreationDate.ToString());
                Console.WriteLine("Comment: " + changeset.Comment);
                Console.WriteLine("-------------------------------------");
            }

            Console.ReadLine();
        }
    }</pre>
<h3>Resultat:</h3>
<p>Jedes Objekt enthält auf dem ersten Blick alle Daten die man auch über Visual Studio &amp; co. beziehen kann – dazu WorkItems, CheckinNotes usw.
<p><a href="{{BASE_PATH}}/assets/wp-images/image1904.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb1045.png" width="587" height="413"></a> 
<p>Über “QueryHistory” kann man als vorletzten Parameter noch angeben ob man die Changes haben möchte – so kann man auch direkt nachvollziehen was wirklich geändert wurde.
<h3>Authentifizierung</h3>
<p>Wie bei der Build-API: Es wird der angemeldete Windows bzw. Microsoft Account genommen – ansonsten wird ein Authentifizierungsfenster angezeigt. Man kann auch die Credentials über die API mitgeben. Alles <a href="{{BASE_PATH}}/2013/08/19/tfs-api-query-build-definitions/">weitere in dem TFS Build Blogpost</a>.
<h3></h3>
<h3>Fazit:</h3>
<p>Auf den ersten Blick: Schnell, einfach und alle Daten die man benötigt.</p>
