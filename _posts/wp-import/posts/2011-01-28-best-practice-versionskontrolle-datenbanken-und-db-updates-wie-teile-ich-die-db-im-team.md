---
layout: post
title: "Best Practice: Versionskontrolle, Datenbanken und DB-Updates… wie teile ich die DB im Team?"
date: 2011-01-28 20:41
author: robert.muehsig
comments: true
categories: [HowTo, HowToCode]
tags: [Best Practices, BizzBingo, SQL, Team]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image1177.png"><img style="border-right-width: 0px; margin: 0px 10px 0px 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb359.png" width="124" height="179" /></a> </p>  <p>Bei fast jeder Entwicklung im Webbereich ist irgendwo eine Datenbank involviert. Während der Entwicklung ist meist (oder hoffentlich) auch ein Versionskontroll System im Einsatz. Doch wie genau kann ich im Team nun arbeiten, sodass alle immer auf dem selben Stand der Datenbank arbeiten?    <br />Wie immer gibt es mehrere Möglichkeiten, daher zeige ich mal eine Variante raus, die ich persönlich für nicht ganz schlecht halte.</p>  <p><strong>Zentrale Varianten</strong></p>  <p>Wie bereits gesagt gibt es mehrere Variante. Ich könnte irgendwo auf einem zentralen SQL Server eine Datenbank einrichten und alle greifen darauf zu. Vorteil hier wäre, dass nicht auf jeder Maschine ein SQL Server (in welcher Art auch immer) installiert sein muss. Negativ ist natürlich, dass der einzelne Entwickler beeinträchtigt wird, wenn an der DB rumgebastelt wird. Ungünstig wird es auch, wenn man nicht ständig im selben Netz ist. Bei einem Hobbyprojekt/Open Source Projekt wäre es nicht möglich eine zentrale Instanz zu haben.</p>  <p><strong>Autarke Variante - unsere Vorbedingungen</strong></p>  <p>Bei <a href="http://www.bizzbingo.de/">BizzBingo</a> (<a href="http://businessbingo.codeplex.com/">Codeplex</a>) haben wir uns für diese Variante entschieden: </p>  <ul>   <li>Jeder Entwickler hat einen SQL Server bei sich installiert </li>    <li>Die Datenbank heisst bei allen Entwicklermaschinen gleich </li>    <li>Beim SQL Server ist Windows Authentifzierung aktiviert und es gibt keinen speziellen Account </li>    <li>Im Source Control werden nur SQL Scripts gespeichert      <ul>       <li>Keine .mdf Datei oder ähnliches ist im Source Control! </li>     </ul>   </li> </ul>  <p><strong><u>Nur SQL Scripts? JA!</u></strong></p>  <p>Das Entity Framework oder NHibernate können recht einfach anhand eines Models ein DB Schema erstellen. Die Frage ist natürlich: Was nützt das später? Irgendwann hat man Version 1.0 seiner Anwendung erstellt und diese läuft. </p>  <p><strong>Version 1.1 - wie geschieht das Update?</strong></p>  <p>Jetzt entwickeln wir weiter und kommen zu einer interessanten Frage: Wie update ich denn meinen Produktivdatenbank?    <br /><u>Den fehleranfälligsten Weg (weil schlecht reproduzierbar) :</u> Im SQL Management Studio rumklicken und rumfummeln. Ein kleinen Bonus bekommt man, wenn man sich wenigstens die SQL Scripts die das Management Studio erzeugt speichert und so dies auf dem Produktivsystem wiederherstellen kann. Das ist aber alles recht doof. Wer zudem SQL Azure einsetzen möchte und sich mit dem Management Studio dahin verbindet wird feststellen, dass es da keinen Designer gibt - es bleiben nur Scripts :)</p>  <p><strong>Unsere Vorgehen bei BizzBingo:</strong></p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1178.png"><img style="border-right-width: 0px; margin: 0px 10px 0px 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb360.png" width="169" height="244" /></a> </p>  <p>Wir haben irgendwann uns ein initiales Set an Datenbank Tabellen und Demodatensätzen überlegt. Dafür sind die InitScripts da:</p>  <p><strong>InitSchema.sql</strong> ist quasi die Version 1.0 der DB - ohne Daten.     <br /><strong>InitData.sql</strong> sind für Testdaten gedacht.</p>  <p>Bei Updates an der Datenbank haben wir ein "UpdateScripts” Ordner, welche pro Datenbank Anpassungen SQL Scripts enthält. Die neueren&#160; SQL Script laufen auch in einer Transaktion.</p>  <p>Beispiel - hierbei haben wir Mehrsprachigkeit in unser "Wörter Tabelle” reingebracht:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:505c130a-7988-4b97-b9e8-84169b10393b" class="wlWriterEditableSmartContent"><pre name="code" class="c#"> begin transaction DataUpdate
begin try

	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'empower', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'communicate', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'skill set', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'think outside the box', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'gap analysis', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'validate', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'revenue', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'heavy lifting', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'value-added', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'networking', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'go the extra mile', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'big picture', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'stretch the envelope', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'client-focused', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'bottom line', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'bleeding edge', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'recognition', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'ramp up', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'business case', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'train wreck', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'bucketize', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'exponential', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'synergize', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'knowledge management', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'quality gap', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'disintermediate', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'goal', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'fast track', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'actualize', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'operationalize', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'cash-neutral', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'implementation', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'phase', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'risk management', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'backward-compatible', 0, '1033')
	INSERT [dbo].[Word] ([Id], [Value], [Rating], [LCID]) VALUES (NEWID(), N'adaptive', 0, '1033')
	
	update [Version]
	set VersionNr = '1.4'
	print 'VersionNr updated to 1.4'
	
	commit transaction DataUpdate
	print 'transaction "DataUpdate" committed'
end try
begin catch
	rollback transaction DataUpdate
	print 'transaction "DataUpdate" rolled back'
end catch</pre></div>

<p>Wie bereits in Zeile 42 zu sehen, haben wir in der SQL Datenbank auch eine Version Nummer gespeichert - das Script ist auch von Hand geschrieben und nicht durch das Management Studio generiert wurden.</p>

<p><strong>"Automatisiertes” Updates</strong></p>

<p>Wenn <a href="http://twitter.com/kenkosmowski">Ken</a>, mein Mitstreiter im Projekt, ein Update an der Datenbank Struktur vornehmen möchte (also Version 1.7), dann entwickelt er das auf seiner Maschine und speichert das Update SQL Script im Source Control. </p>

<p>Da wir ein recht kleines Team sind, ist der nächste Schritt nicht 100% automatisiert: Ich hole mir die neusten Sourcen ab und seh natürlich, dass es eine neues Script gibt. Jetzt führe ich die InitDatabase.bat aus, welche die drei Powershell Scripts aufruft:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:86162811-a042-458f-9c79-efa0b3784f9f" class="wlWriterEditableSmartContent"><pre name="code" class="c#">powershell ToolingScripts\CreateDatabase.ps1 -dbInstance "." -dbName "BusinessBingo"
powershell ToolingScripts\InitDatabase.ps1 -dbInstance "." -dbName "BusinessBingo" -initScriptsFolder "InitScripts"
powershell ToolingScripts\UpdateDatabase.ps1 -dbInstance "." -dbName "BusinessBingo" -updateScriptsFolder "UpdateScripts"</pre></div>

<p><strong>CreateDatabase.ps1 - sauberere DB sicherstellen</strong></p>

<p>Das Script schaut ob es bereits eine Datenbank namens "BusinessBingo” (Benannt nach dem Codeplex Projekt) gibt. Wenn es die DB gibt, löscht er diese und legt eine neue Datenbank namens "BusinessBingo” an. Wenn es die DB vorher nicht gab, legt er sie ebenfalls an. Das Script habe ich von <a href="http://arcware.net/creating-a-sql-server-database-from-powershell/">Dave Donaldsons Blog</a>. Resultat davon: Ein sauberer Startpunkt.</p>

<p></p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:47a4c392-7edc-43da-8b36-34bac5af6738" class="wlWriterEditableSmartContent"><pre name="code" class="c#"># Get the parameters passed to the script
Param($dbInstance, $dbName)
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo")
$dbServer = new-object Microsoft.SqlServer.Management.Smo.Server ($dbInstance)
$db = new-object Microsoft.SqlServer.Management.Smo.Database
# Loop thru the db list to find the one we need. If found, set the local
# vars to avoid errors when trying to delete the db from within the loop.
$found = "false"
foreach ($_ in $dbServer.Databases)
{
if ($_.Name -eq $dbName)
{
$db = $_
$found = "true"
}
}
# Now that we're out of the loop we can kill the db
if ($found -eq "true")
{
"Deleting database $dbName..."
$dbServer.KillAllProcesses($db.Name)
$dbServer.KillDatabase($db.Name)
}
"Creating database $dbName..."
$db = new-object Microsoft.SqlServer.Management.Smo.Database ($dbServer, $dbName)
$db.Create()</pre></div>

<p></p>

<p><strong>InitDatabase.ps1 - Version 1.0 herstellen</strong></p>

<p>Als nächsten Schritt wird in der .bat das Powershell Script zum Initialisieren der DB aufgerufen. Hierbei wird nur das InitSchema.sql und InitData.sql gegen die lokale DB aufgerufen.</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c8691d76-5d21-49d9-ac8d-ade4ce7c2ea8" class="wlWriterEditableSmartContent"><pre name="code" class="c#">Param($dbInstance, $dbName, $initScriptsFolder)
"InitDatabase..."

"Execute SchemaSql..."
sqlps Invoke-Sqlcmd -ServerInstance "$dbInstance" -Database "$dbName" -InputFile "$initScriptsFolder\InitSchema.sql" 

"Execute DataSql..."
sqlps Invoke-Sqlcmd -ServerInstance "$dbInstance" -Database "$dbName" -InputFile "$initScriptsFolder\InitData.sql" </pre></div>

<p></p>

<p></p>

<p></p>

<p><strong>UpdateDatabase.ps1 - alle Versionen herstellen</strong></p>

<p>Nachdem wir nun die Version 1.0 der Datenbank hergestellt haben, werden alle SQL Scripte im UpdateScripts Verzeichnis gesucht und nacheinander aufgerufen.</p>

<p></p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:cdcf6fa3-12d4-4bca-9ea6-ad3702b6c64f" class="wlWriterEditableSmartContent"><pre name="code" class="c#">Param($dbInstance, $dbName, $updateScriptsFolder)

# find all scripts in update dir
$UpdateDir = get-childitem $updateScriptsFolder
$List = $UpdateDir | where {$_.extension -eq ".sql"}
"UpdateScripts found:"
$List | format-table name
foreach ($updateSql in $List)
{
	 "Execute $updateSql"
     sqlps Invoke-Sqlcmd -ServerInstance "$dbInstance" -Database "$dbName" -InputFile "$updateScriptsFolder\$updateSql" 
}</pre></div>

<p></p>

<p><strong>Alles über einen einzigen Klick auf die InitDatabase.bat</strong></p>

<p>Das "entspannende” an dieser Variante: Man kann wirklich sicher gehen, dass die Scripts immer - also kontinuierlich - geprüft werden. Durch die Update Scripts ist zudem sichergestellt, dass die Scripts einfach auch auf dem Produktivsystem angewandt werden können und <strong>wirklich auch funktionieren</strong>!</p>

<p><strong>Was ist mit Unit Tests?</strong></p>
<strong></strong>

<p>Thomas Bandt hat in einem Blogpost beschrieben, wie <a href="http://blog.thomasbandt.de/39/2332/de/blog/repositories-testen.html">Repository Tests aussehen könnten</a>. Den Gedanken fanden wir nicht schlecht.</p>

<p>Thomas sein Vorschlag war das Feature vom Entity Framework nutzen: Aus einem Model ein Datenbank per Code erstellen. Was wir aber erreichen wollten: Immer sicherstellen, dass die Update Scripts, welche im Source Control sind, auch wirklich funktionieren. </p>

<p>Ähnlich wie Thomas haben wir eine Basisklasse, von den alle anderen Repository Tests ableiten (den vollen Code könnt ihr auf <a href="http://businessbingo.codeplex.com/">Codeplex</a> anschauen) :</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:0353d8ea-c825-44d0-985c-a81ad62b2d9c" class="wlWriterEditableSmartContent"><pre name="code" class="c#">...

namespace BusinessBingo.Data.Tests
{
    [Category(TestCategories.RepositoryTests)]
    public abstract class ConcernOf&lt;T&gt; : BaseTestFixture
    {
        ...

        protected ConcernOf()
        {
            ...
        }

        protected void Init()
        {
            ...
            this._databaseHelper.InitTestDatabase();
        }

        public abstract void Setup();

        [CleanUp]
        public abstract void CleanUp();
    }
}
</pre></div>

<p>Im Init wird unser DatabaseHelper aufgerufen. Hier ist ein ähnliches Spiel wie in dem "CreateDatabase.ps1” zu finden. Über das Entity Framework Model (was wir als Repository-Schicht nutzen), fragen wir ob die Datenbank existiert. Hier müssen wir wieder einen sauberen Stand erhalten. </p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:805445d1-7871-4631-97cb-4a7032d98812" class="wlWriterEditableSmartContent"><pre name="code" class="c#">        public void InitTestDatabase()
        {
            if (this._efModel.DatabaseExists() == false)
            {
                this.CreateTestDatabase();
            }
            else
            {
                string required = this.GetRequiredVersion();
                string current = this.GetCurrentVersion();
                if(required.Equals(current) == false)
                {
                    this.DeleteDatabase();
                    this.CreateTestDatabase();
                }
            }

            if (this._efModel.DatabaseExists() == false)
                throw new SystemException("Die Datenbank konnte nicht erstellt werden");

            this.CleanUpDatabase();
            this.InsertTestData();
        }</pre></div>

<p>CreateTestDatabase, welches zwangsläufig aufgerufen wird. Hier rufen wir vom .NET Code die Powershell Befehle auf. Daher haben die Powershell Scripts auch ein paar zusätzliche Parameter entgegengenommen, damit sie auch von den Unit Tests aufrufbar sind.</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:896d02c8-3cb4-4291-9c1e-36231995144a" class="wlWriterEditableSmartContent"><pre name="code" class="c#"> public void CreateTestDatabase()
        {
            Runspace runspace = RunspaceFactory.CreateRunspace();
            runspace.Open();

            string dbInstance = ".";
            string dbName = "BusinessBingoTestDatabase";
            string scriptParameters = string.Format("-dbInstance {0} -dbName {1}", dbInstance, dbName);

            string toolingScriptFolder = string.Format(@"{0}\ToolingScripts", this._databaseFolder);
            Pipeline pipeline = runspace.CreatePipeline();

            string createDatabaseCommand = string.Format(@"{0}\CreateDatabase.ps1 {1}", toolingScriptFolder, scriptParameters);
            pipeline.Commands.AddScript(createDatabaseCommand);

            string initScriptsFolder = string.Format(@"{0}\InitScripts", this._databaseFolder);
            string initDatabaseScriptParameters = string.Format("{0} -initScriptsFolder {1}", scriptParameters,
                                                                initScriptsFolder);
            string initDatabaseCommand = string.Format(@"{0}\InitDatabase.ps1 {1}", toolingScriptFolder, initDatabaseScriptParameters);
            pipeline.Commands.AddScript(initDatabaseCommand);

            string updateScriptsFolder = string.Format(@"{0}\UpdateScripts", this._databaseFolder);
            string updateDatabaseScriptParameters = string.Format("{0} -updateScriptsFolder {1}", scriptParameters,
                                                                updateScriptsFolder);
            string updateDatabaseCommand = string.Format(@"{0}\UpdateDatabase.ps1 {1}", toolingScriptFolder, updateDatabaseScriptParameters);
            pipeline.Commands.AddScript(updateDatabaseCommand);

            pipeline.Commands.Add("Out-String");

            Collection&lt;PSObject&gt; results = pipeline.Invoke();

            runspace.Close();
        }</pre></div>

<p>Im Grunde werden hier nur die 3 Powershell-Scripte wieder aufgerufen und es geschieht dasselbe wie bei der InitDatabase.bat.</p>

<p>Die Testdaten für die Repository-Tests werden allerdings über das EF erzeugt, so wie das auch Thomas gemacht hat.</p>

<p><strong>"Sicherheitsgefühl”</strong></p>

<p>Das sieht recht kompliziert aus? Eigentlich nicht, da das meiste anhand von Konventionen im späteren Verlauf automatisch geschieht. Was wir damit erreichen ist aber ein hohes Gut: Sicherheit. Wir wissen, dass wir auf Knopfdruck eine Datenbank auf einem neuen System aufsetzen können und wir sind sicher, dass wir eine DB mit Hilfe der Scripts auf den aktuellsten Stand bringen können. </p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1179.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb361.png" width="502" height="400" /></a> </p>

<p><strong>Wichtige Randbedingungen</strong></p>

<p>Natürlich müssen die Scripte entsprechende Daten auch migrieren und nicht nur das Schema. Dies ist momentan aufgrund der Tatsache, dass es nur ein Hobbyprojekt ist und noch völlig unbekannt ist, etwas in den Hintergrund getreten - wir hatten an einer Stelle mal einen "harten” Schnitt gemacht, weil es sich nicht gelohnt hatte für Demodatensätze Migrationsscripts zu schreiben. Allerdings ist das natürlich mit den Methoden auch durchführbar. </p>

<p><strong>Andere Techniken</strong></p>

<p>Ich weiß von Kollegen, dass es noch eine Visual Studio Projekt Template für Datenbank-Sachen gibt und das man da auch tolle Sachen mit machen kann. Gestern hatte ich noch diesen <a href="http://rachelappel.com/deployment/database-deployment-with-the-vs-2010-package-publish-database-tool/">Blogpost</a> entdeckt. Momentan kommen wir mit der Methode aber auch gut klar. </p>
