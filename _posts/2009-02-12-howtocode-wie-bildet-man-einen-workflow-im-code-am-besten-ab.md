---
layout: post
title: "HowToCode: Wie bildet man einen Workflow im Code am besten ab?"
date: 2009-02-12 01:40
author: robert.muehsig
comments: true
categories: [HowToCode]
tags: [HowTo, HowToCode, WF, Windows Workflow Foundation, Workflow]
---
<p><a href="{{BASE_PATH}}/assets/wp-images/image651.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="137" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb629.png" width="132" align="left" border="0" /></a> Jede Anwendung basiert auf ein oder mehrere Aktionen, welche zum Teil von verschiedensten Dingen abh&#228;ngen: Dem User, anderen Systemen, eingegebene Werte etc.</p>  <p>Meist spricht man von einem &quot;<a href="http://de.wikipedia.org/wiki/Workflow">Workflow</a>&quot;, der in Software umgesetzt werden muss, doch wie bildet man diesen am &quot;effektivsten&quot; ab? If-Else Konstrukte oder &quot;Workflow Engines&quot; wie die <a href="http://msdn.microsoft.com/de-de/library/cc431274.aspx">Windows Workflow Foundation</a>? Wie steht es mit der Testbarkeit? In diesem Post will ich ein paar Varianten vorstellen, bitte aber wieder ausdr&#252;cklich um Feedback, wie ihr dies handhabt.</p> 
<!--more-->
  <p><strong>Was ist bei &quot;mir&quot; alles ein Workflow?</strong>    <br />Ohne jetzt auf wissenschaftliche Erkl&#228;rungen einzugehen, m&#246;chte ich meine &quot;Definition&quot; von Workflow niederschreiben: <strong>F&#252;r mich ist so ziemlich alles ein Workflow</strong>. Jeder Login und Registrier-Prozess ist ein Workflow, der mehr oder weniger kompliziert ausfallen kann.     <br />Einen User editieren oder l&#246;schen ist auch ein Workflow, da bestimmte Schritte im Code abgegangen werden m&#252;ssen: Sind die Daten valide, gibt es den User &#252;berhaupt, darf der aktuell angemeldet User die Aktion ausf&#252;hren und und und.</p>  <p><strong>Szenario:     <br /></strong>Unser Szenario ist <a href="http://code-inside.de/blog/2009/02/06/howtocode-errorcodes-exceptions-den-user-informieren-wenn-etwas-schief-luft-wie-gehts/">wie beim letzten Mal eine Webanwendung</a>, welche eine <a href="http://code-inside.de/blog/2008/07/09/howto-3-tier-3-schichten-architektur/">3-Schichten</a> Architektur implementiert. Ein User soll sich anmelden k&#246;nnen, dabei wird gepr&#252;ft, ob er bereits vorher einen Newsletter aboniert hat oder nicht und ob es sich um eine Privatperson handelt oder ein Unternehmen.    <br />Vorher findet nat&#252;rlich eine Validierung der Daten statt.</p>  <p>Die Logik m&#246;chte ich im &quot;Service&quot; halten. Wenn man dies kurz skizziert kommt man auf ein solches Bild - die Abfrage nach Privatperson oder Unternehmen hab ich aus Platzgr&#252;nden weggelassen - man kann sich hier aber noch beliebig viele andere Bedingungen hinzuf&#252;gen wenn man das m&#246;chte.</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image652.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="497" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb630.png" width="429" border="0" /></a> </p>  <p><strong>Wichtig: Saubere Architektur beibehalten &amp; Testbar bleiben</strong>    <br />Das Szenario ist f&#252;r den Post auch etwas simpler gew&#228;hlt, allerdings habe ich (wie bereits oben erw&#228;hnt) eine solche Struktur und m&#246;chte auch nur in den Services im Hintergrund Workflows einsetzen - weder das Repository noch das Front-End muss wissen, wie die Buisnesslogik etwas macht. </p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image653.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="117" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb631.png" width="240" border="0" /></a> </p>  <p><strong>Variante A: Per Hand im Code</strong></p>  <p>Ich schreib bei dieser Variante nur &quot;Pseudocode&quot;:</p>  <p>   <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e39e2143-5a51-451d-a283-26fb81d94d93" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public GenericResponse&lt;User&gt; Register(GenericRequest&lt;User&gt; registerRequest)
{
	if(userRequest.Value == null)
	{
		throw new Exception();
	}

	if(!IValidationService.ValidateRequest(userRequest.Value))
	{
		throw new Exception();
	}

	bool hasNewsletter = false;
	if(INewsletterService.GetUser(userRequest.Value.Id)) != null)
	{
		hasNewsletter = true;
	}

	...
}</pre></div>
Das war noch nicht der ganze Workflow (und in der Realit&#228;t ist der Workflow noch etwas komplexer ;) ), allerdings (auch wenn er hier noch IMHO sch&#246;n aussieht) immer gr&#246;&#223;er, weil immer mehr if... Sachen hinzukommen.</p>

<p><strong>Vorteil:</strong> 

  <br />- Man braucht nichts neues lernen

  <br />_ Volle Kontrolle

  <br />- Durch die volle Kontrolle hat man keine Seiteneffekte, dass pl&#246;tzlich der Service wild auf irgendwelche Datenbanken schreibt

  <br />- Testbar (je nach Code ;) )</p>

<p><strong>Nachteil:</strong>

  <br />- Es kann recht schnell Umfangreich werden

  <br />- Es wird mit der Zeit un&#252;bersichtlich</p>

<p><strong>Variante B: Man nehme ein Workflow-Engine</strong></p>

<p>Die zweite Variante w&#228;re der Einsatz einer Workflow-Engine, z.B. die <a href="http://msdn.microsoft.com/de-de/library/cc431274.aspx">Windows Workflow Foundation</a>. Ich m&#246;chte jetzt keine Einf&#252;hrung machen, weil ich selber dazu zu wenig wei&#223;.</p>

<p>Es gibt jedoch auf den ersten Blick Designerunterst&#252;tzung die ganz praktisch ist:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image654.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="499" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb632.png" width="481" border="0" /></a> </p>

<p>Allerdings scheiden sich die Geister ob sich der Einsatz lohnt oder nicht. Herr Schwichtenberg hat vor langer Zeit <a href="http://www.heise.de/developer/Zehn-gute-Gruende-warum-Windows-Workflow-Foundation-dem-Entwickler-keinen-Spass-macht--/blog/artikel/97341">mal ein Blogpost</a> &#252;ber die Guten und weniger guten Dinge der WF geschrieben. Auch auf Stackoverflow ist man <a href="http://stackoverflow.com/search?q=workflow+foundation">sich da nicht so einig</a> ob es nun toll ist oder man lieber auf Version 2 warten sollte.</p>

<p>Zumal die Workflow Foundation die mit .NET 3.0 eingef&#252;hrt wird mit .NET 4.0 nochmal komplett <a href="http://channel9.msdn.com/pdc2008/TL17/">neugeschrieben</a> wird. Auf den ersten Blick macht die Workflow-Foundation erst mal mehr Arbeit, auch in <a href="http://blog.wekeroad.com/mvc-storefront/mvcstore-part-19/">Rob Conerys MVC Storefront</a> sah ich jetzt nicht unbedingt den Vorteil</p>

<p>Lohnt es sich trotzdem? Ist der Einarbeitungsaufwand hoch? Kann man es gut testen? </p>

<p><strong>Variante C: ?</strong></p>

<p>Weder mit Variante A noch Variante B scheinen mich komplett zu &#252;berzeugen. Wobei Variante B voller T&#252;cken, Lernaufwand (+ Migration auf .NET 4.0) und Voodoo ist.
  <br />Aber vielleicht hab ich eine geniale Sache vergessen oder die WF ist besser als ich denke - <strong>daher bitte ich wieder um euer Feedback :)</strong></p>

<p><strong>Wie w&#252;rdet Ihr das obere Szenario abbilden? </strong></p>
