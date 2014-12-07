---
layout: post
title: "HowToCode: ErrorCodes, Exceptions, den User informieren, wenn etwas schief läuft - wie gehts?"
date: 2009-02-06 01:46
author: robert.muehsig
comments: true
categories: [HowToCode]
tags: [Errors, Exceptions, HowTo, HowToCode]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image639.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="118" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb617.png" width="89" align="left" border="0" /></a> Usereingaben validieren, durch die Businesslogik schicken, dem Nutzer evtl. Fehler wieder anzeigen - fast jedes System macht sowas, doch wie macht man es &quot;richtig&quot;? Definiert man Errorcodes? Was ist mit Mehrsprachigkeit? In dem Post zeige ich meine Variante und bitte auch um Feedback :)</p> 
<!--more-->
  <p><strong>Ausgangssituation:     <br /></strong>Ich arbeite gerade in einem Projekt mit einem Kollegen (worum es geht, werde ich sp&#228;ter auch nochmal genauer beschreiben - spielt aber jetzt keine Rolle) und nutzen eine <a href="{{BASE_PATH}}/2008/07/09/howto-3-tier-3-schichten-architektur/">klassische 3-Schichten Architektur</a> mitsamt <a href="http://www.asp.net/mvc">ASP.NET MVC</a> als Frontend.</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image640.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="139" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb618.png" width="285" border="0" /></a> </p>  <p>Unser Business Layer haben wir, <a href="{{BASE_PATH}}/2008/08/13/howtocode-readyou-evolution-der-architektur/">wie bei meinem ReadYou Projekt</a> (was ich so nie beendet hab, aber die Ideen leben in dem anderen Projekt weiter) als &quot;Service&quot; Layer implementiert.</p>  <p><strong>Service Layer?</strong>     <br />Jeder Service hat ein Request und Response Objekt was jeweils rein bzw. raus geht. Dadurch hab ich dies etwas gekapselt und kann neben dem eigentlich Wert noch weitere Information rausgeben. </p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image641.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="170" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb619.png" width="240" border="0" /></a> </p>  <p>Warum und wie ich das mache, habe ich <a href="{{BASE_PATH}}/2008/08/13/howtocode-readyou-evolution-der-architektur/">in diesem Post auch</a> noch n&#228;her erkl&#228;rt.</p>  <p>Ich hab ein kleines Demoprogramm entwickelt, welches stark vereinfacht (keine Interfaces, kein DI, keine Tests) zeigt, wie meine Variante momentan ist.    <br />Ich bin mir nicht ganz sicher, ob es so toll ist - <strong>daher bitte ich im Feedback</strong>, wie ihr sowas l&#246;st. </p>  <p><strong>Demoprojekt:</strong></p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image642.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="344" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb620.png" width="221" align="left" border="0" /></a> </p>  <p>ConApp: Frontend </p>  <p>Model: Das Application Model - umfasst hier nur einen User</p>  <p>Repository: Datenzugriffsschicht - hier werden ein paar User zur&#252;ckgegeben</p>  <p>Service: Business Logik</p>  <p>&#160;</p>  <p>&#160;</p>  <p>&#160;</p>  <p>&#160;</p>  <p><strong>Das Model &amp; das Repository:</strong></p>  <p>Das <strong>Model</strong> ist sehr einfach gehalten:</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:0da5399b-9d4b-4431-bdea-52e69addccad" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class User
    {
        public string Name { get; set; }
        public Guid Id { get; set; }
    }</pre></div>

<p>Das <strong>UserRepository</strong> erstellt mir einfach 5 User:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a4267da7-0eb8-4c41-807c-275973120bdd" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">namespace Repository
{
    public class UserRepository
    {
        public IList&lt;User&gt; GetUsers()
        {
            List&lt;User&gt; returnList = new List&lt;User&gt;();
            returnList.Add(new User() { Id = Guid.NewGuid(), Name = "Tester0" });
            returnList.Add(new User() { Id = Guid.NewGuid(), Name = "Tester1" });
            returnList.Add(new User() { Id = Guid.NewGuid(), Name = "Tester2" });
            returnList.Add(new User() { Id = Guid.NewGuid(), Name = "Tester3" });
            returnList.Add(new User() { Id = Guid.NewGuid(), Name = "Tester4" });

            return returnList;
        }
    }
}
</pre></div>

<p><strong>Der Service:</strong></p>

<p>Der Service enth&#228;lt <strong>generische Request und Response Klassen:</strong></p>

<p><strong>Request:</strong></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d9e96d84-60c6-44ae-8700-04a75a4a6ba9" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class ServiceRequest&lt;T&gt;
    {
        public T Value { get; set; }
    }</pre></div>

<p><strong>Response (inklusive 2 Enums) :</strong></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:02ce981f-e695-46bf-bd05-36e7f8542ef4" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class ServiceResponse&lt;T&gt;
    {
        public ServiceResult Result { get; set; }
        public ErrorCodes ErrorCodes { get; set; }
        public Exception Exception { get; set; }
        public T Value { get; set; }
    }

    /// &lt;summary&gt;
    /// Usererror Codes?
    /// &lt;/summary&gt;
    public enum ErrorCodes
    {
        InvalidName,
        NothingFound
    }

    /// &lt;summary&gt;
    /// Succeeded = Everything worked
    /// Failed = Userinput incorrect or business logic has detected an error
    /// Fatal = exception occured (e.g. db down)
    /// &lt;/summary&gt;
    public enum ServiceResult
    {
        Succeeded,
        Failed,
        Fatal
    }</pre></div>

<p>Hier eine kleine Erkl&#228;rung:
  <br />Das ServiceResult gibt einfach an, ob der Call geklappt (&quot;Succeeded&quot;) oder fehlgeschlagen ist. Wenn er fehlgeschlagen ist, dann kann das aufgrund von Fehleingaben sein, oder weil die Business Logik sagt, dass z.B. der Login inkorrekt ist (&quot;Failed&quot;). Die verschiedenen Userfehler gr&#252;nde speichere ich in einem ErrorCode Enum.

  <br />Ein &quot;Fatal Error&quot; w&#228;re, wenn tats&#228;chlich das Repository z.B. eine SqlExpcetion werfen w&#252;rde. Diese Exception speicher ich in einer Variable.</p>

<p><strong>Code smell
    <br /></strong>So ganz bin ich mit der momentanen L&#246;sung allerdings <a href="http://en.wikipedia.org/wiki/Code_smell">nicht zufrieden</a> - ein ErrorCodes Enum? Das wird sicher irgendwann ziemlich gro&#223;.

  <br />Beim Entwickeln der Anwendung fiel mir bereits auf, dass man die Exceptions auch in die n&#228;chste Schicht &#252;ber ein throw bef&#246;rdern k&#246;nnte - ist das gut oder eher schlecht? Wenn ich es im Service mache, dann brauch ich die Exceptionbehandlung nicht im Frontend zu erledigen, sondern kann ein &quot;Fatal&quot; weitergeben und dem Nutzer sagen, dass die Anwendung gerade einen Fehler verursacht hat.

  <br />Soweit, so gut - hier jetzt der UserSerivce</p>

<p><strong>Der UserService:
    <br /></strong></p>
<strong>
  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ee378046-fd57-4645-91b0-13a1863c029c" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public class UserService
    {
        public ServiceResponse&lt;User&gt; GetUser(ServiceRequest&lt;string&gt; userName)
        {
            // simulate Usererror 
            if (String.IsNullOrEmpty(userName.Value))
            {
                return new ServiceResponse&lt;User&gt;()
                {
                    Result = ServiceResult.Failed,
                    ErrorCodes = ErrorCodes.InvalidName
                };
            }

            // simulate Systemerror
            if (userName.Value == "Tester0")
            {
                return new ServiceResponse&lt;User&gt;()
                {
                    Result = ServiceResult.Fatal,
                    Exception = new ArgumentException()
                };
                // or should I throw it???
            }

            // everything works
            UserRepository rep = new UserRepository();
            User result = rep.GetUsers().ToList().Where(x =&gt; x.Name == userName.Value).SingleOrDefault();
            // nothing found
            if (result == null)
            {
                return new ServiceResponse&lt;User&gt;() { Result = ServiceResult.Failed, ErrorCodes = ErrorCodes.NothingFound };
            }
            else
            {
                return new ServiceResponse&lt;User&gt;() { Value = result, Result = ServiceResult.Succeeded };
            }
        }
    }</pre></div>
</strong>

<p>Hier hab ich mal die verschiedenen F&#228;lle implementiert. 
  <br />Als erstes pr&#252;ft man, ob der Nutzer &#252;berhaupt was eingegeben hat, wenn nicht, dann gibt er &quot;Failed&quot; mit dem passenden ErrorCode zur&#252;ck.</p>

<p>Um ein Exception (also einen Fatal Error) zu simulieren, &#252;bergibt man Tester0. In diesem Fall reicht man die Exception weiter. Hier war ich mir selber auch unsicher - sollte man die Exception nach oben bef&#246;rdern? 
  <br />Ich hab mich f&#252;r diese Variante entschieden, da der Service bei mir mit der Kern ist. Hier kann der Fehler entsprechend behandelt werden und der, der die Methode Aufruft, bekommt die Exception mit, die es ausgel&#246;st hat - um es z.B. zu loggen.</p>

<p>Danach ruf ich das Repository auf und wenn etwas gefunden wurde, dann gibt es ein &quot;Succeeded&quot;, ansonsten ein &quot;Failed&quot;.</p>

<p><strong>ConApp</strong></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:6e722a4a-ab02-4b8f-9909-c7567408c4d0" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Enter Username");
            Console.WriteLine("(Tester0 == Systemerror)");
            Console.WriteLine("(enter nothing == Usererror)");

            string username = Console.ReadLine();

            UserService srv = new UserService();
            ServiceResponse&lt;User&gt; result = srv.GetUser(new ServiceRequest&lt;string&gt;() { Value = username });

            if (result.Result == ServiceResult.Succeeded)
            {
                Console.WriteLine("Service Call Succeeded");
                Console.WriteLine(result.Value);
            }

            if (result.Result == ServiceResult.Failed)
            {
                Console.WriteLine("Service Call Failed");
                Console.WriteLine(result.ErrorCodes.ToString());
            }

            if (result.Result == ServiceResult.Fatal)
            {
                Console.WriteLine("Service Call Fatal Error");
                Console.WriteLine(result.Exception.ToString());
            }

            Console.ReadLine();
        }
    }</pre></div>

<p>Hier sieht man das ganze mal in Action. Durch den Einsatz der ErrorCodes k&#246;nnte man an dieser Stelle sogar noch einen anderen Service aufrufen, der den Code in ein passenden, Userfreundlichen (in in seiner Sprache geschriebenen) Satz umwandeln k&#246;nnte.</p>

<p><strong>Kann man sich die ErrorCodes nicht sparen?</strong></p>

<p>Nat&#252;rlich k&#246;nnte ich auch Exceptions daf&#252;r nehmen, allerdings steht dort in den Messages nicht wirkich Userfreundliche Informationen drin. Ich wollte auch eine Art Trennung zwischen &quot;Systemfehlern&quot; und &quot;Userfehlern&quot; dadurch erzwingen.</p>

<p>Die Applikation kann man nat&#252;rlich runterladen. Ich <strong>w&#252;rde mich freuen wenn ihr Feedback darauf gebt</strong> - sind Enums die Erf&#252;llung? Geht es nicht &quot;sch&#246;ner&quot;? Was haltet ihr von dem Gesamtkonstrukt? Wenn ihr selber ein Demoprojekt habt, dann schickt es an meine Emailadresse (siehe Impressum) - f&#252;r Anregung bin ich immer dankbar :)</p>

<p><a href="{{BASE_PATH}}/assets/files/democode/errors/errors.zip">[ Download Demoapplikation ]</a></p>
