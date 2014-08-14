---
layout: post
title: "Visual Studio Tools in der PowerShell nutzen"
date: 2013-02-11 22:17
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Powershell, Visual Studio]
---
<p>Da ich in lezter Zeit immer häufiger auf die Powershell zugegriffen hab und es mich immer gestört hat, dass die Visual Studio Tools wie sn.exe oder msbuild.exe nur über die “Developer Command Prompt” aufrufbar waren (ohne den kompletten Pfad anzugeben) habe ich mal nach der Lösung gegoogelt.</p> <p><strong>Was macht die Developer Command Prompt?</strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1771.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb925.png" width="432" height="171"></a>Der Shortcut ruft eigentlich die Batch Datei “VsDevCmd.bat” auf, welche diverse Umgebungsvariablen setzt.</p> <p>Die Datei ist unter diesem Pfad zu finden:</p> <p><em>C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\Tools</em></p> <p><strong>Ein Profile.ps1 anlegen</strong></p> <p>Um in jeder Powershell Session auf diese Funktionalität zuzugreifen kann man ein <a href="http://technet.microsoft.com/en-us/library/ee692764.aspx">Profil anlegen.</a>&nbsp;</p> <p>Dazu legt man einen “WindowsPowershell” Ordner hier an:</p> <p><em>C:\Users\USERNAME\Documents</em></p> <p>Im WindowsPowershell Ordner legt man eine Profile.ps1 Datei an. Diese wird ab sofort bei jeder Powershell Session automatisch ausgeführt</p> <p><strong>Visual Studio Tools in der Powershell registrieren (und noch mehr)</strong></p> <p>Durch ein Link von dem <a href="http://stackoverflow.com/questions/138144/whats-in-your-powershell-profile-ps1file">Stackoverflow Threads</a> bin ich auf diesen <a href="http://www.tavaresstudios.com/Blog/post/The-last-vsvars32ps1-Ill-ever-need.aspx">Blog</a> gekommen. Zudem habe ich noch ein paar <a href="http://thomasfreudenberg.com/">Anregungen von Thomas Freudenberg</a> übernommen, da <a href="https://gist.github.com/thoemmi/3720721">er sein Powershell Profile hier veröffentlicht</a> hat. Heraus gekommen ist dies:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">###############################################################################
# Profile PS1 based on this samples:
# http://stackoverflow.com/questions/138144/whats-in-your-powershell-profile-ps1file
# http://www.tavaresstudios.com/Blog/post/The-last-vsvars32ps1-Ill-ever-need.aspx
# Place this file in: C:\Users\ACCNAME\Documents\WindowsPowerShell\profile.ps1
# https://gist.github.com/thoemmi/3720721
###############################################################################
# red background if running elevated
###############################################################################

&amp; {
 $wid=[System.Security.Principal.WindowsIdentity]::GetCurrent()
 $prp=new-object System.Security.Principal.WindowsPrincipal($wid)
 $adm=[System.Security.Principal.WindowsBuiltInRole]::Administrator
 $IsAdmin=$prp.IsInRole($adm)
 if ($IsAdmin)
 {
  (get-host).UI.RawUI.Backgroundcolor="DarkRed"
  clear-host
 }
}

###############################################################################
# Exposes the environment vars in a batch and sets them in this PS session
###############################################################################
function Get-Batchfile($file) 
{
    $theCmd = "`"$file`" &amp; set" 
    cmd /c $theCmd | Foreach-Object {
        $thePath, $theValue = $_.split('=')
        Set-Item -path env:$thePath -value $theValue
    }
}


###############################################################################
# Sets the VS variables for this PS session to use (for VS 2012)
###############################################################################
function VsVars32($version = "11.0")
{
	# 64bit Key in Registry
    $theKey = "HKLM:SOFTWARE\Wow6432Node\Microsoft\VisualStudio\" + $version
    $theVsKey = get-ItemProperty $theKey
    $theVsInstallPath = [System.IO.Path]::GetDirectoryName($theVsKey.InstallDir)
    $theVsToolsDir = [System.IO.Path]::GetDirectoryName($theVsInstallPath)
    $theVsToolsDir = [System.IO.Path]::Combine($theVsToolsDir, "Tools")
    $theBatchFile = [System.IO.Path]::Combine($theVsToolsDir, "vsvars32.bat")
    Get-Batchfile $theBatchFile
    [System.Console]::Title = "Visual Studio " + $version + " Windows Powershell"

	Write-Host "[Profile.ps1] Visual Studio 2012 CMD Commands set" -Foreground Green
}

function SetupPowershellHistory() {
	$profileFolder = split-path $profile

	# save last 100 history items on exit
	$historyPath = Join-Path $profileFolder history.clixml

	# hook powershell's exiting event &amp; hide the registration with -supportevent.
	Register-EngineEvent -SourceIdentifier powershell.exiting -SupportEvent -Action {
		Get-History -Count 100 | Export-Clixml (Join-Path (split-path $profile) history.clixml) }

	# load previous history, if it exists
	if ((Test-Path $historyPath)) {
		Import-Clixml $historyPath | ? {$count++;$true} | Add-History
		Write-Host "[Profile.ps1] Loaded $count history item(s)" -Foreground Green
	}
}

###############################################################################
# Execute
###############################################################################
Write-Host "[Custom Profile.ps1 invoked]"

# VS
VsVars32

# History
SetupPowershellHistory

Write-Host "[Custom Profile.ps1 finished]"</pre>
<p>Damit habe ich in jeder Powershell Session die Visual Studio Tools dabei sowie die letzten 100 Befehle die ich eingetippt hab (was ziemlich cool ist).</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1772.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb926.png" width="591" height="440"></a> </p>
<p><strong>Was ist der Unteschied zwischen Profile.ps1 und Microsoft.Powershell_Profile.ps1?</strong></p>
<p>Wer nur ein “Profile.ps1” ablegt, der hat die Funktionalität in allen Powershell Hosts zur Verfügung – d.h. auch z.B. im NuGet Package Manager. Wer es nur von der Windows Powershell benötigt, der kann ein Microsoft.Powershell_profile.ps1 anlegen.</p>
<p><strong>Sourcen</strong></p>
<p>Das ganze ist natürlich <a href="https://github.com/Code-Inside/Configs/blob/master/profile.ps1">auch auf GitHub zu finden</a>. Wer noch Anregung hat, kann gern auch ein Pull Request machen ;)</p>
