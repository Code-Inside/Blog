---
layout: post
title: "HowToCode: Keep it simple & was fliegt, dass fliegt!"
date: 2009-04-28 01:29
author: robert.muehsig
comments: true
categories: [Allgemein, HowToCode]
tags: ["ReadYou", HowToCode]
---
<a href="{{BASE_PATH}}/assets/wp-images/image718.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; margin: 0px 10px 0px 0px; border-right-width: 0px" height="170" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb696.png" width="141" align="left" border="0" /></a>   <p>Vor einer ganze Weile habe ich &#252;ber <a href="http://code-inside.de/blog/2008/08/13/howtocode-readyou-evolution-der-architektur/">eine Idee geschrieben</a>, die wir eine ganze Weile auch in einem Projekt so verfolgt haben. Ein anderes geniales Konzept, wo ich mir nicht ganz sicher war, war das <a href="http://code-inside.de/blog/2009/02/06/howtocode-errorcodes-exceptions-den-user-informieren-wenn-etwas-schief-luft-wie-gehts/">Exception Handling</a>. Nachdem ich beide Ideen in einem Projekt umgesetzt hatte, kommt jetzt mein Fazit: <a href="http://de.wikipedia.org/wiki/KISS-Prinzip"><strong>Keep it simple</strong></a>!</p>  <p>&#160;</p> 
<!--more-->
  <p><strong>Hintergrund:      <br /></strong>Ich und ein Kollege von mir arbeite gerade an einer kleinen (bis mittelgro&#223;en bzw. riesigen! ;) ) Social Network Platform - bzw. geht es in diese Richtung. N&#228;here Infos zum konkreten Projekt folgen sp&#228;ter. Wir haben uns hohe Ziele in das Design der Applikation gesteckt:     <br />- 3 sauber getrennte Schichten     <br />- Testbarkeit m&#246;glichst hoch     <br />- Fetziges UI&#160; <br />- Gute Wartbarkeit - DRY!     <br />Eigentlich also ein Projekt, mit SOLIDen Prinzipien und sch&#246;n aussehen soll es auch :)</p>  <p>Da ich solch ein Projekt in dieser Gr&#246;&#223;e noch nie gemacht habe, habe ich das <a href="http://code-inside.de/blog/2009/02/06/howtocode-errorcodes-exceptions-den-user-informieren-wenn-etwas-schief-luft-wie-gehts/">ein</a> oder <a href="http://code-inside.de/blog/2008/08/13/howtocode-readyou-evolution-der-architektur/">andere</a> mal bereits dar&#252;ber gebloggt. Nun m&#246;chte ich schreiben, wie es bisher weiterging. Diese Projekt ist zudem ein 100%tiges Privatprojekt, wo Zeitdruck zwar da ist, allerdings nicht in dem Ma&#223;e wie bei einem Kundenprojekt.</p>  <p><strong>GenericResponse&lt;AbsoluterFu&#223;schuss&gt; &lt;-&gt; GenericRequest&lt;IDEE&gt;      <br /></strong>Ich hatte vor einer ganzen Zeit eine Idee, unseren ServiceLayer (der die Businesslogik bei uns &#252;bernimmt) mit <a href="http://code-inside.de/blog/2009/02/06/howtocode-errorcodes-exceptions-den-user-informieren-wenn-etwas-schief-luft-wie-gehts/">&quot;Response&quot; &amp; &quot;Request&quot; Objekten</a> anzusprechen bzw. dass er diese zur&#252;ckgibt:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image719.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="170" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb697.png" width="240" border="0" /></a> </p>  <p>Die Idee dahinter war, dass man im Response z.B. reinschreiben kann, dass der Aufruf erfolgreich war oder den Fehlergrund wieder zur&#252;ckgibt.    <br />Leider muss ich sagen, dass ich zu diesem Zeitpunkt das Exceptionhandling wohl noch nicht ganz geschnallt hatte. Daher hat sich bei uns jetzt folgender Spruch eingepr&#228;gt:</p>  <p><strong>Was fliegt, dass fliegt!</strong>     <br />Sinnlos Exceptions versuchen abzufangen, die man sowieso nicht behandeln kann, bringt nichts. Das klingt einfach, aber ich wette man findet an vielen Stellen Code der so aussieht:</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:956787f9-8cf1-4b5a-a98b-36bfcb619ac8" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">try
{
	// Evil Things Happen Here!
}
catch(Exception ex)
{
	Logger.Log(ex);
}</pre></div>

<p>Nach dem Loggen wird entweder noch ein ReturnCode zur&#252;ckgegeben oder es bleibt einfach so. Allerdings ist das nicht Sinn und Zweck der Sache. Im ASP.NET Umfeld w&#252;rde ich einfach empfehlen, dass man unbehandelte Exceptions im Application_Error Event loggt, dem User auf die Error.aspx umleitet und eine Mail an die Entwickler rausschickt (oder <a href="http://www.hanselman.com/blog/ELMAHErrorLoggingModulesAndHandlersForASPNETAndMVCToo.aspx">ELMAH</a> sich mal n&#228;her anschaut).</p>

<p><strong>Back to the Basics 
    <br /></strong>Da der Hauptgrund f&#252;r diese Responseklassen eigentlich das Exceptionhandling war und wir dies jetzt ganz leicht nutzen, brauchen wir diese nun nicht. 

  <br />Wenn der Nutzer was eingibt, was nicht valide ist, z.B. Logindaten oder Registrierdaten, dann werfen wir eine Exception vom Typ &quot;UserException&quot; mit einem Errorcode. </p>

<p><strong>Keine perfekte L&#246;sung
    <br /></strong>Die Errorcodes sind ein gro&#223;es Enum und in einer UserException k&#246;nnen auch mehrere Errorcodes untergebracht werden. Gebraucht werden diese ErrorCodes um ein genaues Feld angeben zu k&#246;nnen, welches fehlt oder einen Fehlerstatus zur&#252;ckgegeben. Momentan sieht das Enum so aus:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a8aad00c-6992-4fd0-8206-3d4c4c435904" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public enum ErrorCodes
    {
        DuplicateEmail,
        InvalidEmail,
        InvalidLogin,
        InvalidPassword,
        InvalidPrename,
        InvalidSurname,
        InvalidCompanyName,
        InvalidCity,
        InvalidState,
        InvalidLongitude,
        InvalidLatitude,
        InvalidTime,
        OutOfTime,
        NoEmployee
    }</pre></div>

<p>In unserem (ASP.NET MVC) Controller k&#246;nnen wir dann den Service Aufrufe in einem Try packen und der Catch sieht so aus:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:cb1fdcaf-38a0-4db0-9936-59e779a54917" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#"> catch(UserException ex)
 	{
                if(ex.ErrorCodes.Any(er =&gt; er == ErrorCodes.InvalidEmail))
                    ModelState.AddModelError("email", "Ungültige Email-Adresse");
	...
	}</pre></div>

<p>Dass das Enum sicher immer weiter anwachsen wird ist uns bewusst, aber eine andere Methode um ein definiertes Element im Servicelayer zur n&#228;chsten Schicht weiterzugeben war uns nicht eingefallen, wenn jemanden ohne gro&#223;e Magie was einf&#228;llt, dann nur zu :)&#160; <br />Ebenso ist die generelle Verwendung von Exceptions f&#252;r Usereingaben (z.B. bei der Registrierung) laut MSDN auch <a href="http://msdn.microsoft.com/en-us/library/ms229014(VS.80).aspx">nicht gern gesehen</a>, allerdings muss ich sagen, dass da die Alternativen aus meiner jetzigen Sicht nicht sehr sch&#246;n sind. Nat&#252;rlich sollten Exceptions nur f&#252;r &quot;Ausnahmen&quot; genommen werden, allerdings erh&#246;hen sie meiner Meinung nach doch etwas die Lesbarkeit, anstatt X-Returncodes im Model zu definieren.</p>

<p>Die UserExceptions werden allerdings auch nur dort eingesetzt, wo wir das Backend definitiv ansprechen m&#252;ssen (z.B. ob ein Login schon vorhanden ist). </p>

<p><strong>GenericResponse</strong>

  <br />Die &quot;GenericResponse&quot; Klasse blieb trotzdem noch eine ganze Weile weiter im Projekt bestehen und wurde weiterhin verwendet, auch wenn wir die Features nicht mehr wirklich gebraucht haben. Dabei war allerdings der Schreibaufwand enorm. 

  <br />Wir nehmen als Beispiel eine Klasse, welche einfach einen Bool zur&#252;ckgibt. Mit unserer Variante musst man daraus sowas machen:</p>

<p></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:53ee5aaf-04aa-426a-9feb-af50638b8e2e" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public GenericResponse&lt;bool&gt; DoSomething()
{
	bool result = this.Repository.Get(BLABLABLA);
	return new GenericResponse&lt;bool&gt; { Value = result };
}</pre></div>

<p></p>

<p>Das hat die Lesbarkeit nicht sonderlich erh&#246;ht und war auch sehr bescheiden zu entwickeln. Daher ist es nun auch rausgeflogen :) (nach 1,5h Refactoring)&#160; <br />

  <br />Ganz am Anfang, ohne die Exceptions, mussten wir den Code so schreiben:</p>

<p>
  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:0a2ced4c-a0e9-4c93-9122-8f78503ced55" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public GenericResponse&lt;bool&gt; DoSomething()
{
	bool result = this.Repository.Get(BLABLABLA);
	return new GenericResponse&lt;bool&gt; { Value = result, Result = ServiceResult.Succeeded };
}</pre></div>
</p>

<p>Da finde ich nun die Exceptions charmanter, allerdings lassen wir uns gerne eines besseren Belehren ;)</p>
<strong></strong>

<p><strong>GenericRequest</strong> 

  <br />Die Request Klasse ist allerdings aktuell noch drin, auch wenn wir uns derzeit &#252;ber die Sinnhaftigkeit streiten. Einmal gibt es den eigentlich Parameter den die Methode haben will und wir schleifen in diesem Objekt immer noch den aktuellen Benutzer durch, sodass wir im ServiceLayer auch pr&#252;fen k&#246;nnen, ob der Nutzer diese oder jene Aktion ausf&#252;hren kann oder darf. Das Konzept steht soweit noch, allerdings werden wir das wohl etwas vereinfachen.</p>

<p><strong>Mein Fazit 
    <br /></strong>Je einfacher etwas ist, desto besser. Auch wenn die Konzepte und Ideen vielleicht gut sind, muss man sich immer fragen, ob es der Aufwand wert ist alles in X Objekte unterzuverschachteln, denn den puren Tippaufwand sollte man nicht vernachl&#228;ssigen - selbst mit Resharper und allen Tricks ist ein &quot;return true&quot; schneller geschrieben als &quot;return new GenericResponse&lt;bool&gt; { Value = true}&quot;.</p>

<p>So richtig gl&#252;cklich bin ich mit unserem Exceptionhandling noch nicht, allerdings erf&#252;llt es meine Anforderungen: Es ist einfach, von der Wartbarkeit her zu verschmerzen und ich kann zwischen den Schichten auch definierte &quot;Fehler&quot; weitergeben (durch die Errorcodes). </p>
