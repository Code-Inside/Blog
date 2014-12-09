---
layout: post
title: "Automatisiertes Deployment auf Windows Azure über einen Buildserver via Powershell"
date: 2011-02-22 00:57
author: robert.muehsig
comments: true
categories: [HowToCode]
tags: [Azure, Deployment, Powershell, TeamCity]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1192.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb372.png" width="150" height="102" /></a>In den letzten Blogposts bin ich schon auf den Einsatz von <a href="{{BASE_PATH}}/?s=teamcity">TeamCity als Buildserver</a> eingegangen. Da wir bei dem <a href="http://www.bizzbingo.de">BizzBingo</a> Projekt auf <a href="http://www.microsoft.com/windowsazure/">Windows Azure</a> setzen ging es nun darum, wie man automatisiert neue Deployments auf Azure vornehmen kann - insgesamt ist es doch einfacher als gedacht :)</p>  <p></p>  <p><strong>"Visual Studio Deployment” == Fail!</strong></p>  <p>Wer ein Windows Azure Projekt anlegt bekommt auch direkt im Visual Studio direkt die Möglichkeit ein Deployment durchzuführen:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1193.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb373.png" width="510" height="202" /></a> </p>  <p>Das ist für die ersten Entwicklungsschritte ganz nett und ich möchte dies auch nicht missen. Wer allerdings Software entwickelt und bei seinem Build- und Deploymentprozess nur auf seiner lokalen Maschine mit Visual Studio setzt sollte sich evtl. Gedanken machen ;) </p>  <p><strong>Zielarchitektur</strong></p>  <p>Es kann mehrere Entwickler geben (Dev A/B), welche auf einem Soure Control System, wie z.B. dem TFS oder SVN oder Git etc. arbeiten. Ein Buildsystem, in meinem Beispiel ist das TeamCity, schaut entweder in Intervallen nach oder wird manuell angestoßen und holt sich die aktuellen Sourcen ab und baut diese. Da BizzBingo Open Source ist, muss ich hier die sensiblen Daten allerdings auslagern. Nachdem das Projekt gebaut ist, wird dies auf die Staging Umgebung von Azure deployed. Wenn dies erfolgt ist, wird die Staging Umgebung zur Production Umgebung "geswapt” um den Betrieb möglichst nicht allzulange zu stören (möglichst wenig Downtime ist das Ziel).</p>  <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1194.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; margin-left: 0px; border-top: 0px; margin-right: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb374.png" width="479" height="327" /></a> </p>  <p>Welchen Teil man automatisieren möchte, muss natürlich jeder selbst bestimmen - evtl. wird nur auf die Staging Umgebung deployed oder es wird immer direkt auf die Production deployed - jeder wie er mag. Zusätzlich könnten auf der Staging Umgebung auch noch Tests ausgeführt werden (Selenium, UI Tests etc.) und erst dann geschieht irgendwas. Aufgrund der "Hobbymentalität” bei <a href="http://www.bizzbingo.de">BizzBingo</a> (nichts anderes ist es ja ;) ) geh ich den einfachen Weg.</p>  <p><strong>Grundvoraussetzungen</strong></p>  <p>Ich setze ein installiertes TeamCity und ein Code Repository (TFS/SVN etc.) mal vorraus. TeamCity muss irgendwie in der Lage sein die Sourcen zu ziehen.&#160; Der Einsatz von TeamCity ist natürlich freiwillig - man kann es auch lokal oder über ein anderes System (TFS Teambuild, klassisches MSBuild) aufrufen. Für Windows Azure sollte man Accountdaten besitzen - wichtigste Daten:</p>  <ul>   <li>Servicename</li>    <li>Subscription Key</li> </ul>  <p><strong>Windows Azure Management Cmdlets zum Automatisieren</strong></p>  <p>Rund um das Management für Windows Azure stellt Microsoft eine <a href="http://msdn.microsoft.com/en-us/library/ee460799.aspx">REST Schnittstelle</a> zur Verfügung. Allerdings wäre es etwas mühsam die API direkt dafür zu nutzen. Ebenfalls von Microsoft (und evtl. auch noch anderen Freiwilligen - das ganze ist Open Source) gibt es die <a href="http://archive.msdn.microsoft.com/azurecmdlets">Azure Management Cmdlets</a> (Powershell!).</p>  <p>Folgende Software sollte installiert sein:</p>  <ul>   <li>Neustes <a href="http://msdn.microsoft.com/en-us/library/dd179367.aspx">Windows Azure SDK</a> (aktull 1.3)</li>    <li><a href="http://archive.msdn.microsoft.com/azurecmdlets">Azure Management Cmdlets</a></li>    <li>Powershell (ab Win7 / WinServer2008 standardmäßig dabei)</li> </ul>  <p><u>Installation Azure Management Cmdlets</u></p>  <p>Evtl. kann es bei der Installation der Probleme geben. Die Installationsroutine überprüft ganz genau die Azure SDK Version. Beim letzten Security Update hat sich die Versionsnummer erhöht. Der check kann aber in dieser Datei angepasst werden:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:37289d35-b890-43c4-bfa5-5d49ceec9e42" class="wlWriterEditableSmartContent"><pre name="code" class="c#">C:\WASMCmdlets\setup\scripts\dependencies\check\CheckAzureSDK.ps1</pre></div>

<p>Dort befinden sich folgende zwei Zeilen mit der genauen SDK Version:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:cab4f9bd-e7c8-4654-bcaf-e56d5730c102" class="wlWriterEditableSmartContent"><pre name="code" class="c#">
$res1 = SearchUninstall -SearchFor 'Windows Azure SDK*' -SearchVersion '1.3.20121.1237' -UninstallKey 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\';
$res2 = SearchUninstall -SearchFor 'Windows Azure SDK*' -SearchVersion '1.3.20121.1237' -UninstallKey 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\';

</pre></div>

<p>Durch jedes Security Update verändert sich die Versionsnummer - ich hab jedenfalls von Hand die Version "1.3.20121.1237” eingetragen. Das ist bei mir jedenfalls gut gegangen und der Installer lief erfolgreich durch.</p>

<p><strong>Management Zertifikat</strong></p>

<p>Ich zitiere mal <a href="http://www.davidaiken.com/2009/12/21/how-to-create-a-x509-certificate-for-the-windows-azure-management-api/">David Aiken</a>:</p>

<ol>
  <li>Load the IIS 7 management console. I”™m assuming here you have IIS7 installed since its required for the Windows Azure SDK.</li>

  <li>Click on your Server.</li>

  <li>Double Click Server Certificates in the IIS Section in the main panel.</li>

  <li>Click Create Self-Signed Certificate... in the Actions panel.</li>

  <li>Give it a Friendly Name.</li>

  <li>Close IIS Manager.</li>

  <li>Open Certificate Manager (Start-&gt;Run-&gt;certmgr.msc)</li>

  <li>Open Trusted Root Certification Authorities, then Certificates.</li>

  <li>Look for your certificate (Tip: Look in the Friendly Name column).</li>

  <li>Right Click your certificate, then choose All Tasks, then Export...</li>

  <li>In the Wizard, choose No, do not export the private key, then choose the DER file format.</li>

  <li>Give your cert a name. (remember to call it something.cer).</li>

  <li>Navigate to the Windows Azure Portal - <a href="http://windows.azure.com">http://windows.azure.com</a></li>
</ol>

<p>Eine andere Variante zum Erzeugen des Zertifikats "<a href="http://msdn.microsoft.com/en-us/library/bfsktky3(v=vs.80).aspx">makecert</a>”:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:997db81b-231d-4c25-b9d8-b48db85dfdbe" class="wlWriterEditableSmartContent"><pre name="code" class="c#">makecert -r -pe -a sha1 -n "CN=Windows Azure Authentication Certificate" -ss My -len 2048 -sp "Microsoft Enhanced RSA and AES Cryptographic Provider" -sy 24 testcert.cer</pre></div>

<p>Das Tool befindet sich u.A. im Windows SDK: C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\Bin</p>

<p>Egal welche Variante man nimmt - von irgendwoher braucht man es :)</p>

<p>Das Zertifikat kann nun unter "Management Certificates” hinzugefügt werden:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1195.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb375.png" width="507" height="161" /></a> </p>

<p><strong>TeamCity Build</strong></p>

<p>Nun kommen wir zum Buildprozess. Der wichtigste Schritt ist hier der Aufruf des MSBuilds. Den Schritt den ich davor mache, hat im Prinzip nichts direkt mit dem Azure Deployment zutun.</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1196.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb376.png" width="551" height="141" /></a> </p>

<p>Im Detail:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1197.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb377.png" width="521" height="377" /></a> </p>

<p>In diesem Schritt soll das MSBuild Script aufgerufen werden, welches hier liegt:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:9a5956ab-aad1-47d4-b116-4144136718a3" class="wlWriterEditableSmartContent"><pre name="code" class="c#">%system.teamcity.build.checkoutDir%\Main\Build\CommonBuildSteps.targets</pre></div>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p>Im <a href="http://businessbingo.codeplex.com/">TFS</a> ist die Datei da hinterlegt:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1198.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb378.png" width="346" height="127" /></a> </p>

<p>Wichtig ist noch mitzugeben, was das Working Directory ist, damit ich mich im MSBuild "navigieren” kann. </p>

<p><strong>Wichtig:</strong> MSBuild muss im x64 Modus sein, wenn der Server eine 64bit Maschine ist. Die Azure Management Cmdlets sind scheinbar nur im 64bit Modus installiert.</p>

<p>Oberes Fenster: x86 - Fehler
  <br />Unteres Fenster: x64 - Alles gut</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1199.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb379.png" width="554" height="155" /></a> </p>

<p>Als Target ruf ich "PrepareAzureDeployment” auf und gebe als Properties mein Subscription Key und den Ort des Zertifikats mit. Das mache ich aber auch nur, weil BizzBingo Open Source ist und ich daher diese sensiblen Daten nicht einfach in das File speichern kann.</p>

<p>Die Parameter werden in dieser Form mitgegeben:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:6bff1846-88fb-4613-8f50-eade8600f636" class="wlWriterEditableSmartContent"><pre name="code" class="c#">/p:AzureSubKey="83-SUB-KEY-9812" /p:AzureCertPath="cert:\LocalMachine\my\XXXXXXXXX"</pre></div>

<p><strong>"PrepareAzureDeployment” MSBuild Target</strong></p>

<p>Hier sind im großen Teil Logausschriften mit dabei und eine kleiner "Dirty Hack”, weil ich keine sensiblen Daten in die Web.Release.config schreiben wollte ;)</p>

<p>Aktuell lesen wir bei BizzBingo die Web.config für den Datenbank Zugriff aus. Um den ConnectionString geheim zu halten, kopiere ich mir eine bestimmte web.release.config Datei und überschreibe die Variante welche aus dem TFS kommt. Dirty Hack, aber es passt bei mir ;) (würde natürlich fehlschlagen, wenn der Ordner nicht da ist).</p>

<p>Ich zeige erst den vollständigen Code, dann erkläre ich weiter:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5696b9fa-43bc-41eb-9561-4391ac2dec1e" class="wlWriterEditableSmartContent"><pre name="code" class="c#">
  &lt;Target Name="PrepareAzureDeployment"&gt;
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

<p>Um das Azure Package zu bauen, rufe ich einfach in dem Azure Projekt das entsprechende MSBuild Target auf. Hier muss ich mich nun mittels "$(MSBuildStartupDirectory)” hinnavigieren (dafür auch das WorkingDirectory im TeamCity) und rufe "<strong>CorePublish</strong>” mit der entsprechenden Konfiguration auf:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:501a2618-0e11-45d2-aedc-708ec1ec9560" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    &lt;MSBuild Projects="$(MSBuildStartupDirectory)\..\Source\BusinessBingo\Hosts\BusinessBingo.Hosts.Azure.Web\BusinessBingo.Hosts.Azure.Web.ccproj"
             Targets="CorePublish"
             Properties="Configuration=Release"/&gt;</pre></div>

<p>"BusinessBingo.Hosts.Azure.Web” ist ein ganz normales Azure Projekt, welches als WebRole die ASP.NET MVC App hat:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1200.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb380.png" width="244" height="113" /></a> </p>

<p>Durch den Aufruf von "<strong>CorePublish</strong>”, wird das BusinessBingo.Web Projekt gebaut, die Web.config Transformation ausgelöst und das Azure Package gebaut. Das Ergebnis liegt schlicht im "bin\Release\Publish” Ordner des Azure Projekts:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1201.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb381.png" width="469" height="116" /></a> </p>

<p><strong>Deploy on Azure Staging</strong></p>

<p>Nun ist im MSBuild der nächste Schritt den Aufruf des Powershell Scripts zum Deployen auf Azure. Als Parameter gebe ich noch SubscriptionKey und ServiceName mit:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:795ad4a3-b757-4a88-a236-5637858a46a7" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    &lt;Message Text="Deploy To Staging on Azure" /&gt;
    
    &lt;Exec Command="powershell .\Azure_DeployToStaging.ps1 -certPath '$(AzureCertPath)' -subKey '$(AzureSubKey)'" /&gt;</pre></div>

<p><em>Kleine Nebenbemerkung: Dadurch, dass <strong>MSBuild im x64 bit</strong> Modus aufgerufen wurde, wird nun auch die Powershell im x64 Modus aufgerufen. Ansonsten würden die Azure Cmdlets <strong>nicht</strong> gefunden werden!</em></p>

<p>Große Teile des Powershell Scripts stammen von der <a href="http://wag.codeplex.com/">Windows Azure Guidance</a> vom p&amp;p Team von Microsoft. Genaue Beschreibung ist <a href="http://msdn.microsoft.com/en-us/library/ff803365.aspx">hier</a> zu finden.</p>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p><strong>Azure_DeployToStaging.ps1</strong></p>

<p>Nun ein genauer Blick auf das Powershell Script. Ich musste es etwas anpassen, damit die sensiblen Daten von aussen als Parameter reingegeben werden, aber ansonsten ist es eigentlich recht einfach zu verstehen (und man sieht wie sexy Powershell sein kann!).</p>

<p><strong><u>Wichtiger Hinweis:</u></strong></p>

<p>Häufige Fehlermeldung war bei mir "<em>The HTTP request was forbidden with client authentication scheme 'Anonymous'.”.</em> Das passiert, wenn der Subscription Key falsch ist.</p>

<p><strong>Zum Zertifikat:</strong></p>

<p>Wie weiter oben beschrieben muss das Zertifikat auch auf Azure hochgeladen sein.&#160; So könnte die Angabe zum Zertifikat aussehen, ohne dass man es als Parameter mit reingibt:</p>

<p>
  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a7511e3a-4dfb-457b-8aeb-aa2854b9fe0d" class="wlWriterEditableSmartContent"><pre name="code" class="c#">$cert = Get-Item  cert:\CurrentUser\my\xxxxxxx</pre></div>
</p>

<p>Den Zertifikatsstore kann man sich auf zwei wegen anschauen:</p>

<ul>
  <li>CertMgr.msc</li>

  <li>Über die Powershell "cd cert:” eingeben</li>
</ul>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1202.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; margin-left: 0px; border-top: 0px; margin-right: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb382.png" width="232" height="361" /></a> </p>

<p>Der Zertifikatsstore kann ähnlich einem Dateisystem angeschaut werden. Wobei meine "xxxx” Angabe von oben mit dem Thumbprint ersetzt werden muss:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1203.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb383.png" width="521" height="41" /></a></p>

<p>&#160;<strong>Subscription Key</strong></p>

<p>Den Key findet man im Windows Azure Portal bei den Hosted Services. Ich hab es selber nicht rausbekommen, ob der Key auch die Zahl 0 oder nur den Buchstaben 0 enthält - dummerweise kann man den Key nicht aus der Silverlight Oberfläche rauskopieren (danke RIA Technologie!). Evtl. findet man den Key auch in den Billinginformationen (das hässliche HTML - aber mit Copy/Paste Möglichkiet ;) )</p>

<p><strong>ServiceName</strong></p>

<p>Auch wenn der Eintrag "Servicename” heisst, ist hier der DNS Name gefragt:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1204.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb384.png" width="536" height="208" /></a></p>

<p>Ich glaube, der Name ist auch case sensitive, also genau so abschreiben, wie er da steht :)</p>

<p>&#160;<strong>Zum eigentlichen Script</strong></p>

<p>
  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e5fd4ac3-e4a6-49bd-8451-f0bf2cfbe930" class="wlWriterEditableSmartContent"><pre name="code" class="c#">Param($certPath, $subKey)
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
</p>

<p>Im MSBuild Schritt vorher habe ich ja das Paket gebaut und kann mich entsprechend dahin navigieren. Nun wird im Prinzip geschaut, ob bereits auf der Staging Umgebung etwas läuft, wenn ja wird es abgeschalten. Dann geht das Deployment los und die Instanzen werden angeschaltet. Der Zusatz "-WaitToComplete” soll dafür sorgen, dass jede Aktion auf die andere wartet. Jede Aktion dauert ja eine gewisse Zeit. </p>

<p><strong>Dirty Workaround beim Starten der Instanz</strong></p>

<p>Wenn ich in der Zeile 44 die Staging Umgebung starten will, dann wird das "-WaitToComplete” Event viel zu schnell abgearbeitet. Noch während der Initialisierung wird es als "fertig” ausgewiesen. Das ist natürlich ein Problem, wenn ich nun automatisiert von Staging auf Production umschalten will. Ob das so gedacht ist oder ob es ein Bug ist, weiß ich allerdings selber nicht. Ich bin aber nicht allein mit dem <a href="http://archive.msdn.microsoft.com/azurecmdlets/Thread/View.aspx?ThreadId=4519">Problem</a> :)</p>

<p>Hier nochmal die Deploymentschritte, welche im MSBuild Script geschehen:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:836d7b75-fc04-4e5c-ac78-040ab581ddcb" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    &lt;Exec Command="powershell .\Azure_DeployToStaging.ps1 -certPath '$(AzureCertPath)' -subKey '$(AzureSubKey)'" /&gt;
    
	&lt;Message Text="Sleep for 400sec as a workaround" /&gt;
    &lt;Sleep Seconds="400" /&gt;

    &lt;Message Text="Swap To Production on Azure" /&gt;
    &lt;Exec Command="powershell .\Azure_SwapToProduction.ps1 -certPath '$(AzureCertPath)' -subKey '$(AzureSubKey)'" /&gt;</pre></div>

<p>In Zeile 1 wird das gebaute Paket auf der Staging Umgebung deployed. Nun kommt der Workaround: Damit ich von "Staging” zu "Production” umschwenken kann, muss die Staging vollständig hochgefahren sein, weil ich ansonsten auf der "Production” eine hässliche Downtime habe. Daher warte ich 400 Sekunden -solange braucht man Azure Projekt zum Initialisieren und Starten. Der Task kommt von den <a href="http://msbuildtasks.tigris.org/">MSBuild Community Task Projekt</a> Nun wird die gestartete Staging Umgebung zur Production "geswapt” (tolles Unwort)</p>

<p><strong>Azure Staging Swap to Production</strong></p>

<p>Am Anfang wieder selbes Spiel: Key/Zertifikat holen und prüfen ob SnapIn da ist. Dann hole ich mir das Deployment auf der Staging und mache ein "Move-Deployment”, was wie im Webfrontend ein "Swap” macht. </p>

<p>Danach fahre ich die Staging Umgebung wieder runter und lösche die Staging Umgebung, weil die mich ja auch kostet. </p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:6ec828fb-65d0-4c8f-aca6-1a3cb20eb872" class="wlWriterEditableSmartContent"><pre name="code" class="c#">Param($certPath, $subKey)
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

<p><strong>Fertig</strong></p>

<p>Der Prozess mag jetzt erst einmal komplex aussehen - ist er aber eigentlich mit den hier gezeigten Cmdlets nicht. Die größten Hürden bei mir waren die Probleme mit den Fehlermeldungen der Azure Cmdlets.</p>

<p><strong>tl;dr</strong></p>

<p>Um es kurz zu fassen:</p>

<ul>
  <li>SDK, Cmdlets Installieren</li>

  <li>Windows Azure Projekt + Azure Konto erfolgreich anlegen</li>

  <li>Management Key generieren und hochladen</li>

  <li>Windows Azure Projekt über MSBuild mit "CorePublish” aufrufen</li>

  <li>Gebautes Paket via Powershell auf Staging</li>

  <li>Kurz abwarten - <a href="http://archive.msdn.microsoft.com/azurecmdlets/Thread/View.aspx?ThreadId=4519">weil scheinbar buggy (?)</a></li>

  <li>Von Staging auf Production umschwenken</li>
</ul>

<p>Den Code gibt es auf <a href="http://businessbingo.codeplex.com/">Codeplex</a> und die Liveseite ist unter <a href="http://www.BizzBingo.de">www.BizzBingo.de</a> erreichbar.</p>
