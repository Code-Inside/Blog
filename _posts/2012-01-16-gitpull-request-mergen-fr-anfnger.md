---
layout: post
title: "Git–Pull Request mergen für Anfänger"
date: 2012-01-16 01:41
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [GIT, GitHub]
---
<p>Mein Projekt “<a href="http://knowyourstack.com/">KnowYourStack.com</a>” (Arbeitstitel war mal BizzBingo – ein detailierter Blogpost dazu folgt noch) liegt auf <a href="https://github.com/robertmuehsig/BizzBingo">GitHub</a> und ich hatte ein Problem bei dem mir <a href="http://daniellang.net/">Daniel Lang</a> sehr geholfen hat. Am Ende hat er ein Fork von meinem Projekt gemacht und mir ein Pull Request eingestellt:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1450.png"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb625.png" width="583" height="192"></a></p> <p><strong>Nun ist natürlich die Frage: Wie bekomm ich denn die Änderungen zu mir?</strong> </p> <p>Da ich ein völliger Anfänger in Sachen <a href="http://www.knowyourstack.com/what-is/git">Git</a> / <a href="http://www.knowyourstack.com/what-is/github">GitHub</a> bin schreibe ich mal Schritt für Schritt mit. Die <a href="http://help.github.com/send-pull-requests/">Hilfe von GitHub</a> war ein guter Anfang, allerdings muss ich bei dieser Aktion noch diverse Files mergen, was das ganze nicht einfacher macht.</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:4f86e7bf-9598-4441-b48b-89cc32a0709d" class="wlWriterEditableSmartContent"><pre name="code" class="c#">git checkout master
... 
git pull https://github.com/dlang/BizzBingo master
... (VIELE DATEIEN werden gezogen)...</pre></div>
<p>Ergebnis:</p>
<p>“Automatic merge failed; fix conflicts and then commit the result.”</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a5b21b99-06eb-48b1-a8aa-c356edbad1c7" class="wlWriterEditableSmartContent"><pre name="code" class="c#">$ git mergetool</pre></div>
<p>&nbsp;</p>
<p><strong>Achtung:</strong> Man sollte allerdings vorher ein Mergetool eingestellt haben. Das ganze ist eigentlich auch recht einfach und ist <a href="http://gitguru.com/2009/02/22/integrating-git-with-a-visual-merge-tool/">hier detailiert beschrieben</a>. Im Grunde muss man nur ein Merge Programm sich aussuchen (ich hab z.B. <a href="http://kdiff3.sourceforge.net/">KDiff3</a> gewählt. Sieht aber hässlich aus.) und sagt git, welches Tool er beim Mergen zu nehmen hat. Am Ende sieht z.B. die .gitconfig so aus:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:89bc0955-6f15-48a1-9757-62ac899e9e57" class="wlWriterEditableSmartContent"><pre name="code" class="c#">[diff]
    
	tool = kdiff3
 

[merge]
    
	tool = kdiff3

[mergetool "kdiff3"]
   
	path = C:/Program Files (x86)/KDiff3/kdiff3.exe

    keepBackup = false

    trustExitCode = false
 

[difftool "kdiff3"]

    path = C:/Program Files (x86)/KDiff3/kdiff3.exe

    keepBackup = false

    trustExitCode = false</pre></div>
<p>&nbsp;</p>
<p>Nach dem mergen die Files am Ende mit “commit” und “push” zu GitHub. Fertig :)</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:cd498f43-56f7-4cb1-b257-8fdfa4f2f133" class="wlWriterEditableSmartContent"><pre name="code" class="c#">git commit -m " KOMMENTAR "
git push origin master</pre></div>



<p>Müsste so klappen – Danke nochmal an Daniel! :)</p>
