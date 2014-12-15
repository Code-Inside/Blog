---
layout: post
title: "Best Practice: version check, data base and DB updates... how to split the db in the team?"
date: 2011-03-06 16:10
author: CI Team
comments: true
categories: [Best Practise]
tags: [data base, version check]
language: en
---
{% include JB/setup %}

  <p><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb359.png" width="124" height="179" />Almost in every development step in the field of web-development is a data base involved. Also there is a system to control the version (I hope so). But how is it possible to work in team so that everyone is able to use the newest version of the database?</p>  <p>Like always, there are many solutions. I´ve chosen this way because for me it´s the best one.</p>  
  <!--more-->  <p><b>Central alternative</b></p>  <p>Like i said before, there are several alternatives. For example I could create a data base on a central SQL server and everyone access on this. Advantage: you don´t need to install an SQL-Server on every machine. Disadvantages: The developer in particular will be influenced if you work on the DB. It´s also bad if you didn´t work on the same network all the time. In an Open Source Project or a hobby project it won´t be able to have a central instance anyway. </p>  <p><b>Autarkic alternative - our conditions</b></p>  
  <p>During our <a href="http://www.bizzbingo.com/">BizzBingo</a> (<a href="http://businessbingo.codeplex.com/">Codeplex</a>) we decided this alternative:</p>  <p>- Every developer has his own SQL server installed</p>  <p>- The data base is named equal on every developer machine </p>  <p>- On the SQL server Windows authentication is activated and there is no special account</p>  <p>- Only SQL scripts will be saved on the Source control</p>  <p>- No .mdf files or anything like that are on the source control</p>  <p><b>SQL Script only? - YES!</b></p>  <p>The Entity framework or NHibernate are able to create the model of a db scheme easily. The question is: what is this good for? Someday you will finish your version 1.0 of your application and it will run.</p>  <p><b>Version 1.1 - how does the update work?</b></p>  <p>Now we go on developing and get to an interesting question: How do I update my productfilebase? </p>  <p><u>The way with the highest possibility of making mistakes: </u>Click around wildly in your SQL management studio. You will get a little plus if you saved the SQL scripts which are created by the management studio and reboot them on the productivity system. But this is stupid. If you use SQL Azure you will see, that there is no designer just scripts <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-smile" alt="Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-smile6.png" /></p>  <p><b>How we solved it on BizzBingo</b>:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images-en/image134.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb42.png" width="166" height="240" /></a>We thought about an initial set of data bases, tables and demo files. Therefore we used the UnitScripts:</p>  <p><b>InitSchema.sql</b> is like the Version 1.0 of the file base without files.</p>  <p><b>InitData.sql</b> is made for test files. </p>  <p>If an update of the data base is necessary we use an "UpdateScript" folder which contains SQL Scripts for every data base update. The newest SQL scripts work in the transaction. </p>  <p>Example - here we included different languages in our "word table": </p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:122ff7a4-013d-497a-b009-3621a725ccde" class="wlWriterEditableSmartContent"><pre name="code" class="c#"> begin transaction DataUpdate
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

<p>Like you see in line 42 we saved a version number in the SQL data base - the script is written by our self and not with the management studio. </p>

<p><b>"Automatically" updates </b></p>




<p>If <a href="http://twitter.com/kenkosmowski">Ken</a>, who is my made in this project, makes an update on the data base structure (Version 1.7) than he do so on his machine and save the update SQL script in the source control. </p>

<p>Because we are a little team the next step isn´t that automatically. I pick up the newest source and recognize there is a new script. Now I´m going to run the InitDatabase.bat which will call the three Powershell Scripts: </p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c562ef84-d371-4ef5-8c72-9d7b2ea7b9cb" class="wlWriterEditableSmartContent"><pre name="code" class="c#">powershell ToolingScripts\CreateDatabase.ps1 -dbInstance "." -dbName "BusinessBingo"
powershell ToolingScripts\InitDatabase.ps1 -dbInstance "." -dbName "BusinessBingo" -initScriptsFolder "InitScripts"
powershell ToolingScripts\UpdateDatabase.ps1 -dbInstance "." -dbName "BusinessBingo" -updateScriptsFolder "UpdateScripts"</pre></div>

<p><b>CreateDatabase.ps1 - save data base clean </b></p>

<p>The script looks up if there is another file base named "BusinessBingo". If there is one he will delete the old and creates the new one with the same name. If there wasn´t one before he is going to save this one. This script is from the blog of <a href="http://arcware.net/creating-a-sql-server-database-from-powershell/">Dave Donaldson</a>. </p>

<p>Result: a clean start point:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:60735b96-cb51-427d-a3be-4290d101531d" class="wlWriterEditableSmartContent"><pre name="code" class="c#"># Get the parameters passed to the script
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

<p><b>InitDatabase.ps1 - create Version 1.0</b></p>

<p>In the next step we will open the .bat powershell script to initialize the DB. Just the InitScheme.sql and the InitData.sql will be opened.</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5118e242-b4e1-46e8-8aec-bb5dd0d822cf" class="wlWriterEditableSmartContent"><pre name="code" class="c#">Param($dbInstance, $dbName, $initScriptsFolder)
"InitDatabase..."

"Execute SchemaSql..."
sqlps Invoke-Sqlcmd -ServerInstance "$dbInstance" -Database "$dbName" -InputFile "$initScriptsFolder\InitSchema.sql" 

"Execute DataSql..."
sqlps Invoke-Sqlcmd -ServerInstance "$dbInstance" -Database "$dbName" -InputFile "$initScriptsFolder\InitData.sql" </pre></div>

<p><b>UpdateDatabase.ps1 - create all versions</b></p>

<p>After we´ve created version 1.0 data base all SQL scripts in UpdateScripts directories will be searched and opened.</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:aef8a23c-667b-403b-9c11-998806b6b7b8" class="wlWriterEditableSmartContent"><pre name="code" class="c#">Param($dbInstance, $dbName, $updateScriptsFolder)

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

<p><b>This happens after one click on InitDatabase.bat</b></p>

<p>The "relaxing" of this alternative: You can be sure that these scripts will be checked ever and ever. </p>

<p>With the update scripts it is sure that the scripts will be used on the productivity system and they will work!</p>

<p><b>What´s with the Unit Tests?</b></p>

<p>Thomas Brandt describes in his blogpost how <a href="http://blog.thomasbandt.de/39/2332/de/blog/repositories-testen.html">Repository Tests could look like.</a> We thought this is a good alternative. </p>

<p>Thomas idea was to use the feature of Entity framework: create a data base from a model with a code. What we want to reach: Be sure that the update scripts, which are in the source control, are always work properly. </p>

<p>Like Thomas we have a basic class from which all Repository Tests start (if you want to see the full code take a look on <a href="http://businessbingo.codeplex.com/">Codeplex</a>) :</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:90251a43-5a88-475c-9242-cda8290a15c8" class="wlWriterEditableSmartContent"><pre name="code" class="c#">...

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

<p>In the Init our DatabaseHelper will be called. Here you will find the same game like in the "CreateDatabase.ps1". With the Entity framework model (which we used as repository layer), we ask if the data base exists.</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c8f358a8-2f4a-446c-9ffd-c818a7d82fa1" class="wlWriterEditableSmartContent"><pre name="code" class="c#">        public void InitTestDatabase()
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

<p>CreateTestDatabase, which will be opened anyway. Here we call the powershell order from the .NET code. Because of this the Powershell scripts took some parameters more so you can start them from the unit tests as well.</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:cb2f2f5a-88c0-44e1-ba14-0904e686c6ac" class="wlWriterEditableSmartContent"><pre name="code" class="c#"> public void CreateTestDatabase()
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

<p>In fact just the three powershell - scripts will be opened and the same thing will happen like in the InitDatabase.bat.</p>

<p><b>"Feeling save"</b></p>

<p>This looks quite complicated? I don´t think so because mostly it will be done by conventions later. </p>

<p>But what we reach with this is a high property: safety. We know that we are able to create a new data base with just one click and we also know that we are able to update a db with the help of the script. </p>

<p><b><a href="{{BASE_PATH}}/assets/wp-images-en/image135.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb43.png" width="456" height="363" /></a></b></p>




<p><b>Important conditions </b></p>

<p>Of course the scripts need to migrate the files and not only the shames. Actually this isn´t that important because it´s just an unknown hobby project at the moment. We´ve stopped this at one step because it wasn´t useful to write migrationsscripts for demos. </p>

<p><b>Other technics</b></p>

<p>Some of my associates told me about the opportunity to do this data base stuff with a Visual Studio project template. Yesterday I found this <a href="http://rachelappel.com/deployment/database-deployment-with-the-vs-2010-package-publish-database-tool/">blogpost</a>. But at the moment we use this one. </p>
