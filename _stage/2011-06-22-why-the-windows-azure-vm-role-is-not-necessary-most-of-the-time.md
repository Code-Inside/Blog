---
layout: post
title: "Why the Windows Azure VM Role is not necessary (most of the time)"
date: 2011-06-22 10:38
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: [Windows Azure]
language: en
---
{% include JB/setup %}
<p>&#160;</p>  <p><b></b></p>  <p><a href="{{BASE_PATH}}/assets/wp-images-en/image158.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb66.png" width="165" height="155" /></a>For many people (including me till today) the windows azure instances are insufficient configurable. You have installed a naked Windows + IIS and .NET Framework. If you want to do anything else you have to use VM Role – that’s what you here. But in fact also the normal Windows Azure instances are much more versatile and most of the time you don’t need VM Role...</p>  <p>&#160;</p><!--more--><p><b>I need Ruby, Java, Node.js on Azure.... </b></p>  <p><b></b></p>  <p>To say it short: Everything you are able to install on a regular Windows Server you are able to install on a regular Azure Instance.</p>  <p><b>Secret tip: preinstall Software</b></p>  <p><b></b></p>  <p>After the start of an instance you are able to govern a Code on it like for example on the <a href="http://msdn.microsoft.com/en-us/library/microsoft.windowsazure.serviceruntime.roleentrypoint.aspx">RoleEntryPoint</a> or the <a href="http://msdn.microsoft.com/en-us/library/gg456327.aspx">Startup CMD</a>:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:4ba220bb-998f-4db1-9ae2-f300da619a0b" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;ServiceDefinition name="MyService" xmlns="http://schemas.microsoft.com/ServiceHosting/2008/10/ServiceDefinition"&gt;
   &lt;WebRole name="WebRole1"&gt;
      &lt;Startup&gt;
         &lt;Task commandLine="Startup.cmd" executionContext="limited" taskType="simple"&gt;
         &lt;/Task&gt;
      &lt;/Startup&gt;
   &lt;/WebRole&gt;
&lt;/ServiceDefinition&gt;</pre></div>

<p>Because the Startup Task calls a simple CMD you can do almost everything on it. <a href="http://things.smarx.com/">Steven Marx has created a cool website</a> where he collects many interesting things about what you can do with Aure:</p>

<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb420.png" width="369" height="276" /></p>

<p>The Installscripts look a little bit ... different but there are some nice examples like: how to install Phyton:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b25ea570-e8ee-4070-bd60-730240fbfcd7" class="wlWriterEditableSmartContent"><pre name="code" class="c#">cd %~dp0
for /f %%p in ('GetLocalPath.exe Python') do set PYTHONPATH=%%p

msiexec /i python-2.7.1.msi /qn TARGETDIR="%PYTHONPATH%" /log installPython.log

%PYTHONPATH%\python -c "import sys, os; sys.path.insert(0, os.path.abspath('setuptools-0.6c11-py2.7.egg')); from setuptools.command.easy_install import bootstrap; sys.exit(bootstrap())"
%PYTHONPATH%\scripts\easy_install Pygments-1.4-py2.7.egg

echo y| cacls %PYTHONPATH% /t /grant everyone:f

exit /b 0</pre></div>

<p>The trick is to deploy the installation Medias into the Azure Instance and to install it while starting the service like in this case of Node.js:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c79721b4-40c8-4f51-a5d5-500ae0039afd" class="wlWriterEditableSmartContent"><pre name="code" class="c#">var proc = new Process()
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

<p><b>Advantages of this method</b></p>

<p>At VM Role you have to take care about the update of your system software by yourself. Take a look on this Blogpost where you can read more about SLA, Statelessmess and Updating. In Fact I can’t promise to you if the examples on this side are Best Practices. It seems like it works and before you are too much into the VM thing it might be good to know your opportunities.</p>

<p><b>Disadvantages</b></p>

<p>Of course difficult installations takes there time... and they can fall through. If the Fabric Controller adjusts the VM it’s not good if it takes a long time to boot specific VMs – in this time you can’t use the needed resources. </p>

<p><b>Result</b></p>

<p>If you don’t use standard Azure components or install more Tools you can do it on several ways with the regular Windows Azure instance – but if the application is more complex (Sharepoint / TFS) it will be more difficult and maybe unsolvable. A view on <a href="http://things.smarx.com/">these examples</a> will show you more about this.</p>
