---
layout: post
title: "HowTo: ASP.NET MVC ActionLinks mit Parametern"
date: 2009-09-21 21:46
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Action, ASP.NET MVC, HowTo, Links, MVC, URL]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image819.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="110" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb3.png" width="147" align="left" border="0"></a> Das heutige HowTo ist sehr einfach gehalten. Ein "<a href="http://asp.net/mvc">ASP.NET MVC</a>" ActionLink ist nichts anderes als das ein A-Tag gerendert wird, welche über die URL zu einer bestimmten ActionMethod zeigt. Im Prinzip recht simpel, hat mich aber 5 Minuten googeln gekostet ;)</p><p><strong>Überladungen über Überladungen...</strong></p> <p>Wie fast alles bei den HtmlHelpern ist der ActionLink mehrfach überlagert: </p> <p><a href="{{BASE_PATH}}/assets/wp-images/image820.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="211" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb4.png" width="434" border="0"></a> </p> <p><strong>Was ich machen möchte...</strong></p> <p>Ich habe eine ActionMethod die so aussieht:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:cb207638-4f87-44c0-8cc0-47f058b00cbf" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        public ActionResult DoSomething(string test, int number, string foo)
        {
            return View("Index");
        }</pre></div>
<p>Was ich in der Methode mache ist egal - ich möchte einfach beim Aufruf des Actionlinks 3 Parameter übergeben.</p>
<p><strong>Auf der ASPX Seite:</strong></p>
<p>Jetzt kommt der kleine Trick: Man muss genau aufpassen, welche Überladung man nimmt. Diese Variante funktioniert:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5e75e458-334c-47e9-83b2-071cf8fcb68b" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        &lt;%=Html.ActionLink("Testlink", "DoSomething", "Home", new { test = "hello", 
                                                                    number = 3, 
                                                                    foo = "bar"}, null) %&gt;</pre></div>
<p>Kurze Erklärung der einzelnen Parameter:<br>- Name des Links (was der User am Ende sieht)<br>- Methodenname<br>- Controllername<br>- Parameter für den Methodenaufrufe (annonymer Typ)<br>- HtmlAttribute</p>
<p>Wichtig ist <strong>der letzte Parameter</strong> "null" (anstatt null kann man natürlich auch einen richtigen Wert einsetzen, z.B. "id" - dies wird dann dem HTML Element angehangen). <strong>Ohne diesen Parameter</strong> wird nämlich diese Überladung genommen:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image821.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="54" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb5.png" width="480" border="0"></a> </p>
<p>Also immer drauf achten, bei welcher Überladung man gerade ist.</p>
<p>Ergebnis:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image822.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="28" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb6.png" width="385" border="0"></a> </p>
<p>Wie man Daten vom <strong>View zum Controller</strong> sonst noch übertragen kann, habe ich in <a href="{{BASE_PATH}}/2009/04/02/howto-daten-vom-view-zum-controller-bermitteln-bindings-in-aspnet-mvc/">diesem HowTo</a> beschrieben.</p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/mvcactionlinkparameter/mvcactionlinkparameter.zip">[ Download Democode ]</a></strong></p>
