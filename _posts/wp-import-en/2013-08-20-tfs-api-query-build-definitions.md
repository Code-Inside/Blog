---
layout: post
title: "TFS API: Query Build-Definitions"
date: 2013-08-20 21:45
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
<p>The Team Foundation Server offers On-Premise and as <a href="{{BASE_PATH}}/2012/11/05/team-foundation-service-ein-erster-blick-auf-den-tfs-in-der-cloud/">„Cloud-TFS“ (Team Foundation Server) (German-Blogpost)</a> several services (Build, WorkItems, Source Control,…). Those services are easy to use with the help of .NET APIs.  <p>In this blogpost I try to call the last build results of a team-project. <p><b>Required assemblies</b> <p><b></b> <p>To request a build you won’t need all five assemblies but still you might need some of them sooner or later. You will find them in the visual studio installation directive <em>(C:/Program Files (x86)/Microsoft Visual Studio 11.0/Common7/IDE/ReferenceAssemblies/v2.0-for VS 2012).</em> You can copy them and integrate them in your own solution. <p>Here is the list of assemblies: <p>- Microsoft.TeamFoundation.Client.dll<br>- Microsoft.TeamFoundation.Common.dll<br>- Microsoft.TeamFoundation.VersionControl.Client.dll<br>- Microsoft.TeamFoundation.Build.Common.dll<br>- Microsoft.TeamFoundation.Build.Client.dll <p><b>Attention: You need to activate “Enable 32bit applications” in the IIS AppPool (if you want to use it with a WebApp). </b>It seems like the assemblies are at least partly 32bit assemblies because it just wouldn’t work without this adjustment. <p><b>Demo Code:</b> <p><b></b> <p>Over the API I access the Team Foundation Service</p> <div id="scid:9D7513F9-C04C-4721-824A-2B34F0212519:4d639fcd-d75d-4a32-8759-faa24ce476a0" class="wlWriterEditableSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre style="background-color:White;overflow: auto;"><div><!--

Code highlighting produced by Actipro CodeHighlighter (freeware)
http://www.CodeHighlighter.com/

--><span style="color: #0000FF;">class</span><span style="color: #000000;"> Program
    {
        </span><span style="color: #0000FF;">static</span><span style="color: #000000;"> </span><span style="color: #0000FF;">void</span><span style="color: #000000;"> Main(</span><span style="color: #0000FF;">string</span><span style="color: #000000;">[] args)
        {
            </span><span style="color: #008000;">//</span><span style="color: #008000;"> Auth with UserName &amp; Password (Microsoft Acc):
            </span><span style="color: #008000;">//</span><span style="color: #008000;">BasicAuthCredential basicCred = new BasicAuthCredential(new NetworkCredential(&quot;xxx@hotmail.com&quot;, &quot;pw&quot;));
            </span><span style="color: #008000;">//</span><span style="color: #008000;">TfsClientCredentials tfsCred = new TfsClientCredentials(basicCred);
            </span><span style="color: #008000;">//</span><span style="color: #008000;">tfsCred.AllowInteractive = false;
            </span><span style="color: #008000;">//</span><span style="color: #008000;">
            </span><span style="color: #008000;">//</span><span style="color: #008000;">TfsTeamProjectCollection tfs = new TfsTeamProjectCollection(new Uri(&quot;</span><span style="color: #008000; text-decoration: underline;">https://code-inside.visualstudio.com/DefaultCollection</span><span style="color: #008000;">&quot;), tfsCred);</span><span style="color: #008000;">
</span><span style="color: #000000;">
            TfsTeamProjectCollection tfs </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #0000FF;">new</span><span style="color: #000000;"> TfsTeamProjectCollection(</span><span style="color: #0000FF;">new</span><span style="color: #000000;"> Uri(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">https://code-inside.visualstudio.com/DefaultCollection</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">));

            IBuildServer buildServer </span><span style="color: #000000;">=</span><span style="color: #000000;"> (IBuildServer)tfs.GetService(</span><span style="color: #0000FF;">typeof</span><span style="color: #000000;">(IBuildServer));

            var builds </span><span style="color: #000000;">=</span><span style="color: #000000;"> buildServer.QueryBuilds(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">DrinkHub</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);

            </span><span style="color: #0000FF;">foreach</span><span style="color: #000000;"> (IBuildDetail build </span><span style="color: #0000FF;">in</span><span style="color: #000000;"> builds)
            {
                var result </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #0000FF;">string</span><span style="color: #000000;">.Format(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">Build {0}/{3} {4} - current status {1} - as of {2}</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">,
                    build.BuildDefinition.Name,
                    build.Status.ToString(),
                    build.FinishTime,
                    build.LabelName,
                    Environment.NewLine);

                System.Console.WriteLine(result);
            }

            </span><span style="color: #008000;">//</span><span style="color: #008000;"> Detailed via </span><span style="color: #008000; text-decoration: underline;">http://www.incyclesoftware.com/2012/09/fastest-way-to-get-list-of-builds-using-ibuildserver-querybuilds-2/</span><span style="color: #008000;">
</span><span style="color: #000000;">
            var buildSpec </span><span style="color: #000000;">=</span><span style="color: #000000;"> buildServer.CreateBuildDetailSpec(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">DrinkHub</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">, </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">Main.Continuous</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
            buildSpec.InformationTypes </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #0000FF;">null</span><span style="color: #000000;">;
            var buildDetails </span><span style="color: #000000;">=</span><span style="color: #000000;"> buildServer.QueryBuilds(buildSpec).Builds;

            Console.WriteLine(buildDetails.First().Status);

            Console.ReadLine();
        }
    }</span></div></pre><!-- Code inserted with Steve Dunn's Windows Live Writer Code Formatter Plugin.  http://dunnhq.com --></div>
<p><img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; padding-right: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1044.png" width="590" height="415" /></p>
<p><b>How does the authentication work?</b></p>

<p>Basically the API runs all the time in the credentials of the users – if you access the team foundation service the Microsoft account is chosen by default. OnPremise the Windows account will be activated.
<p>If the currently logged user doesn’t match an authentication windows will be opened. If the code runs on a server this might be a problem so it is better to directly choose a user (like you can see on the code above) – this works for Microsoft and Windows accounts. 
<p><b>Result</b></p>
I was positively surprised about how easy you can access the TFS information’s – let’s see what else you can do with the API. <a href="https://github.com/Code-Inside/Samples/tree/master/2013/TfsApi.Build">The whole project is available on <strong>GitHub</strong>.</a>
