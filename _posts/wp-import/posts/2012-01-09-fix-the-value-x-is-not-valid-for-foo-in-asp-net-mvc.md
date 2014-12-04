---
layout: post
title: "Fix: The value 'x' is not valid for Foo in ASP.NET MVC"
date: 2012-01-09 22:32
author: robert.muehsig
comments: true
categories: [Fix]
tags: [ASP.NET MVC, Validation]
language: de
---
{% include JB/setup %}
<p>Um Daten in einen MVC Controller zu bekommen ist das <a href="{{BASE_PATH}}/2009/04/02/howto-daten-vom-view-zum-controller-bermitteln-bindings-in-aspnet-mvc/">Modelbinding</a> von MVCeigentlich recht clever. Allerdings ist es etwas kompliziert, die Fehlermeldung zu setzen, wenn das Binding <strong>nicht</strong> geklappt hat. </p> <p><strong>Bsp:</strong></p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:8c3f8e40-1f0f-4acb-8e08-0d9f95fb40ee" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    public class RegisterModel
    {
		...

        [Required]
        [DataType(DataType.EmailAddress)]
        [Display(Name = "Email address")]
        public string Email { get; set; }

        [Required]
        [Display(Name = "Age")]
        public int Age { get; set; }

		...
    }</pre></div>
<p>&nbsp;</p>
<p>Dies ist das Standardmodell für die Registrierung in der ASP.NET MVC Projektvorlage. Ich habe ein Property “Age” vom Typ “int” hinzugefügt. Auch im View muss die mit angegeben werden:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:12d2651b-d593-4348-89a8-6d7d2c33a6ea" class="wlWriterEditableSmartContent"><pre name="code" class="c#">            ...
			&lt;div class="editor-label"&gt;
                @Html.LabelFor(m =&gt; m.Age)
            &lt;/div&gt;
            &lt;div class="editor-field"&gt;
                @Html.TextBoxFor(m =&gt; m.Age)
                @Html.ValidationMessageFor(m =&gt; m.Age)
            &lt;/div&gt;
			...</pre></div>
<p>&nbsp;</p>

<p><strong>Problem: Was passiert, wenn nun der Nutzer anstatt einer Zahl Buchstaben eingibt? </strong></p>
<p>Solange die <strong>ClientValidation</strong> <strong><u>an</u></strong> ist, ist auch alles gut:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1437.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb615.png" width="413" height="154"></a></p>
<p>Wenn sie allerdings aus ist kommt im Standardfall diese Fehlermeldung:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1438.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb616.png" width="405" height="96"></a></p>
<p>Die Fehlermeldung “The value ‘Test’ is not valid for Age.” wird direkt in den ModelState geschrieben:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1439.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb617.png" width="412" height="276"></a></p>
<p>Leider lässt sich diese <a href="http://forums.asp.net/t/1512140.aspx/1/10">Meldung nur recht kompliziert ändern</a> – dabei werden auch jegliche Sprachen ignoriert. Das sieht natürlich auf einer deutschen Seite nicht so schön aus.</p>
<p><strong>Fix: Ressourcen Datei erstellen</strong></p>
<p>Unter App_GlobalResources muss man eine Resource-Datei erstellen und ein Eintrag “<strong>PropertyValueInvalid</strong>” einfügen und dann dahinter den dazugehörigen Text:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1440.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb618.png" width="503" height="162"></a></p>
<p>In der Global.asax die Resource-Datei verlinken:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:4e461cc9-c77b-4ae6-ad23-3a600aab1180" class="wlWriterEditableSmartContent"><pre name="code" class="c#">		protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            DefaultModelBinder.ResourceClassKey = "Errors"; &lt;-- lookup in Errors.resx

            RegisterGlobalFilters(GlobalFilters.Filters);
            RegisterRoutes(RouteTable.Routes);
        }</pre></div>
<p>&nbsp;</p>
<p><strong>Ergebnis:</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1441.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb619.png" width="376" height="109"></a></p>
<p><strong>Hintergrund:</strong></p>
<p>Jegliche Validierunglogik kann nicht ausgeführt werden, da das Framework das Property nicht binden kann. Interessanterweise ist das Verhalten des Frameworks etwas anders wenn man eine zu große Zahl dem Int zuweisen möchte. In diesem Fall kommt im ModelState eine Exception an, welche man abfangen kann. Auch die Validierung kann da greifen. Das Problem trat bei mir auch nur im Zusammenhang von String-Eingaben auf.</p>
