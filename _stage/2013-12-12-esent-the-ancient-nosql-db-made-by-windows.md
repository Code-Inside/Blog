---
layout: post
title: "ESENT – the „ancient NoSQL DB“ made by Windows"
date: 2013-12-12 22:18
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: []
---
{% include JB/setup %}
<p>&nbsp; <p><img title="image.png" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; padding-right: 0px" border="0" alt="image.png" src="http://code-inside.de/blog/wp-content/uploads/image1915.png" width="438" height="83"> <p>Those of you who use RavenDB might have heard about ESENT already. In the inside RavenDB uses the “<a href="http://en.wikipedia.org/wiki/Extensible_Storage_Engine">Extensible Storage Engine</a>” which is included into Windows since XP. Read here why Ayende is looking for an <a href="http://ayende.com/blog/162593/why-leveldb-all-of-a-sudden">alternative</a> for a while – although ESENT is basically reliable but that’s just a side note.  <p>ESENT is used by Microsoft in many different areas – like the Active-Directory or the Exchange Mailbox information’s. So basically it is used whenever a huge amount of information’s need some structure. I’m going to quote this <a href="http://www.jondavis.net/techblog/post/2010/08/30/Esent-The-Decade-Old-Database-Engine-That-Windows-(Almost)-Always-Had.aspx">Blogpost</a> because it describes the features of ESENT pretty well.  <p><em><b>Features</b></em> <p><em>Significant technical features of ESENT include:</em> <p><em>-</em><i> </i><em>ACID transactions with savepoints, lazy commits, and robust crash recovery.</em><i> </i><i><br><em>-</em> <em>Snapshot isolation.</em><br><em>-</em> <em>Record-level locking (multi-versioning provides non-blocking reads).</em><br><em>- Highly concurrent database access.</em><br><em>-</em> <em>Flexible meta-data (tens of thousands of columns, tables, and indexes are possible).</em><br><em>-</em> <em>Indexing support for integer, floating point, ASCII, Unicode, and binary columns.</em><br><em>-</em> <em>Sophisticated index types, including conditional, tuple, and multi-valued.</em><br><em>-</em> <em>Columns that can be up to 2GB with a maximum database size of 16TB.</em></i> <p><em>Note: The ESENT database file cannot be shared between multiple processes simultaneously. ESENT works best for applications with simple, predefined queries; if you have an application with complex, ad-hoc queries, a storage solution that provides a query layer will work better for you.</em> <p><b></b>&nbsp; <p><b>First steps with ESENT – ManagedESENT</b> <p>Of course it is possible to talk in <a href="http://stackoverflow.com/questions/5311252/setting-up-a-basic-esent-for-c-example">C++ to ESENT</a> but it just doesn’t look right. A better alternative is: <p>&nbsp; <p><img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; padding-right: 0px" border="0" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image1915.png" width="438" height="83"> <p>The project consists of two different parts: <p>- A .NET wrapper to ESENT.dll <p>- PersistentDictionary which takes the .NET wrapper and offers a nice API <p>Additionally you’ll get some additional documentation.  <p><b></b>&nbsp; <p><b>.NET wrapper</b> <p>Who plans to use ESENT in a more “pure” way could use the .NET wrapper. But you better know the insides of ESENT before you do so. Here is the code of a low-level <a href="http://managedesent.codeplex.com/wikipage?title=ManagedEsentSample&amp;referringTitle=ManagedEsentDocumentation">sample-application.</a> <p>&nbsp;</p> <div id="scid:9D7513F9-C04C-4721-824A-2B34F0212519:3f6b1158-fd42-4de2-9ed2-cd4659e45095" class="wlWriterEditableSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre style=" width: 932px; height: 303px;background-color:White;overflow: auto;"><div><!--

Code highlighting produced by Actipro CodeHighlighter (freeware)
http://www.CodeHighlighter.com/

--><span style="color: #000000;">
</span><span style="color: #0000FF;">namespace</span><span style="color: #000000;"> EsentSample
{
    </span><span style="color: #0000FF;">using</span><span style="color: #000000;"> System;
    </span><span style="color: #0000FF;">using</span><span style="color: #000000;"> System.Text;
    </span><span style="color: #0000FF;">using</span><span style="color: #000000;"> Microsoft.Isam.Esent.Interop;

    </span><span style="color: #0000FF;">public</span><span style="color: #000000;"> </span><span style="color: #0000FF;">class</span><span style="color: #000000;"> EsentSample
    {
        </span><span style="color: #808080;">///</span><span style="color: #008000;"> </span><span style="color: #808080;">&lt;summary&gt;</span><span style="color: #008000;">
        </span><span style="color: #808080;">///</span><span style="color: #008000;"> Main routine. Called when the program starts.
        </span><span style="color: #808080;">///</span><span style="color: #008000;"> </span><span style="color: #808080;">&lt;/summary&gt;</span><span style="color: #008000;">
        </span><span style="color: #808080;">///</span><span style="color: #008000;"> </span><span style="color: #808080;">&lt;param name=&quot;args&quot;&gt;</span><span style="color: #008000;">
        </span><span style="color: #808080;">///</span><span style="color: #008000;"> The arguments to the program.
        </span><span style="color: #808080;">///</span><span style="color: #008000;"> </span><span style="color: #808080;">&lt;/param&gt;</span><span style="color: #808080;">
</span><span style="color: #000000;">        </span><span style="color: #0000FF;">public</span><span style="color: #000000;"> </span><span style="color: #0000FF;">static</span><span style="color: #000000;"> </span><span style="color: #0000FF;">void</span><span style="color: #000000;"> Main(</span><span style="color: #0000FF;">string</span><span style="color: #000000;">[] args)
        {
            JET_INSTANCE instance;
            JET_SESID sesid;
            JET_DBID dbid;
            JET_TABLEID tableid;

            JET_COLUMNDEF columndef </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #0000FF;">new</span><span style="color: #000000;"> JET_COLUMNDEF();
            JET_COLUMNID columnid;

            </span><span style="color: #008000;">//</span><span style="color: #008000;"> Initialize ESENT. Setting JET_param.CircularLog to 1 means ESENT will automatically
            </span><span style="color: #008000;">//</span><span style="color: #008000;"> delete unneeded logfiles. JetInit will inspect the logfiles to see if the last
            </span><span style="color: #008000;">//</span><span style="color: #008000;"> shutdown was clean. If it wasn't (e.g. the application crashed) recovery will be
            </span><span style="color: #008000;">//</span><span style="color: #008000;"> run automatically bringing the database to a consistent state.</span><span style="color: #008000;">
</span><span style="color: #000000;">            Api.JetCreateInstance(</span><span style="color: #0000FF;">out</span><span style="color: #000000;"> instance, </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">instance</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
            Api.JetSetSystemParameter(instance, JET_SESID.Nil, JET_param.CircularLog, </span><span style="color: #800080;">1</span><span style="color: #000000;">, </span><span style="color: #0000FF;">null</span><span style="color: #000000;">);
            Api.JetInit(</span><span style="color: #0000FF;">ref</span><span style="color: #000000;"> instance);
            Api.JetBeginSession(instance, </span><span style="color: #0000FF;">out</span><span style="color: #000000;"> sesid, </span><span style="color: #0000FF;">null</span><span style="color: #000000;">, </span><span style="color: #0000FF;">null</span><span style="color: #000000;">);

            </span><span style="color: #008000;">//</span><span style="color: #008000;"> Create the database. To open an existing database use the JetAttachDatabase and
            </span><span style="color: #008000;">//</span><span style="color: #008000;"> JetOpenDatabase APIs.</span><span style="color: #008000;">
</span><span style="color: #000000;">            Api.JetCreateDatabase(sesid, </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">edbtest.db</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">, </span><span style="color: #0000FF;">null</span><span style="color: #000000;">, </span><span style="color: #0000FF;">out</span><span style="color: #000000;"> dbid, CreateDatabaseGrbit.OverwriteExisting); 

            </span><span style="color: #008000;">//</span><span style="color: #008000;"> Create the table. Meta-data operations are transacted and can be performed concurrently.
            </span><span style="color: #008000;">//</span><span style="color: #008000;"> For example, one session can add a column to a table while another session is reading
            </span><span style="color: #008000;">//</span><span style="color: #008000;"> or updating records in the same table.
            </span><span style="color: #008000;">//</span><span style="color: #008000;"> This table has no indexes defined, so it will use the default sequential index. Indexes
            </span><span style="color: #008000;">//</span><span style="color: #008000;"> can be defined with the JetCreateIndex API.</span><span style="color: #008000;">
</span><span style="color: #000000;">            Api.JetBeginTransaction(sesid);
            Api.JetCreateTable(sesid, dbid, </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">table</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">, </span><span style="color: #800080;">0</span><span style="color: #000000;">, </span><span style="color: #800080;">100</span><span style="color: #000000;">, </span><span style="color: #0000FF;">out</span><span style="color: #000000;"> tableid);
            columndef.coltyp </span><span style="color: #000000;">=</span><span style="color: #000000;"> JET_coltyp.LongText;
            columndef.cp </span><span style="color: #000000;">=</span><span style="color: #000000;"> JET_CP.ASCII;
            Api.JetAddColumn(sesid, tableid, </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">column1</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">, columndef, </span><span style="color: #0000FF;">null</span><span style="color: #000000;">, </span><span style="color: #800080;">0</span><span style="color: #000000;">, </span><span style="color: #0000FF;">out</span><span style="color: #000000;"> columnid);
            Api.JetCommitTransaction(sesid, CommitTransactionGrbit.LazyFlush);

            </span><span style="color: #008000;">//</span><span style="color: #008000;"> Insert a record. This table only has one column but a table can have slightly over 64,000
            </span><span style="color: #008000;">//</span><span style="color: #008000;"> columns defined. Unless a column is declared as fixed or variable it won't take any space
            </span><span style="color: #008000;">//</span><span style="color: #008000;"> in the record unless set. An individual record can have several hundred columns set at one
            </span><span style="color: #008000;">//</span><span style="color: #008000;"> time, the exact number depends on the database page size and the contents of the columns.</span><span style="color: #008000;">
</span><span style="color: #000000;">            Api.JetBeginTransaction(sesid);
            Api.JetPrepareUpdate(sesid, tableid, JET_prep.Insert);
            </span><span style="color: #0000FF;">string</span><span style="color: #000000;"> message </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">Hello world</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">;
            Api.SetColumn(sesid, tableid, columnid, message, Encoding.ASCII);
            Api.JetUpdate(sesid, tableid);
            Api.JetCommitTransaction(sesid, CommitTransactionGrbit.None);    </span><span style="color: #008000;">//</span><span style="color: #008000;"> Use JetRollback() to abort the transaction

            </span><span style="color: #008000;">//</span><span style="color: #008000;"> Retrieve a column from the record. Here we move to the first record with JetMove. By using
            </span><span style="color: #008000;">//</span><span style="color: #008000;"> JetMoveNext it is possible to iterate through all records in a table. Use JetMakeKey and
            </span><span style="color: #008000;">//</span><span style="color: #008000;"> JetSeek to move to a particular record.</span><span style="color: #008000;">
</span><span style="color: #000000;">            Api.JetMove(sesid, tableid, JET_Move.First, MoveGrbit.None);
            </span><span style="color: #0000FF;">string</span><span style="color: #000000;"> buffer </span><span style="color: #000000;">=</span><span style="color: #000000;"> Api.RetrieveColumnAsString(sesid, tableid, columnid, Encoding.ASCII);
            Console.WriteLine(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">{0}</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">, buffer);

            </span><span style="color: #008000;">//</span><span style="color: #008000;"> Terminate ESENT. This performs a clean shutdown.</span><span style="color: #008000;">
</span><span style="color: #000000;">            Api.JetCloseTable(sesid, tableid);
            Api.JetEndSession(sesid, EndSessionGrbit.None);
            Api.JetTerm(instance);
        }
    }
}</span></div></pre><!-- Code inserted with Steve Dunn's Windows Live Writer Code Formatter Plugin.  http://dunnhq.com --></div>
<p>All it does is to save one value – that’s it. Uhhh… I know but as I said before it is Low-Level ;-) 
<p>A better inside is available in the <a href="http://managedesent.codeplex.com/SourceControl/latest#EsentInteropSamples/StockSample/StockSample.cs">Stock-Sample</a>. In this example a complex data base is created by using the ManagedEsent API and it saves stock information’s. But there is still an easier way:
<p><b></b>
<p><b></b>&nbsp; <p><b>Persistent Dictionary</b>
<p>This alternative behaves mainly like a dictionary – but saved as an Esent-database. There are some more details in the <a href="http://managedesent.codeplex.com/wikipage?title=PersistentDictionaryDocumentation">documentation</a>.
<p>&nbsp;</p>
<div id="scid:9D7513F9-C04C-4721-824A-2B34F0212519:447b482b-a80b-47a6-b4bf-465d3aac6ea1" class="wlWriterEditableSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre style=" width: 932px; height: 303px;background-color:White;overflow: auto;"><div><!--

Code highlighting produced by Actipro CodeHighlighter (freeware)
http://www.CodeHighlighter.com/

--><span style="color: #0000FF;">public</span><span style="color: #000000;"> </span><span style="color: #0000FF;">static</span><span style="color: #000000;"> </span><span style="color: #0000FF;">void</span><span style="color: #000000;"> Main(</span><span style="color: #0000FF;">string</span><span style="color: #000000;">[] args)
        {
            var dictionary </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #0000FF;">new</span><span style="color: #000000;"> PersistentDictionary</span><span style="color: #000000;">&lt;</span><span style="color: #0000FF;">string</span><span style="color: #000000;">, </span><span style="color: #0000FF;">string</span><span style="color: #000000;">&gt;</span><span style="color: #000000;">(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">Names</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);

            Console.WriteLine(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">What is your first name?</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
            </span><span style="color: #0000FF;">string</span><span style="color: #000000;"> firstName </span><span style="color: #000000;">=</span><span style="color: #000000;"> Console.ReadLine();
            </span><span style="color: #0000FF;">if</span><span style="color: #000000;"> (dictionary.ContainsKey(firstName))
            {
                Console.WriteLine(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">Welcome back {0} {1}</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">,
                    firstName,
                    dictionary[firstName]);
            }
            </span><span style="color: #0000FF;">else</span><span style="color: #000000;">
            {
                Console.WriteLine(
                    </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">I don't know you, {0}. What is your last name?</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">,
                    firstName);
                dictionary[firstName] </span><span style="color: #000000;">=</span><span style="color: #000000;"> Console.ReadLine();
            }
        }</span></div></pre><!-- Code inserted with Steve Dunn's Windows Live Writer Code Formatter Plugin.  http://dunnhq.com --></div>
<p>The code is quite simple and in the background a folder named “Names” is created. That’s where the Esent database is situated:
<p><img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; padding-right: 0px" border="0" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb1056.png" width="488" height="168">
<p>Unfortunately I don’t know if it’s possible to readout the information with a tool (without code).
<p><b></b>&nbsp; <p><b>About the Performance</b>
<p>It takes a while to enter 1.000.000 entries into a database with using a PersistentDictionary and it takes even longer with using GUIDs instead of Integer. Maybe it takes some time to get expressive numbers. The team published some performance information <a href="http://managedesent.codeplex.com/wikipage?title=SystemStats">here</a> and <a href="http://managedesent.codeplex.com/wikipage?title=PersistentDictionaryDocumentation">here</a>.
<p><b></b>&nbsp; <p><b>LINQ support!</b>
<p>There is a LINQ support for the PersistentDictionary since <a href="http://blogs.msdn.com/b/laurionb/archive/2011/02/15/managedesent-1-6-released-linq-support-for-persistentdictionary.aspx">Version 1.6</a>.



<p><b></b>&nbsp; <p><b>Windows Store Apps</b>
<p>Since Esent is a part of Windows and some sections might use the API it is possible to use Esent with Windows Store Apps. It should work since <a href="https://managedesent.codeplex.com/SourceControl/list/changesets">version 1.8</a> but it seems like the PersistentDictionary is not supported actually. Read more about it <a href="http://lunarfrog.com/blog/2012/09/23/extensible-storage-engine/">here</a>.
<p><b></b>&nbsp; <p><b>More links about ManagedEsent</b>
<p>- <a href="https://managedesent.codeplex.com/discussions/454692">Performance of Persistent Dictionary (CodePlex Discussion)</a>
<p>- <a href="https://github.com/ayende/managed-esent">Ayendes Fork</a>
<p>- <a href="http://blogs.msdn.com/b/laurionb/">Blog by a Microsoft employee about Esent and the ManagedEsent API</a> 
<p><b></b>
<p><b></b>&nbsp; <p><b>Esent Serialization</b>
<p>Beside the “PersistentDictionary” there is another project using the ManagedEsent:
<p>&nbsp; <p><img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; padding-right: 0px" border="0" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image1917.png" width="504" height="113"></p>
<p>&nbsp;</p>
<p>Basically the project helps to integrate data structures easily in Esent. Have a look on it in <a href="http://esentserialize.codeplex.com/SourceControl/latest#DemoApp/Program.cs">this demo</a>. </p>
<p><b></b>&nbsp; <p><b>Result</b>
<p>Esent has a nasty API but is still used even in Windows 8. With the help of tools like ManagedEsent API, PersistentDictionary and Esent Serialization the first steps are quite easy. If they are the tools of choice depends mainly on the purpose – since there are numerous alternatives. But the fact that RavenDB is partly build on Esent is a proof that it is at least worth a shot. 
<p>P.S.: Since the code in this blogpost is mainly from <a href="http://managedesent.codeplex.com/">official sources</a> I won’t upload anything on GitHub. The necessary ManagedEsent.dll is available on <a href="http://www.nuget.org/packages/ManagedEsent/">NuGet.</a>
<p><b></b>&nbsp; <p><b>Question: Anyone some experience with Esent to share?</b>
