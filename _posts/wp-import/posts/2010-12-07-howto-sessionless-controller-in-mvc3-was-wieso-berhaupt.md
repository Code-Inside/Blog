---
layout: post
title: "HowTo: Sessionless Controller in MVC3 – was & wieso überhaupt?"
date: 2010-12-07 00:25
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, HowTo, MVC, Session, Visual Studio 2010, WebTest]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image1134.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb316.png" width="184" height="96" /></a> </p>  <p>Momentan spiel ich etwas mit dem <a href="http://www.microsoft.com/downloads/en/details.aspx?FamilyID=a920ccee-1397-4feb-824a-2dfefee47d54">MVC3 RC</a> rum. Ein neues Feature, welches allerdings kaum groß verkündet wurde, ist die Einführung eines <a href="http://www.lostechies.com/blogs/dahlbyk/archive/2010/12/06/renderaction-with-asp-net-mvc-3-sessionless-controllers.aspx?utm_source=feedburner&amp;utm_medium=feed&amp;utm_campaign=Feed:+LosTechies+(LosTechies)&amp;utm_content=Google+International">SessionState Behaviour</a> um z.B. ein Controller gänzlich Stateless und Sessionless zu machen. Wie das geht, was die Fallen daran sind und wofür man es evtl. braucht habe ich mit meinem gesunden Halbwissen mal zusammengeschrieben :) </p>  <p><strong>Sessionless? Mein Versuchsaufbau</strong></p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1135.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb317.png" width="234" height="339" /></a> </p>  <p>Meine Demoanwendung besteht aus zwei Controllern. Der eine ist "sessionless” gemacht. Dazu gibt es noch zwei Views für die Ausgabe. Ansonsten entspricht die MVC App einer "Empty Website” (bis auf das Routing, was im Standardfall nun zum SessionController leitet.</p>  <p>&#160;</p>  <p>&#160;</p>  <p>&#160;</p>  <p>&#160;</p>  <p>&#160;</p>  
<p></p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c7c38a2a-5a0f-4ecc-b3f4-f57c4274bfdf" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    [ControllerSessionState(SessionStateBehavior.Disabled)]
    public class SessionLessController : Controller
    {

        //
        // GET: /SessionLess/

        public ActionResult Index()
        {
            Thread.Sleep(1000);
            ViewModel.Session = this.ControllerContext.HttpContext.Session;
            return View(ViewModel);
        }

    }</pre></div>

<p>Am interessantesten ist hier eigentlich das ControllerSessionState Attribute (Achtung: Irgendwo hatte ich gelesen, dass die noch in der Final anders benannt werden soll - einfach dann mal danach suchen ;) ).</p>

<p>Über das Attribut kann auf Controller-Ebene auf das Verhalten des Sessionstates Einfluss genommen werden:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1136.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb318.png" width="340" height="193" /></a> </p>

<p>Gänzlich ausschalten kann man es über "Disable”, dann ist die Session "null”.</p>

<p><strong>Was gibt es für Dinge zu beachten?</strong></p>

<p>Auf den ersten Blick: Man kann nicht auf die Session zugreifen. Das heisst man greift z.B. um den User wiederzuerkennen auf das FormsAuth Cookie etc. zurück. Sobald man etwas in das "TempData” schreiben will, <a href="http://www.dotnetcurry.com/ShowArticle.aspx?ID=609&amp;AspxAutoDetectCookieSupport=1">bekommt man eine Exception</a> "The SessionStateTempDataProvider class requires session state to be enabled”. Wenn man also Daten von Controller A zum Controller B irgendwie weiterschleifen möchte, müsste das z.B. in einem Cookie erfolgen. Es soll allerdings in den MVC Futures ein CookieStateTempDataProvider geben.</p>

<p><strong>Wofür soll das gut sein?</strong></p>

<p>Gute Frage, in diesem <a href="http://stackoverflow.com/questions/4139428/what-are-some-scenarios-of-having-a-session-less-controller-in-asp-net-mv3">Stackoverflow Post</a> hab ich eine interessante Begründung gefunden:</p>

<p><em>The release notes cover this more (you can download them from the download link above). Session state is designed so that only one request from a particular user/session occurs at a time. So if you have a page that has multiple AJAX callbacks happening at once they will be processed in serial fashion on the server. Going session-less means that they would execute in parallel.</em></p>

<p>Auch hier wird es recht gut erklärt: <a href="http://weblogs.asp.net/imranbaloch/archive/2010/07/10/concurrent-requests-in-asp-net-mvc.aspx">Concurrent Requests In ASP.NET MVC</a></p>

<p><strong>Hat es auf die Performance Auswirkungen?</strong></p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1137.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb319.png" width="244" height="105" /></a> Ich hab mal etwas rumexperimentiert mit den Visual Studio 2010 Test Tools und hab ohne das Thread.Sleep im Controller ein WebPerformanceTest mit 1000 Iterationen jeweils auf den Sessionless und einmal auf den "normalen” Controller losgelassen.</p>

<p><u>Achtung: Ich hab noch nie wirklich was mit den WebTest Tools von VS2010 gemacht, daher können meine Ergebnisse auch total banal und nicht richtig sein.</u></p>

<p>Die Tests liefen auf meinem Macbook in einer VM. Die WebApp wurde im IIS7 gehostet - die Werte spiegel also keine Performancegeschichten eines IIS wieder.</p>

<p>Ergebnisse bei 1000 Wiederholungen (also 1000 mal die Seite aufrufen) und KEIN Thread.Sleep:</p>

<table border="0" cellspacing="0" cellpadding="2" width="438"><tbody>
    <tr>
      <td valign="top" width="87">Durchgang</td>

      <td valign="top" width="179">SessionLess (Zeit in Sek)</td>

      <td valign="top" width="170">Session (Zeit in Sek)</td>
    </tr>

    <tr>
      <td valign="top" width="87">1</td>

      <td valign="top" width="179">5,70</td>

      <td valign="top" width="170">6,17</td>
    </tr>

    <tr>
      <td valign="top" width="87">2</td>

      <td valign="top" width="179">5,15</td>

      <td valign="top" width="170">6,21</td>
    </tr>

    <tr>
      <td valign="top" width="87">3</td>

      <td valign="top" width="179">5,28</td>

      <td valign="top" width="170">5,15</td>
    </tr>

    <tr>
      <td valign="top" width="87">4</td>

      <td valign="top" width="179">5,16</td>

      <td valign="top" width="170">6,74</td>
    </tr>

    <tr>
      <td valign="top" width="87">5</td>

      <td valign="top" width="179">5,13</td>

      <td valign="top" width="170">5,54</td>
    </tr>

    <tr>
      <td valign="top" width="87">6</td>

      <td valign="top" width="179">6,68</td>

      <td valign="top" width="170">5,50</td>
    </tr>

    <tr>
      <td valign="top" width="87">7</td>

      <td valign="top" width="179">5,12</td>

      <td valign="top" width="170">5,17</td>
    </tr>

    <tr>
      <td valign="top" width="87">8</td>

      <td valign="top" width="179">5,30</td>

      <td valign="top" width="170">5,66</td>
    </tr>

    <tr>
      <td valign="top" width="87">9</td>

      <td valign="top" width="179">6,28</td>

      <td valign="top" width="170">5,30</td>
    </tr>

    <tr>
      <td valign="top" width="87">10</td>

      <td valign="top" width="179">4,98</td>

      <td valign="top" width="170">5,27</td>
    </tr>
  </tbody></table>

<p>Hier und da gibt es ein paar Ausreißer auf beiden Seiten, jedoch scheint der Sessionless Controller etwas schneller zu sein. </p>

<p>Ich hab noch einen anderen Test gemacht (einen so genannten "LoadTest”), die Zahlen daraus sind ähnlich. Am Rande erwähnt: Sehr interessantes Tool, da müsste man sich näher damit befassen. Ich geh aber nicht weiter darauf ein.</p>

<p><strong>Fazit</strong></p>

<p>In Hinblick auf Skalierbarkeit und "große” Webapplikationen ist es vielleicht interessant sich mit dem Thema näher zu befassen. Für eine 0815 Seite sehe ich allerdings da keinen richtigen Bedarf. Etwas in die Session zu packen ist manchmal recht bequem und z.B. bei Wizard ähnlichen Anwendungen sehr nett. Natürlich darf da kein Wildwuchs entstehen. Ich kann mich bei meiner Einschätzung aber auch täuschen ;) </p>

<p></p>

<p><a href="{{BASE_PATH}}/assets/files/democode/mvcsessionless/mvcsessionless.zip">[ Download Sample ]</a> (Achtung: Für das Testprojekt ist evtl. eine höherwertige Visual Studio Version notwendig)</p>
