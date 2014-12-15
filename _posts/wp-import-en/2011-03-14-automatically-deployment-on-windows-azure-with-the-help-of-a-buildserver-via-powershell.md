---
layout: post
title: "Automatically deployment on windows azure with the help of a buildserver via powershell"
date: 2011-03-14 11:47
author: CI Team
comments: true
categories: [Uncategorized]
tags: [Powershell, Windows Azure]
language: en
---
{% include JB/setup %}

  
  <p><a href="{{BASE_PATH}}/assets/wp-images-en/image136.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb44.png" width="150" height="102" /></a>During my last blogposts I´ve already talked about using TeamCity as a Buildserver. Because of we are using <a href="http://www.microsoft.com/windowsazure/">Windows Azure</a> in our <a href="http://www.bizzbingo.com/">BizzBingo</a> project the subject for today is how to create automatically new deploymnts on Azure - it´s easier than you might think <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile15.png" /></p>  
  
  <p><b>"Visual Studio Deployment" == Fail!</b></p>
<p><strong></strong></p>  
  <p>If you create a windows azure project Visual Studio offers you the opportunity to create a deployment:</p>
<p>T<img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb373.png" width="510" height="202" /></p>
<p>hat´s nice for the first step of the developing process and I won´t miss it. But if you are developing software and try to build your Build- and Deploymentprocess only on your local Machine with Visual Studio should start to think about his profession <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile15.png" /></p>
<p><b>Architecture </b></p>  
  <p>It´s possible to have more than one developer working on a source control system like for example TFS or SVN or Git etc. A buildsystem, like TeamCity in my example, looks after the actuall Sources and build them in intervalls or whenever you nudge it manual. But because of BizzBingo is an open source I need to source out the sensitive information´s. After we finished building the project it will be deployed into the staging surroundings by Azure. After that the staging surroundings is "swapt" into the production surroundings to keep the processes going (at least no Downtime is the goal!)</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image137.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb45.png" width="482" height="293" /></a></p>
<p>Which part you want to run automatically is, of course, your own decision. Maybe you prefer to deploy just on the staging surroundings or directly on the production surroundings - doesn´t matter. </p>
<p>As an extra you are able to run test on the staging surroundings (Selenium, UI Tests and so on) and then something happens. But I´ve used the easier way because <a href="http://www.bizzbingo.com/">BizzBingo</a> is just a hobby <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-smile" alt="Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-smile7.png" /></p>
<p><b>Requirements</b></p>  
  <p>For the next step I assume you have an installed TeamCity ad a Code Repository (TFS/SVN etc.). TeamCity should be able in some way to take the sources. Of course, the usage of Teamcity is optional. It´s also possible to do it local or with another system (TFS Teambuild, classic MSBuild). For Windows Azure it´s necessary to have account information´s. Important Information´s:</p>
<p>- Servicename</p>
<p>- Subscription Key</p>  
  <p><b>Windows Azure Management Cmdlets for automation </b></p>  
  <p>Round about the management for Windows Azure Microsoft offers a <a href="http://msdn.microsoft.com/en-us/library/ee460799.aspx">REST surface</a>. But in fact, it´s a bit exhausting to use the API directly. From Microsoft too (and maybe from other volunteers, it´s open source) there is an <a href="http://archive.msdn.microsoft.com/azurecmdlets">Azure Management Cmdlets</a> available (Powershell!). </p>
<p>The following software should be installed:</p>
<p>- Newest <a href="http://msdn.microsoft.com/en-us/library/dd179367.aspx">Windows Azure SDK</a> (1.3)</p>
<p>- <a href="http://archive.msdn.microsoft.com/azurecmdlets">Azure Management Cmdlets</a></p>
<p>- Powershell (since Win7/WinServer2008 it´s included automatically) </p>
<p><u></u></p>
<p><u>Installation of Azure Management Cmdlets</u></p>
<p><u></u></p>
<p>It´s possible that there are some problems appearing during the installation. The installation routine is used to check the Azure SDK Version quite strict. After the last security update the version number has been increased. But it´s possible to adjust the check in this file:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:bbac6a97-e3af-443e-af1a-5659829b88a6" class="wlWriterEditableSmartContent"><pre name="code" class="c#">C:\WASMCmdlets\setup\scripts\dependencies\check\CheckAzureSDK.ps1</pre></div>

<p>Here are two lines with the exact SDK version:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:145c16de-af6a-449a-8e02-9a9e153ec447" class="wlWriterEditableSmartContent"><pre name="code" class="c#">$res1 = SearchUninstall -SearchFor 'Windows Azure SDK*' -SearchVersion '1.3.20121.1237' -UninstallKey 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\';
$res2 = SearchUninstall -SearchFor 'Windows Azure SDK*' -SearchVersion '1.3.20121.1237' -UninstallKey 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\';
</pre></div>

<p>With every security update the version number changes - for me, I entered the Version "1.3.20121.1237" manual. It works, at least for me and the installer runs successfully after that. </p>

<p><b>Management certificate </b></p>




<p>A quotation of <a href="http://www.davidaiken.com/2009/12/21/how-to-create-a-x509-certificate-for-the-windows-azure-management-api/">David Aiken</a>:</p>

<p>1. Load the IIS 7 management console. I´m assuming here you have IIS7 installed since its required for the Windows Azure SDK.</p>

<p>2. Click on your Server.</p>

<p>3. Double Click Server Certificates in the IIS Section in the main panel.</p>

<p>4. Click Create Self-Signed Certificate... in the Actions panel.</p>

<p>5. Give it a Friendly Name.</p>

<p>6. Close IIS Manager.</p>

<p>7. Open Certificate Manager (Start-&gt;Run-&gt;certmgr.msc)</p>

<p>8. Open Trusted Root Certification Authorities, then Certificates.</p>

<p>9. Look for your certificate (Tip: Look in the Friendly Name column).</p>

<p>10. Right Click your certificate, then choose All Tasks, then Export...</p>

<p>11. In the Wizard, choose No, do not export the private key, then choose the DER file format.</p>

<p>12. Give your cert a name. (remember to call it something.cer).</p>

<p>13. Navigate to the Windows Azure Portal - <a href="http://windows.azure.com/">http://windows.azure.com</a></p>

<p>An other way to create the certificate "<a href="http://msdn.microsoft.com/en-us/library/bfsktky3(v=vs.80).aspx">makecert</a>":</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:9b0d363a-3cd2-40f0-895c-67e825f30bea" class="wlWriterEditableSmartContent"><pre name="code" class="c#">makecert -r -pe -a sha1 -n "CN=Windows Azure Authentication Certificate" -ss My -len 2048 -sp "Microsoft Enhanced RSA and AES Cryptographic Provider" -sy 24 testcert.cer</pre></div>

<p>In Windows the tool is located at: SDK: C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\Bin</p>

<p>Doesn´t matter which way you choose - you need it from somewhere <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-smile" alt="Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-smile7.png" /></p>

<p>Now you are able to add the certificate in "Management Certificates":</p>

<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb375.png" width="507" height="161" /><b></b></p>

<p><b>TeamCity Build</b></p>




<p>Now we talk about the Buildprocess. The most important step is to open MSBuild. The step I´ve made before isn´t important for the Azure Deployment. </p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image138.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb46.png" width="533" height="145" /></a></p>

<p>In Detail:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image139.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb47.png" width="479" height="347" /></a></p>

<p>In this step the MSBuild script should be opened and you will find it here: </p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:24f6b2b0-f2d9-405b-addb-aef870e0dff4" class="wlWriterEditableSmartContent"><pre name="code" class="c#">%system.teamcity.build.checkoutDir%\Main\Build\CommonBuildSteps.targets</pre></div>

<p>In <a href="http://businessbingo.codeplex.com/">TFS</a> it´s here:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image140.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb48.png" width="411" height="151" /></a></p>

<p>It´s also important to define the Working Directory to navigate in MSBuild.</p>

<p><b>Beware</b>: MSBuild needs to be in the x64 mod if the server is a 63bit machine. It looks like the Azure Management Cmdlets are only installed in the 64bin mod.</p>

<p>Higher window: x86 - error</p>

<p>Lower window: x64 - everything alright </p>

<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb379.png" width="554" height="155" /></p>

<p>As target I call "PrepareAzureDeployment" and enter as properties my subscription key and the location of the certificate. But I only do so because BizzBingo is Open Source and because of that I can´t save the sensitive information´s into the file. </p>

<p>The parameter looks like that:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:be6bcf64-9539-406f-8f33-8bfed4447444" class="wlWriterEditableSmartContent"><pre name="code" class="c#">/p:AzureSubKey="83-SUB-KEY-9812" /p:AzureCertPath="cert:\LocalMachine\my\XXXXXXXXX"</pre></div>

<p><b>"PrepareAzureDeployment" MsBuild Target</b></p>

<p>The main part of this is some log writings and a little "Dirty Hack" because I didn´t want to write sensitive information´s into the Web.Release.config <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile15.png" /></p>

<p>At the moment we read out the Web.Config for the data base access on BizzBingo. To keep the ConnectionString secret I copy a specific web.release.config file and overwrite the variant from TFS. Dirty Hack but it´s alright for me <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile15.png" /></p>

<p>First I´m going to show you the whole code and then I tell you how to go on:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e36bd779-1c78-45c9-810a-8c870b7e14d7" class="wlWriterEditableSmartContent"><pre name="code" class="c#">  &lt;Target Name="PrepareAzureDeployment"&gt;
    &lt;Message Text="PrepareAzureDeployment called."/&gt;

    &lt;!-- For security reasons web.release.config will be stored outside the codeplex repository and
        I will override it here (of you run this local with the web.release.config file under source control:
        this might be fail) --&gt;
    &lt;Message Text="CertPath: $(AzureCertPath)" /&gt;
    &lt;Message Text="Key: $(AzureSubKey)" /&gt;

    &lt;Copy SourceFiles="C:\BizzBingoSecureContainer\Web.Release.config" DestinationFolder="$(MSBuildStartupDirectory)\..\Source\BusinessBingo\Source\BusinessBingo.Web\" /&gt;

    &lt;MSBuild Projects="$(MSBuildStartupDirectory)\..\Source\BusinessBingo\Hosts\BusinessBingo.Hosts.Azure.Web\BusinessBingo.Hosts.Azure.Web.ccproj"
             Targets="CorePublish"
             Properties="Configuration=Release"/&gt;

    &lt;Message Text="Deploy To Staging on Azure" /&gt;

    &lt;Exec Command="powershell .\Azure_DeployToStaging.ps1 -certPath '$(AzureCertPath)' -subKey '$(AzureSubKey)'" /&gt;
    &lt;Message Text="Sleep for 400sec as a workaround" /&gt;
    &lt;Sleep Seconds="400" /&gt;

    &lt;Message Text="Swap To Production on Azure" /&gt;

    &lt;Exec Command="powershell .\Azure_SwapToProduction.ps1 -certPath '$(AzureCertPath)' -subKey '$(AzureSubKey)'" /&gt;

  &lt;/Target&gt;</pre></div>

<p>To build the Azure package I call the fitting MSBuild Target in the Azue project. Here I navigate with the help of "$(MSBuildStartupDirectory)" (therefore the WorkingDirectory in TeamCity) and call "CorePublish" with the accordingly configurations.</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:6a001616-100f-47af-bfcf-44253f4e0269" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    &lt;MSBuild Projects="$(MSBuildStartupDirectory)\..\Source\BusinessBingo\Hosts\BusinessBingo.Hosts.Azure.Web\BusinessBingo.Hosts.Azure.Web.ccproj"
             Targets="CorePublish"
             Properties="Configuration=Release"/&gt;</pre></div>

<p>"BusinessBingo.Hosts.Azure.Web" is a normal azure project which has ASP.NET MVC App as WebRole:</p>

<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb380.png" width="244" height="113" /></p>

<p>With the call of "CorePublish" the BusinessBingo.Web project will be build, the Web.config transformation started and the azure package packed. You will find the result in the "bin\Release\Publish" folder of the azure project:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image141.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb49.png" width="476" height="117" /></a></p>

<p><b>Deploy on azure staging</b></p>




<p>Now is in MSBuild the next step the call of the powershell script to deploy on azure. As parameters I add SubscriptionKey and Service Name:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:8696c0c9-4370-4f3d-b172-4cc33b92eab6" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    &lt;Message Text="Deploy To Staging on Azure" /&gt;

    &lt;Exec Command="powershell .\Azure_DeployToStaging.ps1 -certPath '$(AzureCertPath)' -subKey '$(AzureSubKey)'" /&gt;</pre></div>

<p>Side note: Because of MSBuild runs in the x64 bit modus Powershell is used to be called in the same mode. </p>

<p>Otherwise the Azure cmdlets won´t be found!</p>

<p>Main parts of the powershell script are from the <a href="http://wag.codeplex.com/">Windows Azure Guidance</a> from the p&amp;p team of Microsoft. More descriptions you will find <a href="http://msdn.microsoft.com/en-us/library/ff803365.aspx">here</a>. </p>

<p><b>Azure_DeployToStaging.ps1</b></p>




<p>Now we are going to take a deeper view into the Powershell script. I needed to fix it a little bit so now it´s possible to enter sensitive information´s from outside as parameters but beside of this it´s easy to understand. (And you will see how sexy Powershell could be!)</p>




<p><b><u>Important Hint: </u></b></p>

<p>A typical error message was for me: "<i>The HTTP request was forbidden with client authentication scheme "˜Anonymous´.". </i>That means you´ve entered a wrong subscription key. </p>




<p><b>The certificate:</b></p>

<p>Like I´ve already written the certificate needs to be uploaded on azure too. That´s what it could look like without adding it as a parameter:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:46619406-6312-44f7-90b6-95fc3ea4799f" class="wlWriterEditableSmartContent"><pre name="code" class="c#">$cert = Get-Item  cert:\CurrentUser\my\xxxxxxx</pre></div>

<p>It´s possible to take a look on the certificate store in two ways:</p>

<p>- CertMgr.msc</p>

<p>- Enter with Powershell "cd cert:"</p>

<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb382.png" width="232" height="361" /></p>

<p>You can take a look on the certificate store nearly like on a file system. But my "xxx" information needs to be replaced with the Thumbprint:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image142.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb50.png" width="498" height="39" /></a></p>

<p><b>Subscription Key</b></p>

<p>You will find the key in the Windows azure portal at the hosted services. I didn´t get to know till now if the key includes the number 0 or the letter O - it´s not possible to copy the key from the silverlight surface (thanks to RIA technology!) Maybe you fill found the key Billinginformation´s (ugly HTML but with copy/paste opptions <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile15.png" /> )</p>

<p><b>ServiceName</b></p>




<p>Even if the entry is called "Servicename" you need the DNS Name for that:</p>

<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb384.png" width="536" height="208" /></p>

<p>I think the name is case sensitive, so copy it as it´s written <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-smile" alt="Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-smile7.png" /></p>




<p><b>To the main script</b></p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:966d12d2-3978-4172-9244-56673698d13d" class="wlWriterEditableSmartContent"><pre name="code" class="c#">Param($certPath, $subKey)
# Secrets
$cert = Get-Item $certPath
$sub = $subKey
$servicename = "bizzbingo"

# Paths
$buildPath = "..\Source\BusinessBingo\Hosts\BusinessBingo.Hosts.Azure.Web\bin\Release\Publish\"
$packagename = "BusinessBingo.Hosts.Azure.Web.cspkg"
$serviceconfig = "ServiceConfiguration.cscfg"
$package = join-path $buildPath $packageName
$config = join-path $buildPath $serviceconfig

# Date
$a = Get-Date
$buildLabel = $a.ToShortDateString() + "-" + $a.ToShortTimeString()

# Install PS-SnapIn
if ((Get-PSSnapin | ?{$_.Name -eq "AzureManagementToolsSnapIn"}) -eq $null)
{
  Add-PSSnapin AzureManagementToolsSnapIn
}

# Get Staging
$hostedService = Get-HostedService $servicename -Certificate $cert -SubscriptionId $sub | Get-Deployment -Slot Staging

# Delete Staging if nessarary
if ($hostedService.Status -ne $null)
{
    $hostedService |
      Set-DeploymentStatus 'Suspended' |
      Get-OperationStatus -WaitToComplete
    $hostedService |
      Remove-Deployment |
      Get-OperationStatus -WaitToComplete
}

# Deploy on Staging
Get-HostedService $servicename -Certificate $cert -SubscriptionId $sub |
    New-Deployment Staging -package $package -configuration $config -label $buildLabel -serviceName $servicename |
    Get-OperationStatus -WaitToComplete

# Start on Staging
Get-HostedService $servicename -Certificate $cert -SubscriptionId $sub |
    Get-Deployment -Slot Staging |
    Set-DeploymentStatus 'Running' |
    Get-OperationStatus -WaitToComplete</pre></div>




<p>In the MsBuild step we did before I´ve build the package and I´m able to navigate to this place. Now it´s checking up if there is something going on in the staging surroundings and if there is something, it will be stopped. </p>

<p>Now the deployment starts and the instances will be turned off. The addition "WaitToComplete" takes care that every action will wait till the last one is completed. </p>

<p><b>Dirty Workaround at the start of the instance </b></p>




<p>If I try to start the staging surrounding in line 44 the "WaitToComplete" event is done too quickly. During the initialisation it´s written as "ready". That´s a problem of course if I try to switch automatically from Staging to production. I don´t know if this is what they have planned or if it´s a bug. But I´m not alone with my <a href="http://archive.msdn.microsoft.com/azurecmdlets/Thread/View.aspx?ThreadId=4519">problem</a> <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-smile" alt="Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-smile7.png" /></p>

<p>Here ones again the deployment steps which happen in the MSBuild script:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c77eec6f-9dfb-47f2-b6a7-9164b79db5b2" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    &lt;Exec Command="powershell .\Azure_DeployToStaging.ps1 -certPath '$(AzureCertPath)' -subKey '$(AzureSubKey)'" /&gt;

	&lt;Message Text="Sleep for 400sec as a workaround" /&gt;
    &lt;Sleep Seconds="400" /&gt;

    &lt;Message Text="Swap To Production on Azure" /&gt;
    &lt;Exec Command="powershell .\Azure_SwapToProduction.ps1 -certPath '$(AzureCertPath)' -subKey '$(AzureSubKey)'" /&gt;</pre></div>

<p>In Line 1 the built package will be deployed on the staging surrounding. Now the workaround starts: To switch from "Staging" to "Production" the staging needs to be booted up completely because otherwise you will have an ugly downtime on the "Production". So I wait for 400 seconds. That´s the time the azure project needs to initialize and start. The task is from the <a href="http://msbuildtasks.tigris.org/">MSBuild community task project</a>. Now the started staging surroundings will be "swapt" to the production. </p>

<p><b>Azure staging swap to production </b></p>

<p>Same game at the beginning: took Key/certificate and check Snapln. Now it took the deployment on the staging and makes a "Move-deployment" and it makes a "Swap" like in the webfrontend. </p>

<p>After that I should down the staging surrounding and delete it because it produces costs. </p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:7dca79c7-24a7-47fe-815b-a025b38b05c7" class="wlWriterEditableSmartContent"><pre name="code" class="c#">Param($certPath, $subKey)
# Secrets
$cert = Get-Item $certPath
$sub = $subKey
$servicename = "bizzbingo"

# Install PS-SnapIn
if ((Get-PSSnapin | ?{$_.Name -eq "AzureManagementToolsSnapIn"}) -eq $null)
{
  Add-PSSnapin AzureManagementToolsSnapIn
}

# Switch staging &lt;-&gt; production
Get-Deployment staging -subscriptionId $sub -certificate $cert -serviceName $servicename |
		Move-Deployment |
		Get-OperationStatus -WaitToComplete

# Stop in staging
Get-HostedService $servicename -Certificate $cert -SubscriptionId $sub |
    Get-Deployment -Slot 'Staging' |
    Set-DeploymentStatus 'Suspended' |
    Get-OperationStatus -WaitToComplete

# Remove from staging
Get-HostedService $servicename -Certificate $cert -SubscriptionId $sub |
    Get-Deployment -Slot 'Staging' |
    Remove-Deployment |
    Get-OperationStatus -WaitToComplete</pre></div>

<p><b>That´s it</b></p>

<p>The process may look a bit difficult but it isn´t with the Cmdlets I´ve showed you. The main barrier for me was the problem with the error message of the Azure Cmdlets.</p>

<p><b>Tl;dr</b></p>

<p>To say it short:</p>

<p>- SDK, install Cmdlets</p>

<p>- Windows Azure project + Azure account</p>

<p>- Generate and upload the management key</p>

<p>- Call windows azure project via MSBuild with "CorePublish"</p>

<p>- Built package via powershell on staging</p>

<p>- Wait a little bit - <a href="http://archive.msdn.microsoft.com/azurecmdlets/Thread/View.aspx?ThreadId=4519">maybe buggy</a>?</p>

<p>- Switsch from staging to production</p>

<p>The Code is on <a href="http://businessbingo.codeplex.com/">Codeplex</a> and the webpage is available on <a href="http://www.BizzBingo.com">www.BizzBingo.com</a>. </p>
