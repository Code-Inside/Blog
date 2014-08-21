---
layout: post
title: "Modelbinding mit komplexen Objekten in ASP.NET MVC"
date: 2012-07-18 01:00
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, Modelbinding]
---
{% include JB/setup %}
<p>Vor einer ganzen Weile habe ich schon über das Thema <a href="{{BASE_PATH}}/2009/04/02/howto-daten-vom-view-zum-controller-bermitteln-bindings-in-aspnet-mvc/">Modelbinding (oder wie übertrage ich Daten vom View zum Controller)</a> geschrieben. Allerdings ist der Blogpost etwas älter und ging nur unzureichend auf komplexe Objekte und Auflistungen dieser ein.</p> <p><strong><u>Grundsatz:</u></strong> Das Modelbinding in ASP.NET MVC ist “relativ” clever und man kann <em>fast</em> alles binden. Man muss nur verstehen wie das Binding funktioniert und meist erklärt es sich, wenn man mal über Fiddler und co. nachschaut was per HTTP über die Leitung geht.</p> <p><strong>Objektmodell</strong></p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:3a1676be-2939-496e-98b5-8726e694d449" class="wlWriterEditableSmartContent"><pre name="code" class="c#">public class Foobar
{
    public string Buzz { get; set; }

    public int Foo { get; set; }

    public List&lt;Foobar&gt; Children { get; set; } 
}

</pre></div>
<p>Das Modell ist recht simpel, enthält aber als Liste wiederrum Objekte des selben Typs.</p>
<p><strong>Action Method</strong></p>
<p>Wir wollen die Daten an diesen Controller schicken (welcher im Grunde nichts damit macht – reicht aber für das Modelbinding Beispiel) :</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:22285f79-b010-4c50-83c8-ee405900c554" class="wlWriterEditableSmartContent"><pre name="code" class="c#">public ActionResult Test(string name, List&lt;Foobar&gt; foobars)
{
	return View("Index");
}</pre></div>
<p><em></em>&nbsp;</p>
<p>Ich stelle 3 Varianten vor, wie wir beliebig komplexe Objekte in diese Methode reinbekommen.</p>
<p><strong>Variante 1: Einfache Form (Postback – kein AJAX)</strong></p>
<p>@using (Html.BeginForm("Test", "Home", FormMethod.Post)) <br>{<br>&nbsp;&nbsp;&nbsp; &lt;input type="text" name="Name" value="Testvalue" /&gt;<br>&nbsp;&nbsp;&nbsp; &lt;input type="text" name="Foobars[0].Buzz" value="Testvalue" /&gt;<br>&nbsp;&nbsp;&nbsp; &lt;input type="text" name="Foobars[0].Foo" value="123123" /&gt;<br>&nbsp;&nbsp;&nbsp; &lt;input type="text" name="Foobars[1].Buzz" value="Testvalue" /&gt;<br>&nbsp;&nbsp;&nbsp; &lt;input type="text" name="Foobars[1].Foo" value="123123" /&gt;<br>&nbsp;&nbsp;&nbsp; &lt;input type="text" name="Foobars[2].Buzz" value="Testvalue" /&gt;<br>&nbsp;&nbsp;&nbsp; &lt;input type="text" name="Foobars[2].Foo" value="123123" /&gt;<br>&nbsp;&nbsp;&nbsp; &lt;input type="text" name="Foobars[3].Buzz" value="Testvalue" /&gt;<br>&nbsp;&nbsp;&nbsp; &lt;input type="text" name="Foobars[3].Foo" value="123123" /&gt;<br>&nbsp;&nbsp;&nbsp; &lt;input type="text" name="Foobars[3].Children[0].Buzz" value="KIND!" /&gt;<br>&nbsp;&nbsp;&nbsp; &lt;input type="text" name="Foobars[3].Children[0].Foo" value="123123" /&gt;<br>&nbsp;&nbsp;&nbsp; &lt;button&gt;Ok&lt;/button&gt;<br>}</p>
<p>Über die “[ZAHL]” am Namen des Feldes weiß der MVC Binder, dass es sich um eine Liste handelt. Man kann das Ganze auch beliebig tief verschachteln. Wichtig ist an der Stelle, dass die Nummerierung durchgängig ist.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1575.png"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb736.png" width="562" height="392"></a></p>
<p>Wenn man sich anschaut was über die Leitung geht ist da auch nichts kompliziertes dran:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1576.png"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb737.png" width="558" height="255"></a></p>
<p><strong>Variante 2: Formular via jQuery mit AJAX abschicken</strong>&nbsp;</p>
<p>Den Trick hatte ich <a href="{{BASE_PATH}}/2010/02/09/howto-form-valuesinputs-ber-ajax-mit-jquery-serialize-bertragen/">bereits auch hier schon verraten</a>, aber um bei dem oberen Beispiel zu bleiben:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a5df2755-bf9e-4556-ba98-50001e74631b" class="wlWriterEditableSmartContent"><pre name="code" class="c#">$("#FormButton").click(function () {
    $.ajax({
        url: "@Url.Action("Test", "Home")",
        type: "POST",
        data: $("form").serializeArray()
    });

});
</pre></div>
<p>Ich hänge mich an das Click-Event eines Buttons und hole mir alle Daten via “<a href="http://api.jquery.com/serializeArray/">serializeArray()</a>”. Auch hier schauen wir uns mal was über die Leitung geht. Wichtig ist hier, dass es vom Content-Type trotzdem nur Formulardaten sind – kein JSON:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1577.png"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb738.png" width="552" height="314"></a>&nbsp;</p>
<p><strong>Variante 3: Mit Javascript erstellte Daten – Javascript Arrays per AJAX übermitteln</strong></p>
<p>Variante 1 und 2 gehen davon aus, dass es ein Formular gibt. Wenn man die Daten nur im Javascript&nbsp; zusammenbaut und auch keine “Hidden”-Form bauen möchte kann man diese Variante nutzen.</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:0cd8f518-e9e5-4a5c-b708-82e74f298749" class="wlWriterEditableSmartContent"><pre name="code" class="c#">$("#ScriptButton").click(function () {

    var foobars = new Array();

    for (i = 0; i &lt; 10; i++) {
        foobars.push({ Buzz: "Test!", Foo: 12123, Children: { Buzz: "Child!", Foo: 123213} });
    }

    var requestData = { };
    requestData.Name = "Testadalsdk";
    requestData.Foobars = foobars;
    
    $.ajax({
        url: "@Url.Action("Test", "Home")",
        type: "POST",
        contentType: 'application/json;',
        dataType: 'json',
        data: JSON.stringify(requestData)
    });

});
</pre></div>
<p>Im ersten Schritt erstellen wir uns ein Array im Javascript:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1578.png"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb739.png" width="528" height="244"></a></p>
<p>Dann erstellen wir uns “requestData” und setzen unser “Name”-Testproperty und hängen zusätzlich das Array daran.</p>
<p>Um dies jetzt an unseren Controller zu übermitteln müssen wir die Daten umwandeln. Am einfachsten gelingt dies über das JSON-Format. Neuere Browser haben eine native JSON Unterstützung, aber um sicher zu gehen empfiehlt es sich den JSON Helper von <a href="https://github.com/douglascrockford/JSON-js/blob/master/json2.js">Douglas Crockford “json2.js”</a> zu nehmen (gibt auch via NuGet).</p>
<p>Über dieses Script bekommt man die Methode “<a href="https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/JSON/stringify">JSON.stringify()</a>” (Link führt zum Mozilla Developer Center – dasselbe steht aber im Prinzip auch in der MSDN), welches ein Objekt in JSON umwandelt.</p>
<p>Dazu setzen wir im AJAX Request noch zusätzlich diese Propertys, damit unser Controller auch versteht was da überhaupt ankommt:</p>
<p><strong>contentType: 'application/json;',<br>dataType: 'json',</strong></p>
<p>Dies fliesst am Ende über die Leitung:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1579.png"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb740.png" width="525" height="352"></a></p>
<p>Durch den Content-Type: application/json nutzt das MVC Framework automatisch den JSON Modelbinder und die Daten kommen im Controller an.</p>
<p><strong>Fazit</strong></p>
<p>Man kann fast alles mit dem MVC Modelbinding machen wenn man ein paar Grundregeln beherrscht und ein Blick, was wirklich per HTTP übertragen wird hilft beim Debugging enorm.</p>
<p>Die gesamte Demoapplikation findet ihr <a href="https://github.com/Code-Inside/Samples/tree/master/2012/MvcModelbinding"><strong>hier</strong></a> – allerdings ist da auch noch Code drin von diesem <a href="{{BASE_PATH}}/2012/07/12/error-404-directory-schlgt-asp-net-mvc-routing/">Blogpost</a>.</p>
