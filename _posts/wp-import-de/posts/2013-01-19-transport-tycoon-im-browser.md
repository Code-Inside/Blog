---
layout: post
title: "Transport Tycoon im Browser"
date: 2013-01-19 18:16
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [OpenTDD]
language: de
---
{% include JB/setup %}
<p>Ein (meiner Meinung nach) absoluter Klassiker der PC Spiele <a href="http://play-ttd.com/play/">“Transport Tycoon” wurde jetzt ins Web portiert</a>:</p> <p><a href="http://play-ttd.com/play/"><img title="image" style="border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; display: inline; border-top-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image1708.png" width="584" height="437"></a> </p> <p>Zu Grunde liegt hierbei der Code des <a href="http://www.openttd.org">OpenTTD Projekts</a>, welcher über einen LLVM to Javascript Compiler ins Web gebracht wurde. Der Entwickler hinter dem Projekt heisst <a href="https://github.com/caiiiycuk">Aleksander Guryanov</a> und ich hatte bereits ein anderes Projekt von ihm auf dem Blog vorgestellt: <a href="{{BASE_PATH}}/2012/12/01/dune-2-im-browser-ber-einen-c-lvvm-to-javascript-compiler/">Dune 2 im Browser</a>.</p> <p>Technisch gesehen scheint es die selbe Mechanik wie bei <a href="http://play-dune.com/">Play-Dune.com</a> zu sein: </p> <p>OpenTDD wurde in C / C++ entwickelt und kann über einen Compiler in <a href="http://en.wikipedia.org/wiki/LLVM">LLVM</a> bitcode übersetzt werden. Über <a href="https://github.com/kripken/emscripten">Emscripten</a> kann dieser Code dann wiederum in Javascript übersetzt werden.</p> <p><strong>Wer mehr Erfahren möchte:</strong></p> <p><a href="http://play-ttd.com/">Play-TDD zum Spielen</a> oder die <a href="https://github.com/caiiiycuk/play-ttd">Sourcen auf GitHub anschauen</a>.</p> <p><strong>Funktioniert es in jedem Browser?</strong></p> <p>Naja – im Chrome scheint es wohl am besten zu funktionieren. Im IE kommt kein Sound, aber ansonsten scheint es wohl laut <a href="http://channel9.msdn.com/coding4fun/blog/PlayTTD-OpenTTD-Browser-ified">Channel 9 Blog auch auf WinRT</a> Geräten zu funktionieren.</p> <p>Auf alle Fälle ziemlich beeindruckend.</p>
