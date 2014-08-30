---
layout: post
title: "HowTo: MSDeploy & MSBuild"
date: 2010-11-11 00:21
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, MSBuild, MSDeploy]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image1093.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb275.png" width="139" height="120" /></a> </p>  <p>In meinen <a href="{{BASE_PATH}}/2010/11/04/howto-web-config-transformations-mit-msbuid/">letzten Blogpost</a> beschrieb ich, was man mit MSBuild anstellen kann. Mit MSBuild kann man auch mit ein paar Tricks ein nettes Deployment Package zusammenbauen. Microsoft hat mit dem Release von VS2010 ein neues Tool ins rennen geschickt: MSDeploy. In dem Blogpost geht es darum, was MSDeploy ist und wie man es mit MSBuild zusammen einsetzen kann.</p> <!--more-->  <p><strong>Big Picture von MSDeploy</strong></p>  <p>Beginnen wir kurz mit dem großen Bild von MSDeploy. Ziel ist es ein Deployment Package zusammen zu bauen um das Ausliefern der Software zu vereinfachen. Dafür gibt es diverse Provider, welche z.B. die Datenbank oder die eigentlichen ASP.NET Files in ein Package zusammen packt. Dieses Package kann man dann über MSDeploy recht einfach publishen. Dabei muss auf dem Server ebenfalls MSDeploy installiert sein. </p>  <p>Ich verweise an diese Stelle auf den <a href="http://weblogs.asp.net/scottgu/archive/2010/09/13/automating-deployment-with-microsoft-web-deploy.aspx">Blogpost von ScottGu</a> sowie den <a href="http://vishaljoshi.blogspot.com/2009/03/how-does-web-deployment-with-vs-10.html">Blog von Vishal Joshi</a> (gefühlt ist es DER Entwickler hinter MSDeploy).</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1094.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb276.png" width="499" height="393" /></a> </p>  <p>Der Reiz an MSDeploy: Es ist recht einfach neue Updates einzuspielen. Das kann z.B. von der Entwicklermaschine mit Visual Studio sein oder ein Buildserver über ein Buildscript.</p>  <p><strong>MSDeploy auf dem Server</strong></p>  <p>Über den Web Platform Installer lässt sich MSDeploy installieren (<a href="http://weblogs.asp.net/scottgu/archive/2010/09/13/automating-deployment-with-microsoft-web-deploy.aspx">siehe ScottGus Post</a>). Wichtig ist noch: Die Port von MSDeploy muss auch in der Firewall freigeschalten werden. Alle anderen Details erfahrt ihr entweder in ScottGus Post oder auf IIS.NET <a href="http://www.iis.net/download/webdeploy">hier</a>, <a href="http://learn.iis.net/page.aspx/421/installing-web-deploy/">hier</a> und <a href="http://learn.iis.net/page.aspx/516/configure-the-web-deployment-handler/">hier</a>.</p>  <p><strong>Meine bisherigen Deployansätze</strong></p>  <p>Bislang hatte ich über MSBuild eine Solution gebaut und das "_PublishedWebsites” Verzeichnis genutzt. Im letzten <a href="{{BASE_PATH}}/2010/11/04/howto-web-config-transformations-mit-msbuid/">Blogpost ging es ja dann um die Web.config Transformierung</a>. Allerdings geht das alles auch etwas eleganter. </p>  <p>MSDeploy ist momentan auf Webanwendungen ausgelegt. Daher muss man sich über das Deployment und Packaging von Windows Services etc. trotzdem noch Gedanken machen ;) </p>  <p><strong>Einfaches Beispiel</strong></p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1095.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb277.png" width="219" height="244" /></a> </p>  <p>In meinem einfachen Beispiel habe ich eine MVC WebApp und diese möchte ich nun in ein Deployment Package haben.</p>  <p>Variante A) Man macht alles über Visual Studio. Rechtsklick auf das Projekt und dann "Build Deployment Package”. Wenn man alleine vor sich hinwerkelt geht das noch. Ich finde allerdings man sollte wenigstens ein Build auch scriptgesteuert aufrufen können. Spätestens wenn man ein Buildserver einsetzen möchte führt kein Weg daran vorbei. </p>  <p>Daher Variante b) Wir schreiben uns ein kleines MSBuild Script. Der OutPut wird am Ende identisch mit der Variante A sein - nur dass wir es in ein Script ausgelagert haben.</p>  <p>In den Deployment Settings können wir noch die IIS Settings vordefinieren:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1096.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb278.png" width="485" height="325" /></a> </p>  <p>Diese Angaben können aber auch über Parameter später gesetzt werden. Wir gehen mal davon aus, dass diese Wert in diesen Settings gesetzt werden. Die Seite die ich dort angebe sollte im IIS auf dem Zielrechner auch schon angelegt sein. Ich bin mir jetzt nicht sicher was passiert, wenn diese nicht da ist ;)</p>  <p>Jetzt zum eigentlichen Script.</p>  <p><strong>Build.targets</strong></p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:149fb331-dd53-43b8-98b9-4c6cede97d10" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003" DefaultTargets="Run"&gt;
&lt;Import Project="$(MSBuildExtensionsPath)\Microsoft\VisualStudio\v10.0\WebApplications\Microsoft.WebApplication.targets" /&gt;
   &lt;PropertyGroup&gt;
	&lt;OutDir&gt;$(MSBuildStartupDirectory)\OutDir\&lt;/OutDir&gt;
   &lt;/PropertyGroup&gt;
	&lt;Target Name="Run"&gt;
	&lt;Message Text="Run called." /&gt;
			&lt;MSBuild Projects="MSDeployMSBuild.Web\MSDeployMSBuild.Web.csproj"
            Targets="Package"
			Properties="PackageLocation=$(OutDir)\MSDeploy\Package.zip;
						_PackageTempDir=C:\Temp\Web"/&gt;
	&lt;/Target&gt;

&lt;/Project&gt;
 </pre></div>

<p>Am wichtigsten ist hier eigentlich Zeile 8. Hier rufe ich das Package Target auf. Damit wird MSDeploy angestoßen und es wird auch automatisch eine Web.config Transformation durchgeführt. Als Property geb ich noch die PackageLocation mit sowie eine Hilfe Variable namens "_PackageTempDir”.</p>

<p>Als Ergebnis kommt sowas raus eines "Build Deployment Packge” oder von diesem MSBuild kommt sowas raus:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1097.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb279.png" width="223" height="151" /></a></p>

<p>Wenn man jetzt das _PackageTempDir nicht setzt steht in der Package.SourceManifest.xml allerdings der komplette Pfad aus dem gebaut wurde. Das will ich nicht und darum setz ich dort einen x-beliebigen anderen ein. Dieser Pfad scheint auch keine Auswirkung auf das Deployment später zu haben. Es sieht meiner Meinung nach aber etwas komisch aus ;)</p>

<p><strong>Wenn man nicht direkt das Projekt bauen will, sondern die Solution:</strong></p>

<p>In den vergangen Blogposts habe ich immer die gesamte Solution gebaut. Das geht auch, dafür muss man bei der Solution diese Parameter mitgeben:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:736ace6f-0a21-4ad4-878d-bdb0b634cca8" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;Solution Include="$(BuildDirFullName)Source\BusinessBingo\BusinessBingo.sln"&gt;
	&lt;Properties&gt;	
		OutDir=$(OutDir);
      	Platform=Any CPU;
     	Configuration=Release;
      	DeployOnBuild=True;
      	DeployTarget=Package;
      	PackageLocation=$(OutDir)\MSDeploy\Package.zip;
      	_PackageTempDir=C:\Temp\Web
	&lt;/Properties&gt;
&lt;/Solution&gt;</pre></div>

<p>&#160; <strong>Deployment durchführen</strong></p>

<p>Ruft man einfach so die "MSDeployMSBuild.Web.deploy.cmd” einfach so auf, dann wird die ReadMe angezeigt, denn es fehlen noch Daten: Wohin soll den überhaupt etwas deployt werden? </p>

<p>Als Beispiel wie ein Aufruf aussehen kann:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:26c6d4c4-5337-481c-9d01-d5097f7f8d53" class="wlWriterEditableSmartContent"><pre name="code" class="c#">Package.deploy.cmd /Y /M:http://SERVER_NAME/MSDeployAgentService /U:USERDATEN /P:PASSWORT</pre></div>

<p>Nun wird versucht das Package auf der eingestellten IIS Seite auf dem Server "SERVER_NAME” zu deployen. Über den Schalter /Y wird das Deployment durchgeführt. Nimmt man statt /Y das /T kann man einen testlauf machen - hierbei werden die Daten noch nicht übertragen.</p>

<p><strong>Fazit</strong></p>

<p>Mit wenigen Handgriffen kann man die Visual Studio Funktionalität aucch in ein Buildscript gießen. MSDeploy ist ein großes Thema. Ich will daher auch nicht ausschließen dass hier alles korrekt wiedergegeben ist - so jedenfalls hat es bei mir funktioniert :)</p>

<p><strong><a href="{{BASE_PATH}}/assets/files/democode/msdeploymsbuild/msdeploymsbuild.zip">[ Download Democode ]</a></strong></p>
