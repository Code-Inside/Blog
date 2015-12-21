---
layout: post
title: "FAKE: Running MSTest Tests with FAKE without knowing a tiny bit of F#"
description: "Of course FAKE can also run MSTests just like xUnit tests."
date: 2015-08-30 23:30
author: Robert Muehsig
tags: [FAKE, Test, MSBuild, MSTest]
language: en
---
{% include JB/setup %}

_This is a follow-up to my xUnit FAKE post ["FAKE: Running xUnit Tests with FAKE without knowing a tiny bit of F#"](http://blog.codeinside.eu/2015/02/24/fake-running-xunit-tests-with-fake/)_.

## Running MSTests with FAKE

Running MSTests is not a big difference to run xUnit tests. The biggest difference: You don't need to pull a test runner via NuGet, because the typical Visual Studio installation will ship with the MSTest runner.

## MSTest Test Project

The actual test is just stupid, but should work for the demo:

    [TestClass]
    public class FoobarMsTests
    {
        [TestMethod]
        public void DoAStupidTest()
        {
            Assert.IsTrue(true);
        }
    }

## Adding the test to the build.fsx script

This time I will only show the important parts for the tests (skipping the targets from the [first post](http://blog.codeinside.eu/2015/02/23/fake-building-with-fake/)).

    // include Fake lib
	open Fake.MSTest
    ...
	
    // Properties
	...
    let artifactsTestsDir  = "./artifacts/tests/"
	
    // Targets
    Target "BuildTests" (fun _ ->
    trace "Building Tests..."
    !! "**/*Tests.csproj"
      |> MSBuildDebug artifactsTestsDir "Build"
      |> Log "TestBuild-Output: "
    )

    Target "RunTests" (fun _ ->
        trace "Running Tests..."
        !! (artifactsTestsDir + @"\*Tests.dll") 
          |> MSTest (fun p -> {p with ResultsDir = artifactsTestsDir })
    )
    ...
    // Dependencies
    "Clean"
      ==> "BuildApp"
      ==> "BuildTests"
      ==> "RunTests"
      ==> "Default"
    
    // start build
    RunTargetOrDefault "Default"

The properties are more or less the same as in the xUnit sample. We still use the "artifacts"-property, which points to the build output of the test project:

    let artifactsTestsDir  = "./artifacts/tests/"
	
This path is used in the __build__ target. With this call I build all projects that ends with _Tests.csproj_. 

    Target "BuildTests" (fun _ ->
    trace "Building Tests..."
    !! "**/*Tests.csproj"
      |> MSBuildDebug artifactsTestsDir "Build"
      |> Log "TestBuild-Output: "
    )

Now we need to invoke the test runner. FAKE already have a [MSTestHelper](http://fsharp.github.io/FAKE/apidocs/fake-mstest.html), so this is really trivial. MSTest can be invoked with a parameter called "ResultsDir", where we store the results. In the xUnit-world this property was called "OutputDir".

    Target "RunTests" (fun _ ->
        trace "Running Tests..."
        !! (artifactsTestsDir + @"\*Tests.dll") 
          |> MSTest (fun p -> {p with ResultsDir = artifactsTestsDir })
    )
	
Pointed to the test directory and FAKE will do all the hard work.

As you can see, running MSTests is not that different from running xUnit tests.
	
You can find the complete [sample & build script on GitHub](https://github.com/Code-Inside/Samples/tree/master/2015/LetsUseFake-MSTest/LetsUseFake)

BTW:
To be clear, I prefer xUnit over MSTest, but in some enterprise projects or with an existing environment MSTest could be a simpler entry point to unit testing.