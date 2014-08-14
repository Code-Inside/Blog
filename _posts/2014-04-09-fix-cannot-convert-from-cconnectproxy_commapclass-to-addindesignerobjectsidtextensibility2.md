---
layout: post
title: "Fix: Cannot convert from 'CConnectProxy::_ComMapClass *' to 'AddInDesignerObjects::IDTExtensibility2 *'"
date: 2014-04-09 20:41
author: robert.muehsig
comments: true
categories: [Fix]
tags: [Fix, Office]
---
<p>Mal einen etwas esoterischer Blogpost, welcher auftaucht wenn man zu viel mit Office Addins rumspielt. Der Fehler passiert beim Bauen von C++ Projekten, welchen diesen Typ benötigen.</p> <p><strong>Lösung (auf 64bit Systemen):</strong></p> <p align="left"><em>C:\Program Files (x86)\Common Files\DESIGNER&gt;regsvr32 MSADDNDR.DLL</em> <p align="left"><em>And Rebuild.</em> <p>Meine lieben Kollegen hatte mir dies schon mehrfach gesagt, allerdings hatte ich es immer wieder vergessen :) Das Problem samt Lösung wird auch hier <a href="http://social.msdn.microsoft.com/forums/office/en-US/829ad60b-ac2e-4c11-bfd2-0ddcc1d77ecd/shim-compile-problems">gezeigt</a>.
