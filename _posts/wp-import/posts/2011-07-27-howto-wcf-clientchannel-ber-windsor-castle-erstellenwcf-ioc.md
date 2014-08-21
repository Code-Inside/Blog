---
layout: post
title: "HowTo: WCF ClientChannel über Windsor Castle erstellen–WCF & IoC…"
date: 2011-07-27 22:48
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [IoC, WCF, Windsor Castle]
---
{% include JB/setup %}
<p>Mit WCF zu arbeiten ist einerseits schön, auf der anderen Seite aber auch etwas frustrierend. Positiv ist, dass man durch die ServiceContracts die Services “fast” so behandeln kann wie normale .NET Aufrufe. Es wird aber etwas knifflig, wenn man es nun sich den Proxy für den WCF Aufruf über einen DI (<a href="{{BASE_PATH}}/2010/03/15/howto-dependency-injection-service-locator/">Was ist eigentlich “Dependency Injection/DI”?</a>) Container aufbauen lassen möchte. In diesem Beispiel wird der DI Container <a href="http://www.castleproject.org/container/">Windsor Castle</a> benutzt um diese ServiceContracts richtig aufzulösen..</p> <p><em>Anmerkung: Wir hatten in einem Projekt das Problem, dass wir zwar WCF Channels über die ChannelFactory und Windsor Castle aufbauen konnten, diese allerdings nicht wieder sauber schließen konnten. Ein Großteil der Erkenntnisse hier beruhen auf der Arbeit von meinen Kollegen Rico Fritzsche und Oliver Guhr.</em></p> <p><strong>Szenario</strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1309.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 5px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb491.png" width="178" height="244"></a></p> <p>Dies ist unser Demoprojekt. Es gibt eine Assembly, welche den Contract des Service enthält und die entsprechende Implementierung.</p> <p>Unser Ziel war es nun den “IService1” in unserem Client Projekt über Windsor Castle nutzbar zu machen.</p> <p>Der Contract selbst enthält nur eine Methode und die Implementierung ist auch nicht der Rede wert bzw. müsste sogar das WCF Start Template sein.</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p><strong>Client – Projekt: Den WCF Service konsumieren</strong></p> <p>In meinem Client Projekt gibt es diese Testklasse (samt Interface), welche den IService1 konsumieren möchte.</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:59c3aea1-0984-485f-ba04-7a41563395d6" class="wlWriterEditableSmartContent"><pre name="code" class="c#">	public interface IFoo
    {
        void Do();
    }

    public class Foo : IFoo
    {
        public IService1 Service1 { get; set; } 
        public Foo(IService1 srv)
        {
            this.Service1 = srv;
        }

        public void Do()
        {
            Console.WriteLine(this.Service1.GetData(999));
        }
    }</pre></div>
<p>&nbsp;</p>
<p>Die Klasse “Foo” nimmt im Konstruktor den IService1 entgegen. Diese Abhängigkeit wollen wir nun über Windsor Castle reingeben lassen.</p>
<p><strong>Das Problem mit WCF…</strong></p>
<p>An dieser Stelle möchte ich nochmal unser eigentliches Problem erläutern: Da ich hier nur mit dem Interface arbeite, habe ich in der Klasse “Foo” eigentlich auch gar keine Ahnung davon, dass ich überhaupt mit einem WCF Service rede. Das ist besonders dann toll, wenn man Unit-Tests schreiben will.</p>
<p><u>ABER:</u> Natürlich muss man bei WCF ein paar Sachen beachten. Dazu zählt unter anderem auch die Verbindung, welche ich über mein IoC aufbauen muss, auch wieder abzubauen sollte. Ansonsten bleiben Kanäle offen und irgendwie ist das unschön und auch nicht wirklich sauber.</p>
<p><strong>Die Lösung: Windsor Castle Interceptors für den WCF Channel</strong></p>
<p>Kurzes Vorwort, was eigentlich Interceptors sind: Über Interceptors kann ich bestimmte Aspekte an eine Komponente zusätzlich dran “heften”. Sofern ich es richtig verstanden habe, passiert dies meist über eine Art “Proxy”, welcher sich um die eigentliche Komponente legt. Es gibt allerdings verschiedene Arten. Hier in diesem <a href="http://blog.andreloker.de/post/2009/02/20/Simple-AOP-integrating-interceptors-into-Windsor.aspx">Blogpost</a> gibt es noch zusätzliche Informationen darüber.</p>
<p>Der Interceptor Code sieht so aus:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b8c6c2d2-80bd-4846-9feb-321dc93258eb" class="wlWriterEditableSmartContent"><pre name="code" class="c#">public class WcfProxyInterceptor&lt;TService&gt; : IInterceptor
    {
        public void Intercept(IInvocation invocation)
        {
            var backendWsHttpBinding = new BasicHttpBinding();
            var address = new EndpointAddress("http://localhost:64013/Service1.svc");

            var channelFactory = new ChannelFactory&lt;TService&gt;(backendWsHttpBinding, address);

            IClientChannel channel = channelFactory.CreateChannel() as IClientChannel;

            if (channel != null)
            {
                try
                {
                    var response = invocation.Method.Invoke(channel, invocation.Arguments);
                    invocation.ReturnValue = response;
                    channel.Close();
                }
                catch (Exception e  )
                {   
                    channel.Abort();
                    Console.WriteLine("Error...");
                }
            }
        }
    }    </pre></div>
<p>&nbsp;</p>
<p>Wenn der Interceptor aufgerufen wird, dann wird über die ChannelFactory der WCF Channel für unseren Service geöffnet und die Methode wird über “invocation.Method.Invoke” aufgerufen und am Ende wieder geschlossen. In einem Fehlerfall schließen wir auch die Verbindung entsprechend. Das Ergebnis des Aufrufs wird natürlich als “ReturnValue” sich auch gemerkt.</p>
<p><strong>Castle Windsor Registrierung</strong></p>
<p>Dies registrieren wir nun alles im Windsor Castle Container und schon ist die WCF &amp; IoC Welt wieder im Lot.
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d59928dc-470c-4e71-9818-a372ec7cfc0c" class="wlWriterEditableSmartContent"><pre name="code" class="c#">IWindsorContainer container = new WindsorContainer();

// Den Interceptor im Container registrieren
container.Register(Component.For(typeof(WcfProxyInterceptor&lt;IService1&gt;)));

// IFoo samt Implementierung hinterlegen
container.Register(Component.For(typeof (IFoo)).ImplementedBy(typeof (Foo)));

// Nun dem Container sagen, dass wenn IService1 aufgerufen wird der Interceptor genutzt werden soll
container.Register(Component.For&lt;IService1&gt;().Interceptors(InterceptorReference.ForType&lt;WcfProxyInterceptor&lt;IService1&gt;&gt;()).Anywhere);
</pre></div></p>
<p>&nbsp;</p>
<p><strong>Resultat</strong></p>
<p>Bei jedem Call des Services wird der Channel neu aufgebaut und wieder geschlossen. Wenn man jedoch viele Service Calls hintereinander macht, bewirkt dies, dass der Channel immer wieder neu aufgebaut werden muss – was in der Regel ca. 10-15ms dauert. Bei jedem “Do()” Aufruf wird der Interceptor neu ausgeführt. Dies kann je nach gebrauch evtl. auf die Performance größte Auswirkungen haben. Hat uns aber (noch) nicht gestört.</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:4c3bf8ab-59e9-44ed-b62c-146071359b9c" class="wlWriterEditableSmartContent"><pre name="code" class="c#"> var test = (IFoo)container.Resolve(typeof (IFoo));
            test.Do();
            test.Do();
            test.Do();
            test.Do();
            test.Do();</pre></div>
<p>&nbsp;</p>
<p><strong>Gesamter Client Code:</strong></p>
<p>Nochmal der gesamte Code aus dem Client Projekt (+ einer zusätzlichen Dummyklasse zum “Testen”)</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:3fd703b4-7d38-4788-8306-e02e6e8c9732" class="wlWriterEditableSmartContent"><pre name="code" class="c#">namespace Client
{
    using System;
    using System.ServiceModel;
    using System.Threading;
    using Castle.Core;
    using Castle.DynamicProxy;
    using System.Reflection;
    using Castle.Facilities.WcfIntegration;
    using Castle.MicroKernel.Registration;
    using Castle.Windsor;
    using Contracts;

    class Program
    {

        static void Main(string[] args)
        {
            IWindsorContainer container = new WindsorContainer();

            container.Register(Component.For(typeof(WcfProxyInterceptor&lt;IService1&gt;)));

            container.Register(Component.For(typeof (IFoo)).ImplementedBy(typeof (Foo)));
            container.Register(Component.For(typeof(IBar)).ImplementedBy(typeof(Bar)));

            container.Register(Component.For&lt;IService1&gt;().Interceptors(InterceptorReference.ForType&lt;WcfProxyInterceptor&lt;IService1&gt;&gt;()).Anywhere);


            var test = (IFoo)container.Resolve(typeof (IFoo));
            test.Do();
            test.Do();
            test.Do();
            test.Do();
            test.Do();

            var testBar = (IBar)container.Resolve(typeof(IBar));
            testBar.Do();
            
            Console.ReadLine();
        }
    }

    public interface IFoo
    {
        void Do();
    }

    public interface IBar
    {
        void Do();
    }

    public class Bar : IBar
    {
        public IService1 Service1 { get; set; }
        
        public Bar(IService1 srv)
        {
            this.Service1 = srv;
        }

        public void Do()
        {
            Console.WriteLine(this.Service1.GetData(999));
        }
    }

    public class Foo : IFoo
    {
        public IService1 Service1 { get; set; } 
        public Foo(IService1 srv)
        {
            this.Service1 = srv;
        }

        public void Do()
        {
            Console.WriteLine(this.Service1.GetData(999));
        }
    }

    public class WcfProxyInterceptor&lt;TService&gt; : IInterceptor
    {
        public void Intercept(IInvocation invocation)
        {
            var backendWsHttpBinding = new BasicHttpBinding();
            var address = new EndpointAddress("http://localhost:64013/Service1.svc");

            var channelFactory = new ChannelFactory&lt;TService&gt;(backendWsHttpBinding, address);

            IClientChannel channel = channelFactory.CreateChannel() as IClientChannel;

            if (channel != null)
            {
                try
                {
                    var response = invocation.Method.Invoke(channel, invocation.Arguments);
                    invocation.ReturnValue = response;
                    channel.Close();
                }
                catch (Exception e  )
                {   
                    channel.Abort();
                    Console.WriteLine("Error...");
                }
            }
        }
    }    
}
</pre></div>
<p>&nbsp;</p>
<p><strong>Fazit</strong></p>
<p>Das Ansprechen des Service funktioniert und die Kanäle werden ordentlich wieder geschlossen. Damit sollte Windsor Castle und WCF auch Freunde werden. Natürlich geht ähnliches auch mit Unity und co., solange sie solche “Interceptors” unterstützen. </p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/wcfwithioc/wcfwithioc.zip">[ Download Democode ]</a></strong></p>
