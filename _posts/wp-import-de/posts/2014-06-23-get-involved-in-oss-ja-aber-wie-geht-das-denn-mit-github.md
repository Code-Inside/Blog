---
layout: post
title: "Get Involved in OSS! Ja, aber wie geht das denn mit GitHub?"
date: 2014-06-23 19:21
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [GIT, GitHub, OSS]
language: de
---
{% include JB/setup %}
<p>Auch im .NET Lager gibt es Bewegung im OSS Bereich und es gibt verschiedene Arten wie man bei einem Open Source Projekt “Contributed”. </p> <h3><strong>Was zählt alles zu “Contribution”?</strong></h3> <p>Unter “Contribution” läuft eigentlich alles – ob es Fragen/Probleme zu dem Projekt via Issues ist oder Dokumentation nachreicht oder ob man darüber bloggt oder das Projekt vorstellt. Solange man das Projekt damit irgendwie “vorran” bringt ist das alles super. Aber wie man wirklich Code hinzufügt zeige ich jetzt mal am Beispiel der <a href="https://github.com/NuGet/NuGetGallery">NuGet Gallery</a>.</p> <h3><strong>GitHub</strong></h3> <p>Es gibt unzählige Projekte auf GitHub und das was GitHub besonders gut macht ist die “Vernetzung”. Es ist eigentlich kinderleicht bei einem Projekt auf GitHub mitzumachen und selbst wenn man (wie ich ;) ) kein Git-Guru ist geht fast alles auch bequem über die UI.</p> <h3><strong>Code Contribution mit GitHub</strong></h3> <p>Wichtigster Punkt hierbei ist, dass man sich genau die “Contribution Guideline” durchliesst. Die meisten Projekte besitzen solch eine Anleitung – meist findet sich dies in der ReadMe oder es gibt eine Contribution Datei.</p> <p><strong>Contribution Guideline </strong></p> <p>Bei der NuGet Gallery findet man die Datei <a href="https://github.com/NuGet/NuGetGallery/blob/master/CONTRIBUTING.md"><strong>hier</strong></a>. GitHub verweisst auch beim Mergen eines Pull Requests auf diese Datei hin.</p> <p><strong>Schritt 1: Issue suchen</strong></p> <p>Um einen ersten Schritt zu machen ist es gut wenn man sich z.B. bei <a href="http://up-for-grabs.net/">Up-for-Grabs.net</a> ein Projekt sucht und sich da ein passendes Issue vornimmt.</p> <p>Bei der NuGet Gallery gibt es den <a href="https://github.com/NuGet/NuGetGallery/issues?milestone=13&amp;page=1&amp;state=open">Milestone “Up for Grabs”</a>: <a href="{{BASE_PATH}}/assets/wp-images-de/image2022.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1158.png" width="570" height="497"></a></p> <p>Issue gefunden? Dann gehts los… wie immer gilt: Kommunikation ist alles – bei einem größeren Change empfiehlt es sich zu schreiben was man vor hat.</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image4102.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image4_thumb2.png" width="570" height="411"></a></p> <p>&nbsp;<strong>Schritt 2: Ein Fork erstellen</strong></p> <p>Um bei dem Projekt mitzumachen muss man einen eigenen Fork erstellen. Dies geschieht über diesen Knopf bzw. kann man auch alles via Kommandozeile erledigen:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image2023.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1159.png" width="240" height="112"></a>&nbsp;</p> <p>Wer bereits einen Fork hat, der kann es mit den simplen Commands aktualsieren (evtl. geht dies auch via GUI, hab ich aber nicht rausbekommen).</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;"># Add the remote, call it "upstream":

git remote add upstream https://github.com/whoever/whatever.git

# Fetch all the branches of that remote into remote-tracking branches,
# such as upstream/master:

git fetch upstream

# Make sure that you're on your master branch:

git checkout master

# Rewrite your master branch so that any commits of yours that
# aren't already in upstream/master are replayed on top of that
# other branch:

git rebase upstream/master

# Update the fork
git push -f origin master</pre>
<p>Der Command stammt von dieser <a href="http://stackoverflow.com/questions/7244321/how-to-update-github-forked-repository">Stackoverflow Antwort</a>.</p>
<p><strong><u>Zwischenschritt: GitHub for Windows installieren</u></strong></p>
<p>Der <strong><a href="https://windows.github.com/">GitHub for Windows Client</a></strong> ist ausgezeichnet für Leute die sonst keine Ahnung von Git haben. Da mein Kommandozeilen Voodoo leider nicht ausreicht, zeig ich nur die Variante via GUI ;)</p>
<p><strong>Schritt 3: Branch erstellen</strong></p>
<p>Wer potenziell mehrere Issues beheben möchte, der sollte ein Branch in seinem Fork erstellen. So kann man den Master stehts aktuell halten und trotzdem an den diversen Issues seperat arbeiten. Empfehlenswert ist natürlich vom Naming her etwas zu wählen was mit dem Issue zutun hat.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image8100.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image8_thumb.png" width="570" height="406"></a></p>
<p><strong>Schritt 4: Änderungen machen und “comitten”</strong></p>
<p>Wenn man denkt die Änderungen sind gemacht und das Issue ist damit behoben kann man einfach seine Änderungen zu seinem Branch comitten.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image5100.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image5_thumb.png" width="570" height="264"></a></p>
<p><strong>Schritt 5: Branch publishen</strong></p>
<p>Nun kann man den Branch publishen (man kann ihn eigentlich auch schon vorher publishen – aber bei kleinen Änderungen bin ich auch so durch gekommen ;) ). </p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image9101.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image9_thumb1.png" width="570" height="211"></a></p>
<p>&nbsp;<strong>Schritt 6: Pull Request (PR) erstellen</strong></p>
<p>Nach dem “publishen” stellt GitHub fest dass es ein Branch gibt und das man diesem dem eigentlichen Projekt via “Pull Request” auch anbieten kann.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image14100.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image14_thumb.png" width="570" height="237"></a></p>
<p><strong>Schritt 7: PR beschreiben</strong></p>
<p>Als Hilfreich für den “Owner” ist es wenn man genauer ausführt was man eigentlich gemacht hat und das man natürlich auch das Issue erwähnt.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image18100.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image18_thumb.png" width="570" height="538"></a> </p>
<p><strong>Schritt 8: Warten auf den “Merge”</strong></p>
<p>Jetzt liegt es in der Hand des Owners was er mit dem PR macht – entweder wird es gemerged oder halt nicht, wobei wenn man nicht alles falsch gemacht hat, dann sind die meisten Projekte sehr froh über jeden PR.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image2210.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image22_thumb.png" width="570" height="501"></a></p>
<p><strong>Schritt 8.1: Eventuelle Verbesserungen des PRs durchführen</strong></p>
<p>Bei <a href="https://github.com/NuGet/NuGetGallery/pull/2215">meinem PR</a> gab es noch Anmerkungen. Man kann dann einfach die Änderungen auf seinem Fork / Branch machen und wieder zu GitHub überführen – der Pull Request wird automatisch auf die neuste Version aktualisiert.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image11000.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image1_thumb.png" width="570" height="472"></a></p>
<h3>Finale</h3>
<p>Wenn alles gut läuft wird der <a href="https://github.com/NuGet/NuGetGallery/commits?author=robertmuehsig">PR gemerged</a>. </p>
<p>Neben der Erfahrung und dem guten Gefühl gibt es auch etwas <a href="https://www.nuget.org/policies/About">Internet Fame</a> :-)</p>
<p>Ich hoffe ich konnte den einen oder anderen animieren – mein dank möchte ich nochmal an <a href="https://twitter.com/adamralph">Adam Ralph</a> aussprechen der mit seinem “Get Involved” Talk mich motiviert hatte.</p>
