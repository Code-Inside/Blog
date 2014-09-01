---
layout: post
title: "Fix: “Method not found: 'Void System.Web.Mvc.GlobalFilterCollection.Add(System.Object, System.Nullable`1)'.”"
date: 2010-12-03 21:22
author: robert.muehsig
comments: true
categories: [Fix]
tags: [Fix, MVC3]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image1128.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb310.png" width="244" height="82" /></a> Nach dem Update von MVC 3 Beta zu MVC 3 RC bekam ich folgenden Fehler: </p>  <p>"Method not found: 'Void System.Web.Mvc.GlobalFilterCollection.Add(System.Object, System.Nullable`1&lt;Int32&gt;)'.” <strong>Problemlösung: MVC 3 Beta vorher deinstallieren.</strong></p>  <p>Dummerweise hatte ich vor der Installation die MVC3 Beta nicht deinstalliert, es steht auch in den Release Notes: "you must uninstall ASP.NET MVC 3 Preview 1 or ASP.NET MVC 3 Beta before installing ASP.NET MVC 3 RC.”</p>  <p>Auch in der Applikation sollte geschaut werden, welche MVC Dll genutzt wird, falls man nicht den Standardpfad der MVC Dlls nutzt.</p>  <p>Mehr Tipps gibts <a href="http://stackoverflow.com/questions/4337845/error-after-updating-from-asp-mvc-3-beta-to-rc">hier</a>.</p>
