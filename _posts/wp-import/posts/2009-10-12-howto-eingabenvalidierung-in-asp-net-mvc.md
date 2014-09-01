---
layout: post
title: "HowTo: Eingabenvalidierung in ASP.NET MVC"
date: 2009-10-12 22:04
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, HowTo, Javascript, jQuery, MVC, Validation]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image832.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="128" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb17.png" width="126" align="left" border="0"></a> Eingabenvalidierung ist ein sehr wichtiger Punkt in der Anwendungsentwicklung. Man sollte niemals blind User-Eingaben vertrauen. Neben "fehlerhaften" Eingaben, gibt es auch noch die böswilligen Eingaben. In diesem Blogposts geht es um dieses Thema und wie man das in ASP.NET MVC machen kann.</p><p><strong>Unser Szenario</strong></p> <p>In unserem Szenario haben wir eine kleines Formular in dem man eine Email-Adresse hinterlegen kann und sein Feedback abgeben kann. <br><strong><u>Hinweis:</u></strong> In einem anderen Blogpost habe ich die grundsätzliche Kommunikation von View zu Controller genauer beschrieben. <a href="{{BASE_PATH}}/2009/04/02/howto-daten-vom-view-zum-controller-bermitteln-bindings-in-aspnet-mvc/">Siehe Hier</a>.</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image833.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="224" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb18.png" width="244" border="0"></a> </p> <p>Beides Felder sollen Pflichtfelder sein. </p> <p><strong>Der View:</strong></p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:f24d545e-4ab9-491a-94b3-c101933334d1" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;form method="post" action="&lt;%=Url.Action("Index", "Home") %&gt;" id="ContactForm"&gt;
        &lt;fieldset&gt;
            &lt;legend&gt;Fields&lt;/legend&gt;
            &lt;p&gt;
                &lt;label for="Name"&gt;Name:&lt;/label&gt;
                &lt;%= Html.TextBox("Email") %&gt;
           &lt;/p&gt;
            &lt;p&gt;
                &lt;label for="Description"&gt;Feedback:&lt;/label&gt;
                &lt;%= Html.TextArea("Feedback") %&gt;
            &lt;/p&gt;
            &lt;p&gt;
                &lt;input type="submit" value="Create" /&gt;
            &lt;/p&gt;
        &lt;/fieldset&gt;

    &lt;/form&gt;</pre></div>
<p>Wir bedienen uns hier in dem View bei den HtmlHelpern von ASP.NET MVC. Warum wir dies machen, erklär ich gleich. Ansonsten ist das HTML Formular sehr einfach aufgebaut. Mit einem Klick auf "Create" wird die Form zur "Index"-Action Method des "Home" Controllers geschickt.</p>
<p><strong>Der Controller:</strong></p>
<p>In meinem Beispielcode gehe ich davon aus, dass jegliche Eingaben ungültig sind - das ist nicht besonders logisch, sollte aber als Beispiel hier reichen ;)</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:da61cf1a-c5dd-468d-b9d8-65f6b30c2118" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Index(string Email, string Feedback)
        {
            ModelState.AddModelError("Email", "Check it!");
            ModelState.AddModelError("Feedback", "No feedback? Oh no!");

            return View();
        }</pre></div>
<p><a href="{{BASE_PATH}}/assets/wp-images/image834.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="104" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb19.png" width="244" align="left" border="0"></a>Die Daten kommen als Parameter an und ich füge dem ModelState "Errors" hinzu. Wichtig ist der Key. Dieser muss mit dem "Key" des Html Feldes übereinstimmen.</p>
<p>In meinem Beispiel wird dies nun wieder zurück zum View geleitet.</p>
<p><strong>Die Html Helper</strong></p>
<p> An dieser Stelle kommen nun die HTML Helper ins Spiel. Die Helper schauen im ViewData nach, ob es Errors gibt:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image835.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="227" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb20.png" width="398" border="0"></a> </p>
<p>Neben der Fehlermeldung wird auch der alte Wert wieder übermittelt:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image836.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="244" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb21.png" width="234" border="0"></a> </p>
<p>Dadurch sieht der Nutzer seinen alten Wert wieder und dem Html Input Feld wird eine "Error" Klasse angehangen.</p>
<p><strong>Ausgabe der Fehlermeldungen</strong></p>
<p>Damit die Fehlermeldung nun noch erscheint, müssen wir unser HTML etwas erweitern:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:8f6acbf8-c210-4e42-91b4-39b859f44663" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;%= Html.ValidationSummary() %&gt;

    &lt;form method="post" action="&lt;%=Url.Action("Index", "Home") %&gt;" id="ContactForm"&gt;
        &lt;fieldset&gt;
            &lt;legend&gt;Fields&lt;/legend&gt;
            &lt;p&gt;
                &lt;label for="Name"&gt;Name:&lt;/label&gt;
                &lt;%= Html.TextBox("Email") %&gt;
                &lt;%= Html.ValidationMessage("Email")%&gt;
            &lt;/p&gt;
            &lt;p&gt;
                &lt;label for="Description"&gt;Feedback:&lt;/label&gt;
                &lt;%= Html.TextArea("Feedback") %&gt;
                &lt;%= Html.ValidationMessage("Feedback")%&gt;
            &lt;/p&gt;
            &lt;p&gt;
                &lt;input type="submit" value="Create" /&gt;
            &lt;/p&gt;
        &lt;/fieldset&gt;</pre></div>
<p>Html.ValidationSummary: Dieses gibt eine Zusammenfassung der Fehler als Liste zurück.</p>
<p>Html.ValidationMessage: Dieser Helper gibt ein Fehler-Label für den jeweiligen Key zurück.</p>
<p><strong>Ergebnis:</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image837.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="188" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb22.png" width="244" border="0"></a> </p>
<p>Das sieht doch schon ganz nett aus. </p>
<p><strong>Client-Seitige Validierung</strong></p>
<p>Für eine bessere Userexperience ist es immer gut, wenn man den Nutzer schon vorher informiert, ob die Daten valide sind. So kann man bereits auf Client-Seite prüfen ob alle benötigten Felder gefüllt sind oder nicht.</p>
<p>Dazu nehme ich gerne das jQuery Plugin "<a href="http://bassistance.de/jquery-plugins/jquery-plugin-validation/">jQuery Validation</a>". Auf der Demoseite sieht man die vielfältige Nutzung: <strong><a href="http://jquery.bassistance.de/validate/demo/">Demo</a></strong>.</p>
<p>Dazu muss man sich die jQuery Validation Bibliothek runterladen und jQuery sowie jQuery Validation einbinden.</p>
<p><strong>jQuery Validation Konfigurieren</strong></p>
<p>jQuery Validation wird über den Javascript Aufruf "konfiguriert". Dieses Javascript steht bei meinem Beispiel im Head der Seite und wird ausgeführt, sobald die HTML Seite fertig beim Client geladen ist:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b0b9f052-6fd3-49c8-b291-ede4e395b9be" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    $().ready(function() {
        $("#ContactForm").validate({
            rules: {
                Email: { required: true, email: true },
                Feedback: "required"
            }
        });
    });</pre></div>
<p>Hiermit wird einfach gesagt: Validiere mir die "ContactForm" mit folgenden Rules. Es muss ein Email-Feld geben, welches gefüllt sein muss und eine Email enthalten soll sowie ein Feedback-Feld, welches ebenfalls gefüllt sein muss.</p>
<p>Falls z.B. eine ungültige Email eingegeben wurde, wird noch bevor das Formular gesendet wird diese Fehlermeldung ausgegeben:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image838.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="78" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb23.png" width="244" border="0"></a> </p>
<p>Das Plugin kann man weitgehend konfigurieren - auch die Fehlermeldungen kann man anpassen. Dazu am besten auf der <a href="http://bassistance.de/jquery-plugins/jquery-plugin-validation/">Pluginseite</a> selbst suchen.</p>
<p><strong>jQuery Validation &amp; Html.ValidateMessages vereinen</strong></p>
<p>Damit man nur eine CSS Klasse für die Fehlermeldungen pflegen muss, empfiehlt es sich, dass beide Fehlermeldungen dieselbe CSS Klasse nutzen. Dazu kann man jQuery Validation anpassen oder den Html Helper. Wir haben dies über den Html Helper gemacht.</p>
<p>Das fertige Resultat:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:f3677bac-e9fa-406b-bcdf-61af170d72d2" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    &lt;%= Html.ValidationSummary() %&gt;

    &lt;form method="post" action="&lt;%=Url.Action("Index", "Home") %&gt;" id="ContactForm"&gt;
        &lt;fieldset&gt;
            &lt;legend&gt;Fields&lt;/legend&gt;
            &lt;p&gt;
                &lt;label for="Name"&gt;Name:&lt;/label&gt;
                &lt;%= Html.TextBox("Email") %&gt;
                &lt;%= Html.ValidationMessage("Email",
                                            new
                                            {
                                                @class = "error",
                                                generated = "true",
                                                @for = "Email"
                                            })%&gt;
            &lt;/p&gt;
            &lt;p&gt;
                &lt;label for="Description"&gt;Feedback:&lt;/label&gt;
                &lt;%= Html.TextArea("Feedback") %&gt;
                &lt;%= Html.ValidationMessage("Feedback",
                                            new
                                            {
                                                @class = "error",
                                                generated = "true",
                                                @for = "Feedback"
                                            })%&gt;
            &lt;/p&gt;
            &lt;p&gt;
                &lt;input type="submit" value="Create" /&gt;
            &lt;/p&gt;
        &lt;/fieldset&gt;

    &lt;/form&gt;</pre></div>
<p>Damit werden jetzt alle Fehlermeldungen mit der "Error" CSS Klasse gerendert.</p>
<p><strong>Vermischtes:</strong></p>
<p><strong>HTML Input</strong></p>
<p>Per Default wird HTML Input in MVC als Exception verworfen - wer also "&lt;/html&gt;" oder ähnliches in die Box eingibt, bekommt eine Exception zu sehen bzw. die Fehlerseite.<br>Dies kann man mit dem Attribute "[ValidateInput(false)]" unterbinden. Mehr Informationen dazu auf dem <a href="http://stephenwalther.com/blog/archive/2009/02/20/tip-48-ndash-disable-request-validation.aspx">Blog von Stephen Walther</a>.</p>
<p><strong>Styling Tipps für Fehlermeldungen</strong></p>
<p>Gute Tipps, wie man sein Webformular mit Fehlermeldungen "aufwerten" kann liefert das <a href="http://www.smashingmagazine.com/2009/07/07/web-form-validation-best-practices-and-tutorials/">SmashingMagazin</a>. Ein Blick lohnt sich :)</p>
<p><strong>ModelState zu einer anderen Seite "weiterschleifen"</strong></p>
<p>Würden wir in einem Fehlerfall nicht "return View()" sondern den Nutzer z.B. zu einer anderen Action Umleiten wird der gesamte ModelState wieder geleert. In diesem Fall kann man sich den ModelState in das "TempData" schreiben. Am einfachsten geht dies über einen ActionFilter. <br>Hier empfehle ich den <a href="http://weblogs.asp.net/rashid/archive/2009/04/01/asp-net-mvc-best-practices-part-1.aspx">Punkt 13 der ASP.NET MVC Best Practices</a>.</p>
<p><strong>xVal - Validation Framework für ASP.NET MVC</strong></p>
<p><a href="http://xval.codeplex.com/">xVal</a> ist ein Framework, welches serverseitig und clientseitig validieren kann:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image839.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="192" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb24.png" width="494" border="0"></a> </p>
<p>Steve Sanderson ist der Autor dieses Frameworks und hat es <a href="http://blog.codeville.net/2009/01/10/xval-a-validation-framework-for-aspnet-mvc/">auf seinem Blog beschrieben</a>.</p>
<p><strong>Die Zukunft: ASP.NET MVC 2</strong></p>
<p>In ASP.NET MVC 2 wird das Thema Eingabenvalidierung <a href="http://weblogs.asp.net/scottgu/archive/2009/07/31/asp-net-mvc-v2-preview-1-released.aspx">nochmal weiter ausgebaut</a>. Auch jQuery Validation findet sich direkt im Template wieder. </p>
<p><strong>Fazit</strong></p>
<p>Eingabenvalidierung ist in ASP.NET MVC meiner Meinung nach sehr flexibel gelöst und es ist auch relativ schnell einzubauen und über Javascript und co. auch für die "Client" Seite gerüstet. Auch größere Formulare kann man also gut mit ASP.NET MVC + jQuery Validation für den Anwender nett gestalten :)</p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/mvcvalidation/mvcvalidation.zip">[Downloade Democode]</a></strong></p>
