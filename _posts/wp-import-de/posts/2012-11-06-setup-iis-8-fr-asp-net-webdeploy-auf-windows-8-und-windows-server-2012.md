---
layout: post
title: "Setup IIS 8 für ASP.NET & WebDeploy auf Windows 8 und Windows Server 2012"
date: 2012-11-06 23:43
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [IIS, Powershell, Web Deploy, Windows Server 2012]
language: de
---
{% include JB/setup %}
<p>Eine Maschine für ASP.NET (oder generell den Web-Stack von Microsoft) und Web Deploy vorzubereiten ist nicht wirklich schwierig.</p> <p>Wer die Server-Variante einsetzt kann das ganze sogar via Powershell erledigen – dazu einfach bis fast ans Ende des Posts scrollen.</p> <p><strong>Kurz-Information: Was ist Web Deploy?</strong></p> <p>Web Deploy (früher auch MSDeploy genannt) ist eine Deployment-Art welche cleverer als XCopy oder FTP ist. Ein kleinen Einstieg hab ich damals in <a href="{{BASE_PATH}}/2010/11/11/howto-msdeploy-msbuild/">diesem Post gegeben</a>.</p> <p><strong>Setup über die GUI (Windows 8 und Windows Server 2012)</strong></p> <p>Ein relativ nacktes Windows 8 System hat als Windows Features nur das Nötigste dabei:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1628.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb787.png" width="520" height="496"></a></p> <p><strong>Das heisst erstmal die Grundsachen installieren: IIS &amp; co.</strong>&nbsp;</p> <p>Am einfachsten den Haken bei “ASP.NET 4.5” reinsetzen und dazu wähle ich noch die Management Tools aus sowie zwei, drei andere Sachen – WebSockets, Windows Authentifizierung, Logging z.B.:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1629.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb788.png" width="349" height="752"></a> </p> <p><strong>MSDeploy über den Web Platform Installer installieren</strong></p> <p>Wenn man nun den IIS Manager öffnet springt einem sofort der Web Platform Installer entgegen. Über diesen lässt sich WebDeploy (manchmal auf MSDeploy genannt) und andere Tools nachinstallieren.</p> <p>Gebraucht wird Web Deploy 3.0</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1630.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; display: inline; border-top-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb789.png" width="553" height="188"></a> </p> <p></p> <p></p> <p></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1631.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb790.png" width="561" height="388"></a> </p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1632.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb791.png" width="564" height="158"></a> </p> <p></p> <p>Fertig.</p> <p><strong>Hinter den Kulissen von Web Deploy: MsDepSrv &amp; WmSrv</strong></p> <p>Es gibt zwei Dienste, welche den Web Deploy Aufruf entgegen nehmen können:</p> <p>Der IIS Management Service (wmsrv) und der MSDeploy Service (MsDepSrv). Der einzige Unterschied ist, dass man auf einem Server Betriebssystem IIS User erstellen kann und dass das Deployment auch von nicht-Admins über diese Accounts ausgeführt werden kann. </p> <p><em>Dieser Dienst ist auf einer Windows Client Version (= Windows 8, Windows 7 etc.) nicht verfügbar! Allerdings funktioniert Web Deploy dann über den MsDepSrv.</em></p> <p><strong>Setup via Powershell auf Windows Server</strong></p> <p>Auf <strong><a href="http://www.tugberkugurlu.com/archive/script-out-everything-initialize-your-windows-azure-vm-for-your-web-server-with-iis-web-deploy-and-other-stuff">diesem Blog</a></strong> habe ich ein extrem praktisches Powershell Script gefunden – allerdings funktioniert dies nur auf Server Betriebssystemen, da der “Server-Manager” auf Windows Client Installationen nicht vorhanden ist. Eine <a href="http://www.tugberkugurlu.com/archive/script-out-everything-initialize-your-windows-azure-vm-for-your-web-server-with-iis-web-deploy-and-other-stuff">genaue Erklärung ist direkt im Blog</a> enthalten. Das Script gibt es auf <a href="https://gist.github.com/3742921#file_init_web_server_vm.ps1">GitHub</a>, oder direkt hier. </p> <p>Es installiert im Grunde den IIS und diverse Features nach und lädt dann über die <a href="http://www.iis.net/learn/install/web-platform-installer/web-platform-installer-v4-command-line-webpicmdexe-rtw-release">Web Platform Installer Command Line</a> das Web Deploy 3.0 Paket herunter und installiert dies zusammen mit anderen Packages – kann man beruhigt zuschauen ;)</p><pre>##################################################
# Resources:
## ServerManager Module: http://technet.microsoft.com/en-us/library/cc732263.aspx
## NetSecurity Module: http://technet.microsoft.com/en-us/library/hh831755.aspx
## Others:
## http://www.iis.net/learn/manage/remote-administration/remote-administration-for-iis-manager
## http://blogs.technet.com/b/heyscriptingguy/archive/2012/05/12/weekend-scripter-use-powershell-to-easily-modify-registry-property-values.aspx
## http://www.iis.net/learn/install/web-platform-installer/web-platform-installer-v4-command-line-webpicmdexe-rtw-release
## http://www.tugberkugurlu.com/archive/script-out-everything-initialize-your-windows-azure-vm-for-your-web-server-with-iis-web-deploy-and-other-stuff
##
## Instructions:
## When you install the Web Platform Installer v4 RTW 
## (http://download.microsoft.com/download/7/0/4/704CEB4C-9F42-4962-A2B0-5C84B0682C7A/WebPlatformInstaller_amd64_en-US.msi), 
## you will get Web Platform Installer v4 Command Line Tool OOB. Under C:\Program Files\Microsoft\Web Platform Installer directory,
## There are three files:
##     * Microsoft.Web.PlatformInstaller.dll
##     * WebpiCmd.exe
##     * WebpiCmd.exe.config
## These files can be copied around. Take those three files and put this script under the same path.
## Set your PowerShell Execution Policy to Unrestricted:
##     PS&gt; Set-ExecutionPolicy Unrestricted
## Lastly, run this script file:
##     PS&gt; .\Init-WebServerVM.ps1
## Now, go and watch your favorite TV Show till your VM gets ready for ya :)
##################################################

# Variables
$ScriptRoot = (Split-Path -parent $MyInvocation.MyCommand.Definition)
$additionalFeatures = @('Web-Mgmt-Service', 'Web-Asp-Net45', 'Web-Dyn-Compression', 'Web-Scripting-Tools')
$webPiProducts = @('WDeployPS', 'UrlRewrite2')

# Import Modules
Import-Module -Name ServerManager
Import-Module -Name NetSecurity
Import-Module -Name Microsoft.PowerShell.Management

# Add Windows Features
Install-WindowsFeature -Name Web-Server -IncludeManagementTools -LogPath "$env:TEMP\init-webservervm_webserver_install_log_$((get-date).ToString("yyyyMMddHHmmss")).txt"
foreach($feature in $additionalFeatures) { 
    
    if(!(Get-WindowsFeature | where { $_.Name -eq $feature }).Installed) { 

        Install-WindowsFeature -Name $feature -LogPath "$env:TEMP\init-webservervm_feature_$($feature)_install_log_$((get-date).ToString("yyyyMMddHHmmss")).txt"   
    }
}

# Make Sure That Remote Connection is Enabled
if((Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\WebManagement\Server\ -Name EnableRemoteManagement).EnableRemoteManagement -eq 0) { 
    Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\WebManagement\Server\ -Name EnableRemoteManagement -Value 1   
}

# Set WMSvc to Automatic Startup
Set-Service -Name WMSvc -StartupType Automatic

# Check If WMSvc (Web Management Service) is running
if((Get-Service WMSvc).Status -ne 'Running') { 
    Start-Service WMSvc
}

# Install WebPI Products
&amp; "$ScriptRoot\WebPICMD.exe" /Install /Products:"$($webPiProducts -join ',')" /AcceptEULA /Log:"$env:TEMP\webpi_products_install_log_$((get-date).ToString("yyyyMMddHHmmss")).txt"

# Add WMSvc Port Firewall Allow Rule
New-NetFirewallRule -DisplayName "Allow Web Management Service In" -Direction Inbound -LocalPort 8172 -Protocol TCP -Action Allow

# Restart the Web Management Service
Restart-Service WMSvc
</pre>
<p>Ansonsten behält mein <a href="{{BASE_PATH}}/2011/03/28/howto-setup-von-webdeploy-msdeploy/">älterer Post</a> weiterhin seine Gültigkeit.</p>
<p><strong>Web Deploy anwenden</strong></p>
<p>Nach der Installation (z.B. auf unsere lokale Maschine) können wir Web Deploy einfach nutzen indem wir im Visual Studio Projekt ein Publishing Profil hinzufügen:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1633.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb792.png" width="496" height="387"></a> </p>
<p>Ergebnis:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1634.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb793.png" width="175" height="88"></a> </p>
<p>:)</p>
<p>Damit sollte man nun für den ersten Einstieg in die Welt von Web Deploy und dem IIS gerüstet sein.</p>
