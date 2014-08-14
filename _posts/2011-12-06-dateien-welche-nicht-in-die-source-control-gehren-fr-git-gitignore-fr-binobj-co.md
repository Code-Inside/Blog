---
layout: post
title: "Dateien, welche nicht in die Source Control gehören für GIT–.gitignore für bin/obj & co."
date: 2011-12-06 02:27
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [GIT, gitignore, HowTo, Source Control Systeme]
---
<p>Visual Studio produziert einige Dateien, welche man nicht in sein Source Control System haben sollte: Zum einen sind es Dateien, welche vom Betriebssystem automatisch erstellt werden (Thumbs.db), von diversen Tools (Resharper ahoi!) oder auch den lokalen Build-Output.</p> <p>Da ich gerade etwas mit <a href="http://code-inside.de/blog/2011/08/05/einstieg-in-git-fr-net-entwickler/">Git experimentiere</a>, hier mal meine Erkenntnisse (bei Denkfehlern meinerseits bitte einfach einen Kommentar hinterlassen :) )</p> <p><strong>Die .gitignore Datei</strong></p> <p>Über dieses Datei kann man steuern, welche Dateien git tracken soll und welche nicht. Der Aufbau ist eigentlich simpel, aber irgendwie auch <a href="http://stackoverflow.com/questions/1470572/gitignore-ignore-any-bin-directory">etwas konfus</a> (IMHO ;) ).</p> <p>Meine .gitignore Datei (für meine Demosourcen auf Google Code) :</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5414a39c-9da4-453a-b56c-98c41a7b44d2" class="wlWriterEditableSmartContent"><pre name="code" class="c#"># Visual Studio Files and security files
######################
*.suo
*.user
*.cache
*.Publish.xml
_ReSharper.*

# Build Outputs
######################
bin/
obj/

# OS generated files #
######################
Thumbs.db</pre></div>
<p>&nbsp;</p>


<p>Der erste Block sind alles User-bezogene Dateien, welche Visual Studio oder Resharper erstellt. Die Build Outputs entferne ich im zweiten Teil und die Thumbs.db fliegt auch weg.</p>
<p><strong>Anlegen der .gitignore Datei in Windows</strong></p>
<p>Windows hat sich beim Anlegen einer “Namenlosen” .gitignore Datei etwas zickig, aber über Notepad++ auch kein Hürde.</p>
<p>Sobald man das File im Stammverzeichnis des Projekts hat, werden überflüssige Dateien nicht mehr eingecheckt.</p>
<p><strong>Wie kann man bereits eingecheckte und getrackte Dateien wieder löschen?</strong></p>
<p>Auf <a href="http://stackoverflow.com/questions/1139762/gitignore-file-not-ignoring">Stackoverflow</a> hab ich mehrere Varianten gefunden, diese hat für mich funktioniert:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:127c17f4-3582-4af5-b738-986994bf46f0" class="wlWriterEditableSmartContent"><pre name="code" class="c#">git add .gitignore
git commit -m "New .gitignore file"
git rm -r --cached .
git add .
git commit -m "Clean checkin"</pre></div>
<p>&nbsp;</p>
<p>In diesem Sinne:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1422.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb600.png" width="383" height="295"></a></p>
