---
layout: post
title: "Warum man die Windows Azure VM Role (meistens) nicht braucht"
date: 2011-04-04 21:23
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [Azure, Cloud Computing, VM, Windows Azure]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image1239.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb419.png" width="165" height="155" /></a> </p>  <p>Für viele (und mich bis vor kurzem eingeschlossen) sind die Windows Azure Instanzen nur unzureichend Konfigurierbar. Man hat ein nacktes Windows + IIS und .NET Framework installiert. Wer andere Sachen machen will, muss die VM Role nehmen - so liesst man es meistens. Allerdings sind selbst die normalen Windows Azure Instanzen wesentlich Vielseitiger und häufig braucht man keine VM Role...</p>  <p><strong>Ich brauch Ruby, Java, Node.js auf Azure...</strong></p>  <p>Um es einfach zu sagen: Alles was man einfach auf einem Windows Server installieren kann, kann man auch auf einer regulären Azure Instanz zum Laufen bekommen. </p>  <p><strong>Geheimrezept: Software nachinstallieren</strong></p>  <p>Beim Starten einer Instanz kann man sowohl im Code darauf regieren, z.B. über den <a href="http://msdn.microsoft.com/en-us/library/microsoft.windowsazure.serviceruntime.roleentrypoint.aspx">RoleEntryPoint</a> oder über ein <a href="http://msdn.microsoft.com/en-us/library/gg456327.aspx">Startup CMD</a>:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d318738c-2496-4156-bcb6-4b63d0b6ef13" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;ServiceDefinition name="MyService" xmlns="http://schemas.microsoft.com/ServiceHosting/2008/10/ServiceDefinition"&gt;
   &lt;WebRole name="WebRole1"&gt;
      &lt;Startup&gt;
         &lt;Task commandLine="Startup.cmd" executionContext="limited" taskType="simple"&gt;
         &lt;/Task&gt;
      &lt;/Startup&gt;
   &lt;/WebRole&gt;
&lt;/ServiceDefinition&gt;</pre></div>

<p>Dadurch, dass der Startup Task einfach ein CMD aufruft kann man dort eigentlich alles machen. <a href="http://things.smarx.com/"><strong>Steven Marx hat eine Seite zusammengestellt</strong></a> (<a href="http://things.smarx.com/"><strong>http://things.smarx.com/</strong></a>), in dem er ein paar coole Beispiele zeigt, was man mit Azure machen kann:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1240.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb420.png" width="369" height="276" /></a> </p>

<p>Die Installscripts sehen zwar etwas... gewöhnungsbedürftig aus, aber einige nette Beispiele sind ja dabei. Hier z.B. wie man Phyton installiert:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c10b387a-124e-4a9f-9f28-b58d4045f786" class="wlWriterEditableSmartContent"><pre name="code" class="c#">cd %~dp0
for /f %%p in ('GetLocalPath.exe Python') do set PYTHONPATH=%%p

msiexec /i python-2.7.1.msi /qn TARGETDIR="%PYTHONPATH%" /log installPython.log

%PYTHONPATH%\python -c "import sys, os; sys.path.insert(0, os.path.abspath('setuptools-0.6c11-py2.7.egg')); from setuptools.command.easy_install import bootstrap; sys.exit(bootstrap())"
%PYTHONPATH%\scripts\easy_install Pygments-1.4-py2.7.egg

echo y| cacls %PYTHONPATH% /t /grant everyone:f

exit /b 0</pre></div>

<p>Der Trick besteht darin, die Installationsmedien einfach mit auf die Azure Instanz zu deployen und beim Starten zu installieren bzw. den Dienst anzumachen, z.B. im Falle von Node.js:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:febbd2b0-e3fa-4d97-b89b-1289d3c64d91" class="wlWriterEditableSmartContent"><pre name="code" class="c#">var proc = new Process()
{
    StartInfo = new ProcessStartInfo(
        RoleEnvironment.GetLocalResource("Executables").RootPath + @"\node.exe",
        string.Format("server.js {0}",
            RoleEnvironment.CurrentRoleInstance.InstanceEndpoints["HttpIn"].IPEndpoint.Port))
    {
        UseShellExecute = false,
        WorkingDirectory = RoleEnvironment.GetLocalResource("Executables").RootPath
    }
};</pre></div>

<p><strong>Vorteile dieser Variante</strong></p>

<p>Bei VM Roles muss man sich selber um das Updaten des Betriebssystem kümmern. Weiter unten ist noch ein Blogpost verlinkt, der auf die Punkte SLA, Statelessness und Updating genauer eingeht. Ob die Beispiele von der <a href="http://things.smarx.com/">Seite</a> Best Practices sind, kann ich allerdings nicht einschätzen - es scheint zu gehen und bevor man sich intensiver auf die VM Geschichte einschießt, sollte man diese Alternative kennen. </p>

<p><strong>Nachteile</strong></p>

<p>Komplexe Installationen dauern natürlich... und können auch fehlschlagen. Wenn der Fabric Controller die VM verschiebt, dann ist es ungünstig, wenn es lange dauert bestimmte VMs hochzufahren - in der Zeit stehen nicht die benötigten Ressourcen zur Verfügung. </p>

<p><strong>Fazit</strong></p>

<p>Wenn man keine "Standard”-Azure Komponenten verwenden kann oder zusätzliche Tools installieren muss, der kann das über diverse Wege auch mit regulären Windows Azure Instanzen machen - wenn die Anwendung zu komplex ist (z.B. ein Sharepoint / TFS), dann wird es natürlich wesentlich schwieriger bis unmöglich. Ein <a href="http://things.smarx.com/">Blick auf die Beispiele</a> hier geben aber einen netten Einblick. </p>

<p><u>Ein guter Blogpost darüber ist auch hier zu finden: </u></p>

<h4><a href="http://cloudythoughts.siadis.com/windows-azure/windows-azure-compute/when-to-deploy-a-vm-role-in-windows-azure">When to deploy a VM Role in Windows Azure?</a></h4>
