---
layout: post
title: "Fix: FeedBurner “Your feed filesize is larger than 576K.”"
date: 2014-02-02 14:37
author: robert.muehsig
comments: true
categories: [Fix]
tags: [Feed, FeedBurner, Fix, RSS]
---
{% include JB/setup %}
<p>Während des Domain-Umzugs und des WordPress Updates gab es plötzlich ein Problem bei FeedBurner:</p> <p>“Your feed filesize is larger than 576K. You need to reduce its size in order for FeedBurner to process it. Tips for controlling feed file size with Blogger can be found in Tech Tips on FeedBurner Forums, our support site.”</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1980.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb1116.png" width="577" height="356"></a></p> <p>Über den RSS Feed werden bei mir alle Inhalte freigegeben. Mir ist nicht ganz bewusst warum der Fehler erst jetzt auf trat, aber man kann ihn einfach beheben indem man die Anzahl an Posts reduziert die man über den Feed freigibt:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1981.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb1117.png" width="533" height="454"></a></p> <p>Jetzt klappts wieder mit dem Feed.#</p>
