---
layout: post
title: "HowTo: Web.config Transformations mit MSBuild"
date: 2010-11-04 00:52
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [HowTo, MSBuild, web.config, XmlTransformation]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1089.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; margin: 0px 10px 0px 0px; display: inline; border-top-width: 0px" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb271.png" width="90" height="131"></a> Mit ASP.NET 4.0 kam ein neues Feature namens "<a href="http://blogs.msdn.com/b/webdevtools/archive/2009/05/04/web-deployment-web-config-transformation.aspx">Web.config Tranformations</a>”. In meinen vergangenen MSBuild Posts habe ich gezeigt, wie man über pures MSBuild z.B. eine Solution mit einem Web-Projekt baut. Im Standardfall wird die web.config Transformation nicht getriggert und die WebApp läuft im Debug Mode (was schlecht ist!). Daher müssen wir es manuell im MSBuild antriggern.</p> <p></p><!--more--><p></p> <p><strong></strong>&nbsp;</p> <p><strong>[Update] Mit Visual Studio 2012 wird alles besser:</strong></p> <p>Der Aufruf von TransformXml war zu Visual Studio 2010 Zeiten ziemlich haarig, da es der Task ein Lock auf die Files behalten hatte. Mit VS 2012 sollte dieser Bug behoben werden. D.h. ein mühsames kopieren und renaming ist nicht mehr nötig.</p> <p><strong>Wie der Output bis jetzt aussah</strong></p> <p>Wenn man sich an <a href="{{BASE_PATH}}/2010/09/30/howto-mit-msbuild-solutions-bauen/">diesen Post hält</a>, sollte ein _PublishedWebsites Ordner erstellt werden und dort findet man entsprechend die WebApp. Allerdings auch die Transformations-Files:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1090.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; display: inline; border-top-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb272.png" width="244" height="226"></a></p> <p>Das große Problem dabei: Die Transformation der eigentlich Web.config fand nicht statt - die Anwendung läuft unter debug:</p> <div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:62018c73-fd98-4723-a1d2-5abfbf967cb9" class="wlWriterSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre class="c#" name="code">    &lt;compilation debug="true" targetFramework="4.0"&gt;</pre></div>
<p><strong>XmlTransfrom</strong></p>
<p>Es gibt allerdings ein Task für MSBuild, dazu muss man diese Targets importieren:</p>
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:17347b5d-4fe5-4e09-aab0-6d72b0eb430b" class="wlWriterSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre class="c#" name="code">&lt;Import Project="$(MSBuildExtensionsPath)\Microsoft\VisualStudio\v10.0\WebApplications\Microsoft.WebApplication.targets" /&gt;</pre></div>
<p>Und dann kann der Aufruf wie folgt aussehen:</p>
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:df45e18b-9308-4913-8298-b07b08f14003" class="wlWriterSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre class="c#" name="code">	&lt;TransformXml Source="Web.config"
				  Transform="Web.Release.config"
				  Destination="Web.transformed.config" /&gt;
</pre></div>
<p><strong>ABER: So ists es ja auch doof, oder?</strong></p>
<p>Am Ende möchte ich ja dass die transformierte Datei wieder "Web.config” heisst. Das Problem: TransformXml ist buggy. Während des Bauens hält der Task einen <a href="http://connect.microsoft.com/VisualStudio/feedback/details/562200/transformxml-task-locks-config-file-identified-in-source-attribute">lock auf die 3 Files</a>. Zudem: Wir wollen ja unser eigentliches Web.config File, welches in unserer Solution nicht abändern. Daher legen wir eine vollständige Kopie unserer Sourcen an und verändern diese.</p>
<p><strong>Schema:</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1091.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; display: inline; border-top-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb273.png" width="501" height="79"></a></p>
<p><strong>CopySource:</strong></p>
<p>Wir kopieren unsere gesamten Sourcen an einen anderen Ort, z.B. einen Ordner höher in ein eigenes Verzeichnis. Ich hab es "ClientTemp” genannt.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1092.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; display: inline; border-top-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb274.png" width="244" height="232"></a></p>
<p><strong>BeforeCompile:</strong></p>
<p>Hier in dem BeforeCompile Target könnte ich nun an den Kopien, welche im ClientTemp sind, Manipulationen machen z.B. beim Aufruf die AssemblyVersion verändern. An der Stelle ruf ich aber auch den TransformXml Task auf:</p>
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a4fb0c18-82f7-442d-9cbf-a902f2b300a5" class="wlWriterSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre class="c#" name="code">	&lt;TransformXml Source="..\MsBuildSample.WebApp\Web.config"
				  Transform="..\MsBuildSample.WebApp\Web.$(Configuration).config"
				  Destination="$(BuildDirFullName)MsBuildSample.WebApp\Web.config" /&gt;

</pre></div>
<p>Source &amp; Transform kommen aus dem Originalen Zweig - daher stört mich dort der lock nicht mehr. Nur die Destination liegt nun in unserem "geklonten” Ordner. Danach ist die "Web.config” tranformiert.</p>
<p><strong>Build:</strong></p>
<p>Hier wird nun der eigentliche Buildvorgang aufgerufen das Standardverhalten setzt ein und baut die Solution und verschiebt die WebApp in das _PublishedWebsites OutDir.</p>
<p><strong>...</strong></p>
<p>Hier danach können noch irgendwelche anderen Aktionen erfolgen. Ich entfern aus dem OutDir noch die nicht benutzen Transformationsdatein (web.release.config / web.debug.config).</p>
<p><strong>Fazit</strong></p>
<p>Es ist ein klein wenig komplizierter geworden, allerdings hat diese Struktur den Vorteil, dass ich während des Buildvorganges (und vor dem Compile) nun munter am Code rumbasteln kann und meinen eigentlichen Source Code daher nicht verändere. Es erinnert mich ein wenig (ganz, ganz grob) an die Funktionsweise eines TFS ;)</p>
<p><strong>Komplettes Buildscript:</strong></p>
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:dc893444-849f-442f-ae9a-09cf95a0be1b" class="wlWriterSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre class="c#" name="code">&lt;Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003" DefaultTargets="Run"&gt;
&lt;Import Project="$(MSBuildStartupDirectory)\Lib\MSBuild.Community.Tasks.Targets"/&gt;
&lt;Import Project="$(MSBuildExtensionsPath)\Microsoft\VisualStudio\v10.0\WebApplications\Microsoft.WebApplication.targets" /&gt;
   &lt;PropertyGroup&gt;
	&lt;!-- After Compile: Result will be saved in OutDir --&gt;
		&lt;OutDir&gt;$(MSBuildStartupDirectory)\..\..\ClientTemp\OutDir\&lt;/OutDir&gt;
	
	&lt;!-- Name of the BuildDir with the whole source code before the compile begins --&gt;
		&lt;BuildDirName&gt;BuildDir&lt;/BuildDirName&gt;
	
	&lt;!-- Relativ part of the BuildDir --&gt;
	&lt;BuildDirRelativePart&gt;..\..\ClientTemp\$(BuildDirName)&lt;/BuildDirRelativePart&gt;
	
	&lt;!-- Absolute part of the BuildDir--&gt;
	&lt;BuildDirFullName&gt;$(MSBuildStartupDirectory)\$(BuildDirRelativePart)\&lt;/BuildDirFullName&gt;
	
	&lt;!-- Configuration --&gt;
	&lt;Configuration&gt;Release&lt;/Configuration&gt;
	
	&lt;!-- Solutionproperties--&gt;
		&lt;SolutionProperties&gt;
			OutDir=$(OutDir);
			Platform=Any CPU;
			Configuration=$(Configuration)
		&lt;/SolutionProperties&gt;
   &lt;/PropertyGroup&gt;
	&lt;ItemGroup&gt;
		&lt;Solution Include="$(BuildDirFullName)MsBuildSample.sln"&gt;
			&lt;Properties&gt;
				$(SolutionProperties)
			&lt;/Properties&gt;
		&lt;/Solution&gt;
	&lt;/ItemGroup&gt;
	&lt;Target Name="Run"&gt;
	&lt;Message Text="Run called." /&gt;
	
	&lt;CallTarget Targets="CopyToBuildDir" /&gt;
	&lt;CallTarget Targets="BeforeBuild" /&gt;
	&lt;CallTarget Targets="Build" /&gt;
	&lt;CallTarget Targets="Cleanup" /&gt;
	&lt;CallTarget Targets="Zip" /&gt;
  &lt;/Target&gt;
  &lt;Target Name="CopyToBuildDir"&gt;
	&lt;Message Text="CopyToBuildDir called." /&gt;
	&lt;Exec Command="robocopy .. $(BuildDirRelativePart) /s /z /purge /a-:r" ContinueOnError="true" /&gt;
  &lt;/Target&gt;
	&lt;Target Name="BeforeBuild"&gt;
	&lt;Message Text="BeforeBuild called." /&gt;


	&lt;Message Text="Transform Xml" /&gt;
	&lt;TransformXml Source="..\MsBuildSample.WebApp\Web.config"
									Transform="..\MsBuildSample.WebApp\Web.$(Configuration).config"
									Destination="$(BuildDirFullName)MsBuildSample.WebApp\Web.config" /&gt;
  &lt;/Target&gt;

  &lt;Target Name="Build"&gt;
	&lt;Message Text="Build called." /&gt;
	&lt;MSBuild Projects="@(Solution)"/&gt;
	&lt;/Target&gt;

	&lt;Target Name="Cleanup"&gt;
		&lt;Delete Files="$(OutDir)_PublishedWebsites\MsBuildSample.WebApp\Web.Release.config" /&gt;
		&lt;Delete Files="$(OutDir)_PublishedWebsites\MsBuildSample.WebApp\Web.Debug.config" /&gt;
		
	&lt;/Target&gt;
  &lt;ItemGroup&gt;
	&lt;ZipFiles Include="$(OutDir)_PublishedWebsites\**\*.*" /&gt;
  &lt;/ItemGroup&gt;
  &lt;Target Name="Zip"&gt;
	&lt;Zip Files="@(ZipFiles)"
			 WorkingDirectory="$(OutDir)_PublishedWebsites\"
			 ZipFileName="$(OutDir)Package.zip"/&gt;
  &lt;/Target&gt;
&lt;/Project&gt;
 </pre></div>
<p><strong>Democode</strong></p>
<p>In meiner Demosolution arbeite ich mit ein paar Hilfsvariablen im MSBuild - davon nicht abschrecken lassen. Wenn ihr den SampleCode auf:</p>
<p>D:\Samples\MsBuildSample ablegt findet Ihr das "BuildVerzeichnis” in D:\Samples\ClientTemp</p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/msbuildsamplexmltransform/msbuildsamplexmltransform.zip">[ Download Democode ]</a></strong></p>
