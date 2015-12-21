---
layout: post
title: "TeamCity & GitHub"
date: 2011-10-07 22:54
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [CI, GIT, GitHub, TeamCity]
language: de
---
{% include JB/setup %}
<p>Durch <a href="{{BASE_PATH}}/2011/08/05/einstieg-in-git-fr-net-entwickler/">meine Git-Spielerein</a>, wollte ich natürlich nun auch mein CI Tool der Wahl mit GitHub in Verbindung bringen. Wie kann ich also TeamCity dazu bringen, mir die aktuellen Sourcen zu holen?</p> <p><strong>Eigentlich total einfach…</strong></p> <p>Wer die neuste <a href="http://www.jetbrains.com/teamcity/">TeamCity Version (momentan 6.5)</a> hat, hat bereits einen Git-Client installiert. Man muss auch keine SSH Konfiguration oder anderes Voodoo-Hexenwerk betreiben – jedenfalls nicht für das pure abholen eines offenen Repositories.</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1370.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb552.png" width="502" height="278"></a></p> <p>Wichtig: Anstatt die HTTP Adresse anzugeben (wie man es vielleicht von diversen SVN Hostern her kennt), muss man die GIT Adresse eingeben:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1371.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb553.png" width="551" height="132"></a></p>  <p>Der Rest kann auf Standard bleiben. Manchmal sind die Dinge recht einfach.</p>
