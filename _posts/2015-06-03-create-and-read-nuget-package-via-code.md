---
layout: post
title: "Create and read NuGet Packages via Code"
description: "NuGet all the things - but this time with code."
date: 2015-06-03 00:15
author: Robert Muehsig
tags: [NuGet]
language: en
---
{% include JB/setup %}

The typical use cases for NuGet may involve the NuGet Client inside Visual Studio or the [NuGet.exe](https://docs.nuget.org/consume/command-line-reference), but of course you can use the same functionality via code. NuGet - as a package format - can be used for many different things, for example [Chocolatey](https://chocolatey.org/) and [Squirrel](https://github.com/Squirrel/Squirrel.Windows) are using NuGet to distribute and update software.

## Getting started with the NuGet API

All you need is the [NuGet.Core NuGet-Package](http://www.nuget.org/packages/Nuget.Core/). This package seems to contain the logic to create, read and load packages, which is (more or less) the most interesting part of a Package Manager. So, let's take a deeper look.

## Create a NuGet Package via Code

A NuGet-Package is basically a Zip-Archive, but with Metadata. When you create a library and ship it via NuGet you will need to write a .nuspec file. Well... with the help of the NuGet.Core package we can define the Metadata with code and harvest the desired content/tools/lib etc. files:

    ManifestMetadata metadata = new ManifestMetadata()
    {
        Authors = "Authors Name",
        Version = "1.0.0.0",
        Id = "NuGetId",
        Description = "NuGet Package Description goes here!",
    };

    PackageBuilder builder = new PackageBuilder();

    var path = AppDomain.CurrentDomain.BaseDirectory + "..\\..\\DemoContent\\";

    builder.PopulateFiles(path, new[] { new ManifestFile { Source = "**", Target = "content" } });
    builder.Populate(metadata);

    using (FileStream stream = File.Open("test.nupkg", FileMode.OpenOrCreate))
    {
        builder.Save(stream);
    }

The first lines defines the NuGet Metadata, then we just collect files in a folder called "DemoContent", which is included in the sample. 

![x]({{BASE_PATH}}/assets/md-images/2015-06-03/package.png "Created Package in Package Explorer")

## Read NuGet Packages via Code

Reading NuGet-Package is really easy and the NuGet.Core Package has some nice utility classes to extract the content of the actual package:

    NuGet.ZipPackage package = new ZipPackage("test.nupkg");
    var content = package.GetContentFiles();

    // extract content like content.First().GetStream();

    Console.WriteLine("Package Id: " + package.Id);

## My Complete Sample

The sample code is also available on [GitHub](https://github.com/Code-Inside/Samples/tree/master/2015/CreateAndExtractNuGetPackages)

    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Create NuGet Package via Code");
            ManifestMetadata metadata = new ManifestMetadata()
            {
                Authors = "Authors Name",
                Version = "1.0.0.0",
                Id = "NuGetId",
                Description = "NuGet Package Description goes here!",
            };

            PackageBuilder builder = new PackageBuilder();

            var path = AppDomain.CurrentDomain.BaseDirectory + "..\\..\\DemoContent\\";

            builder.PopulateFiles(path, new[] { new ManifestFile { Source = "**", Target = "content" } });
            builder.Populate(metadata);

            using (FileStream stream = File.Open("test.nupkg", FileMode.OpenOrCreate))
            {
                builder.Save(stream);
            }

            Console.WriteLine("... and extract NuGet Package via Code");

            NuGet.ZipPackage package = new ZipPackage("test.nupkg");
            var content = package.GetContentFiles();

            Console.WriteLine("Package Id: " + package.Id);
            Console.WriteLine("Content-Files-Count: " + content.Count());

            Console.ReadLine();
        }
    }

![x]({{BASE_PATH}}/assets/md-images/2015-06-03/democode.png "Running sample")	
	
## Using NuGet not only for assemblies...

As already mentioned: NuGet can be used for all kinds of "packaged content". The good part of using NuGet is that you can use a wide range of tooling around it - like the [NuGet Package Explorer](https://npe.codeplex.com/) or the NuGet.Core library.

Happy coding!  