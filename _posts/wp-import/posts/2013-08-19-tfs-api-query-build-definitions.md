---
layout: post
title: "TFS API: Query Build-Definitions"
date: 2013-08-19 23:26
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Build Server, TFS]
---
{% include JB/setup %}
<p>Der Team Foundation Server bietet On-Premise und&nbsp; als <a href="{{BASE_PATH}}/2012/11/05/team-foundation-service-ein-erster-blick-auf-den-tfs-in-der-cloud/">“Cloud-TFS” (Team Foundation Services)</a> einge ganze Reihen von “Diensten” (Build, WorkItems, Source Control, …) an – diese Dienste lassen sich auch recht einfach über .NET APIs abfragen.</p> <p>In dem Blogpost möchte ich einfach die letzten Build Ergebnisse eines Team-Projekts abfragen.</p> <p><strong>Benötigte Assemblies</strong></p> <p>Für das Abfragen der Builds werden nicht alle der 5 Assemblies benötigt, allerdings kommt man früher oder später an dem Punkt wo man sie evtl. brauchen könnte. Die Assemblies liegen alle im Visual Studio Installationsverzeichnis (<em>C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\ReferenceAssemblies\v2.0 – für VS 2012</em>) und können von dort kopiert werden und in die eigene Solution integriert werden.</p> <p>Hier die Liste der Assemblies:</p> <p>- Microsoft.TeamFoundation.Client.dll<br>- Microsoft.TeamFoundation.Common.dll<br>- Microsoft.TeamFoundation.VersionControl.Client.dll<br>- Microsoft.TeamFoundation.Build.Common.dll<br>- Microsoft.TeamFoundation.Build.Client.dll</p> <p><strong>Achtung: Im IIS AppPool (falls man dies via einer WebApp nutzen möchte) muss "Enable 32bit Applications" aktiv sein!</strong> Die Assemblies scheinen mindestens zum Teil 32bit Assemblies zu sein bzw. ging es ohne diese Einstellung einfach nicht.</p> <p><strong>Demo Code:</strong></p> <p>Über die API greife ich in dem Fall auf den Team Foundation Service zurück. </p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">class Program
    {
        static void Main(string[] args)
        {
            // Auth with UserName &amp; Password (Microsoft Acc):
            //BasicAuthCredential basicCred = new BasicAuthCredential(new NetworkCredential("xxx@hotmail.com", "pw"));
            //TfsClientCredentials tfsCred = new TfsClientCredentials(basicCred);
            //tfsCred.AllowInteractive = false;
            //
            //TfsTeamProjectCollection tfs = new TfsTeamProjectCollection(new Uri("https://code-inside.visualstudio.com/DefaultCollection"), tfsCred);

            TfsTeamProjectCollection tfs = new TfsTeamProjectCollection(new Uri("https://code-inside.visualstudio.com/DefaultCollection"));

            IBuildServer buildServer = (IBuildServer)tfs.GetService(typeof(IBuildServer));

            var builds = buildServer.QueryBuilds("DrinkHub");

            foreach (IBuildDetail build in builds)
            {
                var result = string.Format("Build {0}/{3} {4} - current status {1} - as of {2}",
                    build.BuildDefinition.Name,
                    build.Status.ToString(),
                    build.FinishTime,
                    build.LabelName,
                    Environment.NewLine);

                System.Console.WriteLine(result);
            }

            // Detailed via http://www.incyclesoftware.com/2012/09/fastest-way-to-get-list-of-builds-using-ibuildserver-querybuilds-2/

            var buildSpec = buildServer.CreateBuildDetailSpec("DrinkHub", "Main.Continuous");
            buildSpec.InformationTypes = null;
            var buildDetails = buildServer.QueryBuilds(buildSpec).Builds;

            Console.WriteLine(buildDetails.First().Status);

            Console.ReadLine();
        }
    }</pre>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1903.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb1044.png" width="590" height="415"></a> </p>
<p><strong>Wie funktioniert das mit der Authentifizierung?</strong></p>
<p>Im Grunde läuft die API immer unter den Credentials des Users – wenn man auf den Team Foundation Service zugreift wird automatisch der Microsoft Account genommen. OnPremise wird der Windows Account genommen.</p>
<p>Falls der angemeldete User nicht passt wird ein Authentifizierungsfenster angezeigt. Im Falle der Code läuft auf einem Server ist dies allerdings nicht gerade praktisch, daher kann man auch (wie im auskommentierten Teil des Codes sehen) direkt einen User angeben – das gilt sowohl für einen Microsoft Account als auch einen Windows Account.</p>
<p><strong>Fazit</strong></p>
<p>Ich war positiv überrascht wie schnell man an die Daten des TFS kommt – mal sehen was man mit der API noch machen kann.</p>
<p>Das komplette <a href="https://github.com/Code-Inside/Samples/tree/master/2013/TfsApi.Build"><strong>Projekt findet sich auch auf GitHub</strong></a>.</p>
