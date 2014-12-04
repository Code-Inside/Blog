---
layout: post
title: "HowTo: TeamCity & CodeCoverage with dotCover"
date: 2011-02-01 12:19
author: antje.kilian
comments: true
categories: [HowTo]
tags: [TeamCity]
language: en
---
{% include JB/setup %}
<p>&#160;</p>  <p><a href="http://code-inside.de/blog-in/wp-content/uploads/image112.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="http://code-inside.de/blog-in/wp-content/uploads/image_thumb21.png" width="132" height="119" /></a>During our <a href="http://code-inside.de/blog-in/2011/01/09/bullshit-bingo-online-with-bizzbingo-rtw/">BizzBingo</a> project we use NUnit and since <a href="http://www.jetbrains.com/teamcity/">TeamCity 6.0</a> is Jetbrains dotCover also directly integrated. How dis would look like you are getting to know now. </p>  <p><b></b></p>  <!--more-->  <p><b>1. </b><b>Step: create Build Configuration</b></p>  <p>This ScreenShot is from Nightly Build and there is nothing special in it.</p>  <p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb339.png" width="508" height="140" /><b></b></p>  <p>&#160;</p>  <p><b>2. </b><b>Version Control Settings </b></p>  <p><b></b></p>  <p>You need to adjust it depending on your project but here is nothing special to beware on here. We take the Source over the SVN interface from Codeplex.</p>  <p><b><a href="http://code-inside.de/blog-in/wp-content/uploads/image113.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://code-inside.de/blog-in/wp-content/uploads/image_thumb22.png" width="502" height="86" /></a></b></p>  <p><b>3. </b><b>Now it´s getting interesting.... </b></p>  <p><b></b></p>  <p>My "Nightly" consist of 3 Build-steps but in this Blogpost just two of them are important:</p>  <p>- Build the whole SLN with "Rebuild" / "Debug" (an MSBuild is also possible)</p>  <p>- Take the NUnit test runner and check the Code Coverage on dotCover</p>  <p>&#160;</p>  <p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb341.png" width="536" height="144" /></p>  <p>Take a deeper look on the second step: </p>  <p><b>NUnit Testrunner Configuration:</b></p>  <p><b></b></p>  <p><a href="http://code-inside.de/blog-in/wp-content/uploads/image114.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://code-inside.de/blog-in/wp-content/uploads/image_thumb23.png" width="496" height="229" /></a></p>  <p>We´ve installed NUnit Version 2.5.8 and in the textbox "Run tests from" is this included: </p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:354415f5-07aa-4aa4-a6da-d29a4bfd6ab5" class="wlWriterEditableSmartContent"><pre name="code" class="c#">%system.teamcity.build.checkoutDir%\Main\Source\BusinessBingo\Tests\*\bin\Debug\*Tests.dll</pre></div>

<p><a href="http://code-inside.de/blog-in/wp-content/uploads/image115.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 10px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="http://code-inside.de/blog-in/wp-content/uploads/image_thumb24.png" width="211" height="301" /></a>Because we are building the whole SLN with "Debug" the results are shown in our source tree in the adequate bin folder. </p>

<p>With Wuildcards the runner will found our tests like for example BusinessBingo.Commandhandler.Tests.dll and run them.</p>

<p>If we decide to add more tests to our project they will appear automatically in the Build - "<a href="http://en.wikipedia.org/wiki/Convention_over_configuration">Convention over Configuration</a>". </p>

<p><b></b></p>

<p><b></b></p>

<p><b>Now the Unit tests run... let´s talk about dotCover. </b></p>

<p><b></b></p>

<p>In the newest version of TestCity 6.0 dotCover is directly integrated. That means, you don´t need to install it on the Buildserver. The configuration is quite easy:</p>

<p><a href="http://code-inside.de/blog-in/wp-content/uploads/image116.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://code-inside.de/blog-in/wp-content/uploads/image_thumb25.png" width="484" height="228" /></a></p>

<p>With the filter you instruct dotCover which Code should be recognized for the CodeCoverage during UnitTesting. </p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:95e75254-4e2d-49ab-8a9c-5c68d8cc31dc" class="wlWriterEditableSmartContent"><pre name="code" class="c#">+:BusinessBingo.*
-:BusinessBingo.*Test*</pre></div>

<p>Important: <b>don´t</b> declare ".dll" here just the name. With "+" you say: search assemblies with this name (also Wildcars) and "-"means that there are no CodeCoverage. </p>

<p><i>Little hint: If you do everything right but no report will be generated take a look into the BuildLog. At the first try I got this error:</i></p>

<p><i>Solution: 
    <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:f4885b9c-50a9-40f2-a747-d64338a0d8fc" class="wlWriterEditableSmartContent"><pre name="code" class="c#">Failed to read source file 'C:\TeamCity\buildAgent\temp\buildTmp\dotcover8583844779204955574.xml'. Could not find a part of the path 'C:\Windows\system32\config\systemprofile\AppData\Local\Temp\4q-kqg6z.tmp'.</pre></div>
  </i></p>

<p><i></i></p>

<p><i>Create the searched "Temp" folder in "C:\Windows\system32\config\systemprofile\AppData\Local" </i></p>

<p><i>Normally it doesn´t exist and because of this the error appeared. After this it works.</i></p>

<p><i></i></p>

<p><b>What do we have now?</b></p>

<p><i></i></p>

<p>Nice unit-tests which will be done by the Buildserver:</p>

<p><a href="http://code-inside.de/blog-in/wp-content/uploads/image117.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://code-inside.de/blog-in/wp-content/uploads/image_thumb26.png" width="470" height="175" /></a></p>

<p>Code Coverage for the Assemblies:</p>

<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb345.png" width="488" height="183" /></p>

<p>Here you can see what will run or not beside of the .cs file: </p>

<p><a href="http://code-inside.de/blog-in/wp-content/uploads/image118.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://code-inside.de/blog-in/wp-content/uploads/image_thumb27.png" width="476" height="170" /></a></p>

<p>And here we have a nice little overview:</p>

<p><a href="http://code-inside.de/blog-in/wp-content/uploads/image119.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://code-inside.de/blog-in/wp-content/uploads/image_thumb28.png" width="471" height="129" /></a></p>

<p>Useful and easy and it doesn´t take a lot of time.</p>
