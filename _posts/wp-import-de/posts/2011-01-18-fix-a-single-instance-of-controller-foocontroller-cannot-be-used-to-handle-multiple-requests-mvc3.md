---
layout: post
title: "Fix: A single instance of controller 'FooController' cannot be used to handle multiple requests - MVC3"
date: 2011-01-18 22:34
author: robert.muehsig
comments: true
categories: [Fix]
tags: [Castle Windsor, IoC, MVC]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1167.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb349.png" width="162" height="116" /></a> </p>  <p>Ich benutze als IoC Framework Castle Windsor in einem ASP.NET MVC Projekt und bekam ein kleines Problem. Damit der IoC auch die Abhängigkeiten der Controller auflösen kann, müssen wir alle Controller ebenfalls in den Container hängen... doch das hatte einen kleinen Nebeneffekt.</p>  <p>Wir hängen alle unsere Controller in den Container über diesen Code. Der Woraround auf Zeile 8 behebt das Problem von oben.</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5a15d618-19c6-44ea-be6a-eebf36e399d1" class="wlWriterEditableSmartContent"><pre name="code" class="c#">private void InstallControllers(IWindsorContainer container)
        {
            var controllerTypes =
                 from t in typeof(HomeController).Assembly.GetTypes()
                 where typeof(IController).IsAssignableFrom(t)
                 select t;

            // workaround http://stackoverflow.com/questions/2784846/castle-windsor-controller-factory-and-renderaction
            foreach (Type t in controllerTypes)
                container.Register(Component.For(t).LifeStyle.Is(LifestyleType.Transient).Named(t.FullName));
        }</pre></div>

<p>Das Problem tritt auf, wenn man z.B. als LifestyleType.WebRequest reingibt und über RenderAction einen Controller mehrmals aufruft - das mag das Framework nicht und es kommt die schicke Fehlermeldung. Der Grund ist einfach: Es kommt ein HttpRequest an, also wird genau eine Instanz von Controller erstellt. Auf diese Instanz will er dann über RenderAction mehrmals zugreifen, was aber wohl nicht geht:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:6feb7d0f-34ff-4650-89c1-4f33b7718823" class="wlWriterEditableSmartContent"><pre name="code" class="c#">A single instance of controller 'MyController' cannot be used to handle multiple requests. If a custom controller factory is in use, make sure that it creates a new instance of the controller for each request.</pre></div>

<p>Der Fix: Als LifestyleType.Transient und das Problem war erstmal weg - ob das gut ist, kann ich noch nicht genau bestimmen ;)</p>
