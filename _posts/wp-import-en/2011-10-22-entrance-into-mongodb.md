---
layout: post
title: "Entrance into mongoDB"
date: 2011-10-22 09:40
author: CI Team
comments: true
categories: [Uncategorized]
tags: [MongoDB, NoSQL, RavenDB]
language: en
---
{% include JB/setup %}
&nbsp;

If you are interested in the trend? Subject NoSql you will also here something about <a href="http://www.mongodb.org/">MongoDB</a> soon. What makes mongoDB interesting for me is the promised Performance (even If I didn’t reach the limits with normal data banks yet) and the promise to say goodbye to all this O/R Mapper stuff (here I reach the limits all the time).

Robert has blogged about RavenDB <a href="{{BASE_PATH}}/2011/08/31/nosql-with-ravendb-and-asp-net-mvc/">here</a><strong>.</strong>

<strong>Maybe you are now asking yourself: what’s the different between mongoDB and RavenDB?</strong>

(Beside the funny name (in german “mongo” means something like hillbilly).

In fact this subject is enough for an own blog post. To make it short: It seems like mongoDB is faster, it provides more languages and because of that the community is bigger while RavenDB has a way better integration and the .net scenery.

I prefer mongoDB because I can use it for free also for commercial projects.

So far… where is the Code?

<strong>Installation </strong>



1. <a href="http://www.mongodb.org/downloads">Download</a> mongoDB for Win, OSX, Solaris or Linux:

2. Only thing you have to do by yourself is to create the directory “C\data\db” It’s also possible to configure the pad but mongoDB won’t create one by himself

3. On windows it’s enough to unpack the Zip file and a double click on the mongodb.exe. If you like to you could start mongoDB as a Windows Service.

4. Easy isn’t it? <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile28.png" alt="Zwinkerndes Smiley" />

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border-width: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb560.png" border="0" alt="image" width="530" height="280" />

<strong>Code</strong>



1. Additionally we need the mongoDB.Net driver you will find here: <a href="http://www.mongodb.org/display/DOCS/CSharp+Language+Center">http://www.mongodb.org/display/DOCS/CSharp+Language+Center</a>

2. Now you have to link these two references:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border-width: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb561.png" border="0" alt="image" width="244" height="201" />

3. Now we are able to connect:
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:3bdd4bb2-b5aa-44f5-a20b-826836ba38d2" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">MongoServer server = MongoServer.Create(); // connect to localhost                        

MongoDatabase demo = server.GetDatabase("demo");  // connect to database       

MongoCollection&lt;User&gt; users = demo.GetCollection&lt;User&gt;("users");</pre>
</div>
In line one we start to connect to localhost if nothing else is configured without username/keyword. Line three is going to pass a data bank back to us and line five a “chart”. At this point mongo acts like a ordinary data bank.

4. Add files
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:4d066e6d-9001-4f69-8be0-882c26ad6e8b" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">//insert
for (int i = 0; i &lt; 10; i++)
{
  var result = users.Insert&lt;User&gt;(new User { Name = "Karl", Age = 20 });
}</pre>
</div>
5. Read files
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ab78f792-937d-4009-8509-40ff631505c6" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">var userResult = users.FindAll();
foreach (var item in userResult)
{
 Console.WriteLine(string.Format("{0} - {1}",item.Name,item.Age));
}</pre>
</div>
6. Data model
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:6a911414-81ab-491e-8b88-6564cf454257" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">class User
{
    public ObjectId _id { get; set; }
    public string Name { get; set; }
    public int Age { get; set; }
    public List&lt;ObjectId&gt; Tags { get; set; }
}</pre>
</div>
I’ve used Objectld (belongs to the mongo driver) instead of Guid as type for the ID. The driver is able to handle Guid but it will be written coded BASE64 as a binary field into the data bank and I assume that the homemade Objectld is a lot quicker.

7. n:m – relationship…
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5107675b-1a15-4d9d-9323-7261e6c5abd3" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">//setup second collection
MongoCollection&lt;User&gt; tags = demo.GetCollection&lt;User&gt;("tags"); // add &amp; get a new collecton
tags.Drop();
List&lt;Tag&gt; initialTags = new List&lt;Tag&gt;() { new Tag("Cool"), new Tag("Fast"), new Tag("Jedi"), new Tag("Ninja") };
tags.InsertBatch(initialTags);

//add tags to a user (many to many)
foreach (var item in userResult)
{
    var randomTags = initialTags.Take(new Random().Next(0, 4)).Select(x=&gt;x._id).ToList(); // add some random tags
    item.Tags = new List&lt;ObjectId&gt;(randomTags);
    users.Save(item); // saves changes to mongo
}</pre>
</div>
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b6d79ffa-9882-42bb-ac1a-a84b4b8a15fc" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">class Tag
{
    public Tag(string name)
    {
        Name = name;
    }
    public ObjectId _id { get; set; }
    public string Name { get; set; }
}</pre>
</div>
… they are possible as well if you link it with the ID’s. If it’s necessary to normalize your files is the question but in fact it’s possible.

Now we have two charts one includes users and the other one tags which are able to be sorted to the users. This example shows how to not work with NoSql data banks. (I recognized it afterwards). Usually I would sort the Tags to the user as a text and build be a Map/Reduce query if I want to count the Tags for example and <a href="http://cookbook.mongodb.org/patterns/count_tags/">that’s</a> how this would look like.

<strong>How quick are you?</strong>

Performance tests are a little bit tricky because they are depending on so many things. But I was curious about what will happen if I create many elements and read them out.

So I’ve applied 10000 different user types, read them and deleted them afterwards:
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:1323e8c9-3009-4107-99dc-5af29e392b7c" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">int UsersToAdd = 10000;
//setup some users
Func&lt;List&lt;User&gt;&gt; getTestUsers = () =&gt;
{
    var tmp = new List&lt;User&gt;();
    for (int i = 0; i &lt; UsersToAdd; i++)
    {
        tmp.Add(new User { Name = "Karl" + i, Age = 20 });
    }
    return tmp;
};

//insert
Stopwatch insertTimer = new Stopwatch();
insertTimer.Start();
foreach (var item in getTestUsers())
{
    users.Insert&lt;User&gt;(item);
}
insertTimer.Stop();
Console.WriteLine(UsersToAdd + " users added in: " + insertTimer.ElapsedMilliseconds + "ms");

//bulk insert
insertTimer.Start();
users.InsertBatch&lt;User&gt;(getTestUsers());
insertTimer.Stop();
Console.WriteLine(UsersToAdd + " users added in an Batch: " + insertTimer.ElapsedMilliseconds + "ms");

//parallel insert
insertTimer.Start();
System.Threading.Tasks.Parallel.ForEach&lt;User&gt;(getTestUsers(), x =&gt; users.Insert&lt;User&gt;(x));
insertTimer.Stop();
Console.WriteLine(UsersToAdd + " users added parallel in: " + insertTimer.ElapsedMilliseconds + "ms");

//load all
insertTimer.Start();
var all = users.FindAll();
insertTimer.Stop();
Console.WriteLine("all users loaded in: " + insertTimer.ElapsedMilliseconds + "ms");

//drop all
insertTimer.Start();
users.Drop();
insertTimer.Stop();
Console.WriteLine("all users droped in: " + insertTimer.ElapsedMilliseconds + "ms");</pre>
</div>
And that is my result (4GB RAM QuadCore, HDD RAID5, no SSD)

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border-width: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb562.png" border="0" alt="image" width="497" height="263" />

<strong>Management</strong>



<img style="background-image: none; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px; border-width: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb563.png" border="0" alt="image" width="216" height="108" align="left" />To manage mongoDB there are <a href="http://www.mongodb.org/display/DOCS/Admin+UIs">several Tools</a> available. I used the MongoExplorer for now. The dressy Silverlight tool could be installed directly from <a href="http://mongoexplorer.com/">the website</a>.

&nbsp;





<a href="{{BASE_PATH}}/assets/wp-images-en/image1382.png"><img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border-width: 0px;" title="image1382" src="{{BASE_PATH}}/assets/wp-images-en/image1382_thumb.png" border="0" alt="image1382" width="540" height="430" /></a>

<strong>Query</strong>



That’s also a subject that includes enough material for an own blog post. For now: mongoDB is complete guidable with Javascript. Many of my own questions are answered after I watched this presentation:
<div id="__ss_4111399" style="width: 425px;"><strong style="margin: 12px 0px 4px; display: block;"><a title="Why MongoDB is awesome" href="http://www.slideshare.net/jnunemaker/why-mongodb-is-awesome" target="_blank">Why MongoDB is awesome</a></strong>&nbsp;
<div style="padding-bottom: 12px; padding-left: 0px; padding-right: 0px; padding-top: 5px;">View more <a href="http://www.slideshare.net/" target="_blank">presentations</a> from <a href="http://www.slideshare.net/jnunemaker" target="_blank">John Nunemaker</a></div>
</div>
