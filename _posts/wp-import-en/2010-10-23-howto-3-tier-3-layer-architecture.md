---
layout: post
title: "HowTo: 3-tier / 3-Layer architecture:"
date: 2010-10-23 11:08
author: CI Team
comments: true
categories: [HowTo]
tags: []
language: en
---
{% include JB/setup %}
<p>A 3-Layer architecture is an example for classic software development.</p>
<p>But in fact it´s a very huge subject and because of this, lots of beginners (and unconvincible developer) just leave it away in lack of time, passion or experience. You will find a lot of examples which will prove my theory.</p>
<p>I wrote this article to transmit the basic idea to you and to show you how easy it would be to implement this at the beginning of every project.</p> 
<strong>What kind of Layers and why 3? </strong>  
  <p><strong></strong></p>
<p>Nearly every type of software has to reach for information´s. Doesn´t matter if we talk about XML, a web service, a data bank, a text data ore every other type of systems.</p>
<p>This information´s somehow needed to be edited. It doesn´t matter if we talk about a mathematic function, a validation or a special kind of searching function.</p>
<p>Because the results should be presented somewhere, we often have a frontend, like for example a Website, a consol application and so on.</p>
<p>That´s the point where we are going to talk about our 3 Layers:</p>
<p><img border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb454.png" width="335" height="164" /></p>
<p><strong>"Just 3? I have more!"</strong></p>
<p><strong></strong></p>
<p>Of course it´s possible to have uncountable layers in between. The Software Factory from Microsoft is a good example for this. There are a lot of mappings between the Data-access-layers until the service-layers.</p>
<p>More about different layer models you will find on Wikipedia.</p>
<p><strong>"I only request files. I just need 2 layers."</strong></p>
<p><strong></strong></p>
<p>Certainly with the help of SQL etc. it´s possible to select and filter etc. so you may don´t need a business layer. My experience taught me to not act like this because it´s always possible that later there will be new needs which are not suitable to the Data Access Layer.</p>
<p>Until this happens the business layer just pass the files around.</p>
<p><strong>An</strong> <strong>application for example: </strong></p>
<p><img border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb455.png" width="208" height="140" /></p>
<p><strong>An</strong> <strong>application for example: </strong></p>
<p>Data-Access Layer: "ThreeTier.Data"   <br />Business Layer: "ThreeTier.Service"    <br />Presentation Layer: "ThreeTier.ConsoleApp"    <br />+ Unit-Tests: "ThreeTier.Tests"</p>
<p>Here we have a quite easy application decorated with some nice little unit-tests.</p>
<p>If you want to have a deeper look on the architecture check out <a href="http://blog.wekeroad.com/">Rob Conerys</a> Storefront project.</p>
<p><strong>Layers in detail: ThreeTier.Data</strong></p>
<p><img border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb456.png" width="244" height="148" /></p>
<p>Here I define my objects I want to use in the project. These are simple <a href="http://en.wikipedia.org/wiki/Plain_Old_CLR_Object">POCOs</a>. Granted we could discuss if the model need to be part of the data-project, but most of the time everything is in the context of files so it´s okay.</p>
<p>Here we have the user group:</p>
<p><img border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb457.png" width="187" height="184" /></p>
<p>In the folder "DataAccess" you will find our interface to the data source. In this case we will just find the interface "IUserRepository". Here we are going to define which option we want to happen in combination with every data source:</p>
<p><img border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb458.png" width="179" height="289" /></p>
<p>The "DemoUserRepository" is the implementation of the interface. Because I didn´t want a data bank or anything else here are just static data passed back.</p>
<p><strong>So which advantages do I have from this interface?</strong></p>
<p><strong></strong></p>
<p>You are right if you question the interface at this time. But I think that´s important because it makes it way easier to change the data source while everything depends on the interface.</p>
<p>Usually we work with a data bank and you didn´t want to flood it in Data-Tests so it´s possible to get static data back via the interface.</p>
<p>With that it is no problem to change from a showcase to a really implementation.</p>
<p>But because I´m just passing back static information´s in my example, that´s the main thing I want to test with my Unit-test.</p>
<p><strong>Layers in Detail: ThreeTier.Service </strong></p>
<p><img border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb459.png" width="210" height="137" /><strong> </strong></p>
<p>In the service we created an interface after the same scheme for our "UserService".</p>
<p><img border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb460.png" width="187" height="280" /></p>
<p>In our service we have a simple login method and another method (in the sense of social networking) which is used to pass back the friends of our user. I also used static data for this and the whole thing is based on "UserRepository".</p>
<p><strong>Layers in Detail: ThreeTier.ConsoleApp</strong></p>
<p><img border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb461.png" width="177" height="78" /></p>
<p>Another console Application. I know, not a very pretty surface, but it´s enough for our example:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d5ed51ff-e1ba-4f7b-91f6-f7bfd070b3a1" class="wlWriterEditableSmartContent"><pre name="code" class="c#">static void Main(string[] args)
        {
            Console.WriteLine("Great Social Community System - Please Login...");
            Console.Write("Name: ");
            string loginname = Console.ReadLine();
            Console.Write("PW: ");
            string password = Console.ReadLine();

            IUserService srv = new DemoUserService();

            if (srv.Login(loginname, password))
            {
                Console.WriteLine("Hello: " + loginname);
                Console.WriteLine("Your demo friend collection in the system: ");
                List&lt;User&gt; friends = srv.GetFriendsFromUser(loginname).ToList();

                foreach (User friend in friends)
                {
                    Console.WriteLine(" + " + friend.Login + " - Id: " + friend.Id);
                }
            }
            else
            {
                Console.WriteLine("Login failed");
            }

            Console.ReadLine();
        }</pre></div>

<p><strong>Output:</strong></p>

<p><img border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb462.png" width="410" height="107" /></p>

<p><strong>Extra: Unit Test:</strong></p>

<p><strong></strong></p>

<p>To have a good example I wrote 6 Unit-Tests. Unfortunately I didn´t test the Frontend. ;)</p>

<p><img border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb463.png" width="349" height="142" /></p>

<p>Code-Coverage: 97% (Data + Service)</p>

<p><img border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb464.png" width="474" height="59" /></p>

<p><strong>Result:</strong></p>

<p>The 3-layer architecture makes it way easier to add new features later and to repair the application. It´s also practical if you work in team because it´s easier to divide the subject.</p>

<p><a href="{{BASE_PATH}}/assets/files/democode/threetier/threetier.zip">[ Download Source Code ]</a></p>
