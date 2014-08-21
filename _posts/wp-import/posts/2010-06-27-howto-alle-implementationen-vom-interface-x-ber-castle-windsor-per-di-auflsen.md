---
layout: post
title: "HowTo: Alle Implementationen vom Interface X über Castle Windsor per DI auflösen"
date: 2010-06-27 23:24
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Castle, DI, HowTo, Windsor]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image980.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb164.png" width="211" height="162" /></a> </p>  <p>Der Titel klingt recht &quot;kompliziert”, ist es aber eigentlich gar nicht. Grundproblem: Wir haben ein Interface und mehrere Implementationen davon. In unserer Applikation wollen diese über Konstruktor-Injektion holen und nacheinander aufrufen. Mit dem ArrayResolver und Castle Windsor dies sehr einfach zu bewerkstelligen. Der Blogpost darf auch als "realer” Einstieg in das Thema Dependency Injection angesehen werden.</p> <!--more-->  <p><strong>Grundlagen</strong></p>  <p>Einen kleinen Einstieg hab ich <a href="{{BASE_PATH}}/2010/03/15/howto-dependency-injection-service-locator/">hier</a> bereits gegeben. In meinem Beispiel nutze ich <a href="http://www.castleproject.org/container/index.html">Castle Windsor</a>, genauso gut hätte ich wahrscheinlich ein anderes DI Framework nehmen können. </p>  <p><strong>Benötigte Assemblies</strong></p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image981.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb165.png" width="203" height="97" /></a> </p>  <p>Der <a href="http://www.castleproject.org/castle/download.html">Download</a> von Castle Windsor kann erstmal etwas erschreckend sein. Benötigt werden diese 4 Dlls (Core/DynamicProxy2/MicroKernel/Windsor).</p>  <p>&#160;</p>  <p><strong>Mein (reales) Beispiel</strong></p>  <p>Wir haben bei uns eine Applikation die auf einige Backend Systeme zugreift. Da die Backend Systeme ab und an "einschlafen” haben wir ein "WakeUpTool” geschrieben, welches nach einem bestimmten Intervall die Systeme auf Stand-by hält. </p>  <p>Wir haben bei uns ein "IWakeUpCommand” mit der simplen Methode "WakeUp”. Pro Backendsystem gibt es eine Implementation davon. Die einzelnen Aufwach-Befehle können völlig getrennt voneinander agieren. Wichtig ist nur, dass immer alle geladen werden.   <br />Da es sein kann, dass nun noch ein weiteres Backend System dazu kommt (oder eins wegfällt), wollten wir die Verbindung zwischen ApplicationRunner und den einzelnen Commands so lose wie möglich gestalten. </p>  <p><strong>Fake Beispiel</strong></p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image982.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb166.png" width="244" height="213" /></a> In meinem Beispiel, welches ihr ganz unten auch runterladen könnt, wird einfach nur ein ConsoleWriteLine ausgegeben. </p>  <p>In dem Beispiel gibt es das Interface "ICommand” mit der Methode "Exceute” und 3 Implementationen.</p>  <p>&#160;</p>  <p>Das Interface "IApplicationRunner” beinhaltet nur eine "Run” Methode. Dies ist mein eigentlicher Eintrittspunkt in die Applikationslogik. </p>  <p>Beispiel Command:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:2caa3608-03f6-4c49-9c87-083a0c6305b9" class="wlWriterEditableSmartContent"><pre name="code" class="c#">namespace CastleWindsorFindAllImplementations.Commands
{
    public class WakeUpCommand : ICommand
    {
        public void Execute()
        {
            Console.WriteLine("WakeUpCommand");
        }
    }
}</pre></div>

<p></p>

<p>Der ApplicationRunner nimmt einfach ein Array an ICommands entgegen und ruft diese nacheinander auf. Keine große Magie. </p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e1b6fcb0-a358-4158-8ecd-66bc84450468" class="wlWriterEditableSmartContent"><pre name="code" class="c#">namespace CastleWindsorFindAllImplementations
{
    public class ApplicationRunner : IApplicationRunner
    {
        private ICommand[] _commands;

        public ApplicationRunner(ICommand[] commands)
        {
            this._commands = commands;
        }

        public void Run()
        {
            foreach (ICommand command in _commands)
            {
                command.Execute();
            }
        }
    }
}</pre></div>

<p><strong>Castle Windsor Magie - wie der ApplicationRunner zu den Implementationen kommt!</strong></p>

<p>Ganz am Anfang registrieren wir einen ArrayResolver für Windsor Castle. Nur damit kann unser "container” auch Arrays auflösen.</p>

<p>Die Zeile 7 erspart eine Menge tipparbeit. Damit wird dem Container (so wie ich es verstanden habe ;) ) gesagt, dass er alle Interfaces suchen soll und dazu die passenden Implementationen registrieren soll. Suchen soll er zudem nur in dieser Assembly. Nur durch diesen Automatismus ist es auch erst elegant, weil man so einfach nur eine neuen Command hinzufügen muss und das Framework kümmert sich um die Auflösung. Man muss kein Setup etc. anpassen. Sehr praktisch, aber sicherlich wird es auch zu Problemen führen wenn es komplexer wird. </p>

<p>In Zeile 10 holen wir uns über den "container” unseren IApplicationRunner und sagen dann einfach nur "Run”. Windsor Castle hat als einzige Implementation unsere "ApplicationRunner” Klasse gefunden. Diese wiederrum braucht ein Array aus ICommands. Voodoo :) </p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:12271daa-b0a1-4d4c-a392-87e3a54c12e3" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    class Program
    {
        static void Main(string[] args)
        {
            IWindsorContainer container = new WindsorContainer();
            container.Kernel.Resolver.AddSubResolver(new ArrayResolver(container.Kernel));
            container.Register(AllTypes.Pick().FromAssembly(typeof(ApplicationRunner).Assembly)
                    .WithService.FirstInterface());

            IApplicationRunner runner = container.Resolve&lt;IApplicationRunner&gt;();
            runner.Run();

            Console.ReadLine();
        }
    }</pre></div>

<p><strong>Was ist wenn ich einen konkreten Typ von ICommand haben will?</strong></p>

<p>Dann hat man erst mal ein Problem, weil es so nicht vorgesehen ist. Was man machen kann ist bestimmten Komponenten innerhalb des "containers” einen Namen zu geben. </p>

<p><strong>Fazit</strong></p>

<p> Diese Methode ist äußerst praktisch wenn man einfach nur eine Liste von Implementationen nutzen will ohne sie explizit erst zu registrieren. Einen genauen Typen daraus wieder herauszupuzzeln ist allerdings schwieriger.</p>

<p><strong><a href="http://{{BASE_PATH}}/assets/files/democode/CastleWindsorFindAllImplementations/CastleWindsorFindAllImplementations.zip">[ Download Democode ]</a></strong></p>
