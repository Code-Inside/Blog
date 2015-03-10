---
layout: post
title: "Keep your test data with your tests"
description: "Unit Testing is great, but mocking the result of each 3rd party call can be a pain. Why not embedding actual real world test data inside your test data and keep you sane?"
date: 2015-03-03 21:30
author: robert.muehsig
tags: [Testing, Unit Tests, TDD]
language: en
---
{% include JB/setup %}

This post might lead to a religious debate (_"What is the boundary of a Unit-Test?", "You could mock that!", "Unit Tests sucks...", "You suck!"_ ) or to a simple "Yeah... I'm doing this... since forever...", but the goal of this post is pretty simple: Making testing with "real world data" inside Unit-Tests easier with a simple trick.  

## The Problem (Long story...)

A while ago I needed to write a program which "synchronize" data from LDAP to another directory based on different rules. At first I needed to write the code to get the data from the LDAP and the code to store it inside the other directory, which was really low level plumbing. Now I needed to make sure my rules are applied correctly and that only certain users were synchronized. So this was a perfect fit for tests, right?
I started with simple "fake" LDAP mocks, but soon I needed real world data to see if my logic was still correct. 

I made the decision to map the incoming "System.DirectoryService.DirectoryEntry" to my own model, which I could also serialize as JSON, and used this inside my logic.

With this in place I could easily serialize our "Test-LDAP" and use that JSON in my own tests, so no mocking (at least no manual - in code - mocking), just real data.  

## Where should I put the sample-data?

Now the question is: Where should I store the sample data? I think such data should be __very__ close to the actual test code. If you point to files on your disk you are doing it wrong. Why? Because the files are only on your machine and your build- or co-worker-machine didn't have this file and tests will fail. If you hit the file system in your test you should be very careful.
Ok, so you could do some Kung-Fu with build scripts, but this is pretty hard to maintain in my opinion. 

__Update: Don't handle the file stuff yourself, you can do this with a simple "Copy to output directory" action in the properties tab. See my larger comment in the last section of this post.__

## The Solution   

The solution to this problem is pretty simple, but I didn't thought about it in a test project at first: __Embedding the test data inside the assembly as a resource!__ Like you do it with other resources (images, localizations etc.)

![x]({{BASE_PATH}}/assets/md-images/2015-03-03/mind_blown.gif "Whooooho...")

## Real world data!

Long story short, I used the same approach in [this project](https://github.com/Code-Inside/Sloader), where I needed to parse Atom/Rss-Feeds and didn't want to pollute the test code with hand crafted feeds. My tests projects there looks like this:

![x]({{BASE_PATH}}/assets/md-images/2015-03-03/testproj.png "Test Project")

The sample files contains [actual "real" Atom/Rss-Feeds](https://github.com/Code-Inside/Sloader/tree/master/tests/Sloader.Tests/FeedCrawlerTests/Samples). 

## Code

Whenever I need the test data I can now get it like that:

    string gitHubAtomSamplePath = "FeedCrawlerTests.Samples.GitHubAtom.xml";
    var staticFeed = SyndicationFeed.Load(new XmlTextReader(TestHelperForCurrentProject.GetTestFileStream(gitHubAtomSamplePath)));
 
__With this "TestHelper":__
 
    public static class TestHelperForCurrentProject
    {
        private const string ResourcePath = "Sloader.Tests.{0}";

        public static Stream GetTestFileStream(string folderAndFileInProjectPath)
        {
            var asm = Assembly.GetExecutingAssembly();
            var resource = string.Format(ResourcePath, folderAndFileInProjectPath);

            return asm.GetManifestResourceStream(resource);
        }

        public static string GetTestFileContent(string folderAndFileInProjectPath)
        {
            var asm = Assembly.GetExecutingAssembly();
            var resource = string.Format(ResourcePath, folderAndFileInProjectPath);

            using (var stream = asm.GetManifestResourceStream(resource))
            {
                if (stream != null)
                {
                    var reader = new StreamReader(stream);
                    return reader.ReadToEnd();
                }
            }
            return String.Empty;
        }

    }

__Set the Build-Action to: Embedded Resource!__

You just need to set the Build-Action to "Embedded Resource" to get this to work (of course).
	
![x]({{BASE_PATH}}/assets/md-images/2015-03-03/embed.png "Embedded Resource")

Easy, right? 

## Update based on comments

I got a nice [Pull Request on GitHub for my sample code from Matthias Cavigelli](https://github.com/Code-Inside/Sloader/pull/9). __Instead of "Embedded Resources"__ you can also just use the __"Copy to Output Directory: Copy always"__. 
There are some performance advantages using this approach and the test assemblies are not so heavy. I keept my "TestHelper" just to have one single way to handle test data:

    /// <summary>
    /// Wrapper around basic File IO Operations for the TestFiles.
    /// I re-introduced this helper to have one centralized way to access 
    /// sample data. Sample data could be embedded as Resource or just pure File 
    /// Stuff. 
    /// </summary>
    public static class TestHelperForCurrentProject
    {
        private const string ResourcePath = "Sloader.Tests.{0}";

        public static string GetTestFileContent(string path)
        {
            return File.ReadAllText(path);
        }
        public static string GetTestFilePath(params string[] strings)
        {
            return Path.Combine(strings);
        }

        public static Stream GetTestResourceFileStream(string folderAndFileInProjectPath)
        {
            var asm = Assembly.GetExecutingAssembly();
            var resource = string.Format(ResourcePath, folderAndFileInProjectPath);

            return asm.GetManifestResourceStream(resource);
        }

        public static string GetTestResourceFileContent(string folderAndFileInProjectPath)
        {
            var asm = Assembly.GetExecutingAssembly();
            var resource = string.Format(ResourcePath, folderAndFileInProjectPath);

            using (var stream = asm.GetManifestResourceStream(resource))
            {
                if (stream != null)
                {
                    var reader = new StreamReader(stream);
                    return reader.ReadToEnd();
                }
            }
            return String.Empty;
        }

    }

Just read the [comments on the PR to get a full understanding](https://github.com/Code-Inside/Sloader/pull/9). In the end the result is the same: Using real world data inside tests. Thanks Matthias!