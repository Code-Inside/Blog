---
layout: post
title: "HowTo: Eigene .NET Events definieren und mit Unit-Tests testen"
date: 2008-07-12 00:30
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [.NET, C# 2.0, Events, HowTo, TDD, Unit Tests]
---
{% include JB/setup %}
<p>In dem heutigen HowTo geht es um das Erstellen von eigenen .NET Events samt dem dazu gehörigen testen mit einem <a href="http://code-inside.de/blog/2008/05/22/howto-einfache-tests-unittests-oder-keine-angst-vor-unittests/">Unit-Test</a>.</p> <p><strong>Was ist ein Event aus "Anfängersicht"?<br></strong>Jeder der (wahrscheinlich) in einer X-beliebigen IDE für eine X-beliebige Sprache bereits irgendein Button auf ein Fenster gezogen hat, wird als Resultat dann so einen ähnlichen Code sehen:<br></p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:529f8e26-1d68-4a2f-9b6d-6b9234eddc55" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        private void button1_Click(object sender, EventArgs e)
        {

        }</pre></div>
<p></p>
<p>Hier kann man nun ganz genau definieren, was passiert wenn der "button1" geklickt wird. <br>Eigentlich eine tolle Geschichte :)</p>
<p><strong>Was passiert denn technisch im Grunde genommen dahinter?<br></strong>Events sind von der Idee her bereits sehr alt. Der Grundgedanke ist einfach nach dem "<a href="http://www.coder-wiki.de/Informationen/Hollywood-Prinzip">Hollywood-Prinzip</a>": Ruf nicht uns an - wir rufen dich an.<br>Im Code brauchen wir nicht ständig prüfen ob der Button geklickt wird oder nicht - der Button sagt uns, wann er geklickt wird.<br>Ohne jetzt die .NET Implementierung (also was im Framework passiert) näher untersucht zu haben, würde ich meinen, dass das Grundkonzept aus dem <a href="http://de.wikipedia.org/wiki/Beobachter_(Entwurfsmuster)">Observer-Pattern</a> abgeleitet ist.</p>
<p><strong>Was ist ein Event: Beispiel aus der realen Welt<br></strong>Um&nbsp; mal ein Beispiel aus der realen Welt aufzugreifen - auch wenn dies manchmal arg abstrakt ist ;)<br>Wenn jemand ein "Bild-Zeitungs-Abo" hat, fragt der normal-deutsche-Leser auch nicht ständig den Herrn Springer ob es nun eine neue Ausgabe gibt oder nicht - er bekommt sein Exemplar automatisch sobald es gedruckt wurde. </p>
<p><strong>Einsatzgebiet von Events<br></strong>Sobald man irgendwelche "Prozesse" oder "Abläufe" modelliert, könnte man im Prinzip auf Events setzen - ich persönlich bin erst vor kurzem auf das Thema gekommen. Das liegt vor allem daran, dass ich bisher meistens mich mit Web-Projekten beschäftigt habe. In der ASP.NET Welt sind meiner Meinung nach Events nicht so unglaublich nützlich. Der Grund liegt auf dem, wie <a href="http://de.wikipedia.org/wiki/Hypertext_Transfer_Protocol">HTTP</a> funktioniert:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image486.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="218" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb465.png" width="240" border="0"></a>&nbsp;<br>Der Client macht eine Anfrage und der Server antwortet entsprechend. Rein theoretisch geht nun ein Ablauf los - der irgendwann beeendet ist - das "Ich-bin-fertig-mit-meiner-Aufgabe" könnte über ein Event mitgeteilt werden.<br>An dieser Stelle sollte der Server an den Client zurückschicken: Bin fertig. Allerdings geht dies nicht:<br><a href="{{BASE_PATH}}/assets/wp-images/image487.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="240" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb466.png" width="235" border="0"></a> <br>Im HTTP Umfeld kann der Server nicht einfach Daten zum Client schicken - der Client&nbsp; (Browser) muss immer erst die Anfrage stellen. Dadurch muss man auf der Clientseite (über AJAX z.B.) ein Polling durchführen. Das führt natürlich dazu, dass Events leicht nutzlos werden. <br>Allerdings sind sie in sämtlichen Client-Anwendungen die nicht auf HTTP beruhen äußerst nützlich :)</p>
<p><strong>Eigene Events definieren<br></strong>Dan Wahlin hat ein <a href="http://weblogs.asp.net/dwahlin/archive/2007/01/17/video-creating-custom-events-and-delegates-with-c.aspx">sehr schönes Video erstellt</a>, in dem die Grundgedanken sehr gut vermittelt werden.<br><br><strong>Mein Beispiel:</strong><br>Wir haben eine bestimmte Anwendung, welche jeweils einen Verbindungsstatus haben kann:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image488.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="154" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb467.png" width="201" border="0"></a> </p>
<p>Diese "ConnectionStates" in der Anwendung werden von einem "ConnectionManager" verwaltet.<br>Jetzt wäre es ja schön, wenn uns unser "ConnectionManager" sofort informiert, wenn sich der Status ändert.<br>Dazu erstmal das grobe Konstrukt unserer Klasse:<br></p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d68dfe43-9a8e-4a4c-aa6f-8d330db015b5" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public class ConnectionManager
    {
        private ConnectionStates _state;

        public ConnectionStates State
        {
            get
            {
                return _state;
                
            }
            set
            {
                _state = value;
            }
        }

        public ConnectionManager()
        {
            this.State = ConnectionStates.Disconnected;
        }
    }</pre></div>
<p>Der Anfangsstatus ist erstmal auf "Disconnected" gestellt. Der Rest sollte soweit klar sein.<br>Jetzt kommen wir zur eigentlichen Eventdeklaration.</p>
<p><strong>Schritt 1: Delegat definieren</strong><br>Als ersten Schritt schreiben wir uns ein <a href="http://msdn.microsoft.com/en-us/library/900fyy8e(VS.71).aspx">Delegat</a>:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:022840d0-2079-4691-ad10-e4aecf8e0749" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public delegate void StateChangedEventHandler(object sender, StateChangedEventArgs e);</pre></div>
<p>Ein Delegat darf man als eine Art "Funktionszeiger" (im Video von Dan Wahlin wird es auch als Pipe zwischen Objekten verglichen) verstehen.</p>
<p><strong>Schritt 2: StateChangeEventArgs definieren</strong><br>In unserem Delegat definieren wir eine Methodendeklaration die so später auch der Clientcode sieht - als EventArgs definieren wir ebenfalls unsere eigene Klasse:</p>
<p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:9668ef3e-99dc-4a0a-b95b-613a4e49b19b" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class StateChangedEventArgs : EventArgs
    {
        public ConnectionStates NewConnectionStates { get; set; }
    }</pre></div><br>Hier definieren wir einfach, was wir in unseren EventArgs später haben wollen - uns interessiert natürlich am meisten, was nun der neue Status ist.</p>
<p><strong>Schritt 3: Event definieren<br></strong>Jetzt definieren wir unser Event - an diesem können sich später die entsprechenden Clients melden:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:46be4fd6-4f24-41d6-a349-d85b4271947c" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public event StateChangedEventHandler StateChanged;</pre></div>
<p>Dieses Event ist vom Typ "StateChangedEventHandler" - welches unser vorher definiertes Delegat ist.</p>
<p><strong>Zwischenschritt: Der Client</strong><br>Allein durch diese Definition des Events und des Delegates ist es möglich, das sich "Clientcode" an das Event dran hängt:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:1779bff9-8167-4d9c-a3a4-6f093fe10f49" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">class Program
    {
        static void Main(string[] args)
        {
            ConnectionManager man = new ConnectionManager();
            Console.WriteLine("Start state: " + man.State.ToString());
            man.StateChanged += new ConnectionManager.StateChangedEventHandler(man_OnStateChanged);
            man.State = ConnectionStates.Connecting;
            man.State = ConnectionStates.Connected;
            man.State = ConnectionStates.Disconnected;
            Console.ReadLine();
        }

        static void man_OnStateChanged(object sender, StateChangedEventArgs e)
        {
            Console.WriteLine("State changed...");
            Console.WriteLine("New state is: " + e.NewConnectionStates.ToString());
        }
    }</pre></div>
<p>Die "man_OnStateChanged" Methode ist zwar definiert - allerdings rufen wir in unserem "ConnectionManager" nie das Event auf.</p>
<p><strong>Schritt 4: Event in der Klasse aufrufen<br></strong>In unserem Setter müssen wir natürlich das Event werfen - dies geschieht über eine weitere Methode in der Klasse. Hier mal der komplette Source Code:</p>
<p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c4bb171a-c37f-4445-a88c-67b8b80bc84f" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public class ConnectionManager
    {
        private ConnectionStates _state;

        public ConnectionStates State
        {
            get
            {
                return _state;
                
            }
            set
            {
                _state = value;
                OnStateChanged();
            }
        }

        public delegate void StateChangedEventHandler(object sender, StateChangedEventArgs e);

        public event StateChangedEventHandler StateChanged;

        protected void OnStateChanged()
        {
            if (StateChanged != null)
            {
                StateChangedEventArgs args = new StateChangedEventArgs();
                args.NewConnectionStates = this.State;
                StateChanged(this, args);
            }
        }
        public ConnectionManager()
        {
            this.State = ConnectionStates.Disconnected;
        }
    }</pre></div></p>
<p>Bei jedem setzen eines ConnectionStates wird die "OnStateChanged" Methode aufgerufen - diese ist nur intern erreichbar ("protected") bzw. von vererbten Klassen. <br>Diese Methode prüft, ob das "StateChanged" Event irgendwelche Beobachter hat - if(StateChanged != null).<br>Falls irgendwer im Clientcode sich an das Event angehangen hat, wird das Event mit unseren EventArgs geworfen.</p>
<p><strong>Es klingt komplizierter als es ist<br></strong>Da ich ebenfalls "neu" darin bin, musste ich mich ebenfalls erst mal in das Einarbeiten. Um es mal in kurzen Worten zu formulieren (soweit mein Verständnis richtig ist):</p>
<ul>
<li>Am "<strong>event</strong>" StateChanged können sich beliebige Clienten anmelden. Der Clientcode hat die selbe <strong>Methodensignatur</strong> (object Sender, EventArgsXYZ args) wie in dem "<strong>delegat</strong>" definiert.</li>
<li>Das "<strong>delegat</strong>" ist nur eine definierte <strong>Schnittstelle</strong> zwischen den Objekten. Hier wird die Methodensignatur von dem Clientcode bestimmt.</li>
<li>Die "<strong>EventArgs</strong>" sind eigene <strong>Datenklassen</strong> um entsprechende sinnvolle Daten zu übermitteln wenn das Event geworfen wurde</li>
<li>Die interne "<strong>OnStateChanged</strong>" Methode prüft ob irgendwas am "<strong>event</strong>" hängt - wenn ja, dann löse es aus und leite es (über das <strong>delegat</strong>) an die richtige Stelle im Clientcode.</li></ul>
<p><strong>Resultat<br></strong>In der Clientanwendung (die Consolen-Applikation) wird jedesmal die Ausgabe gemacht, sobald sich der Status ändert. Ohne jedes mal eine extra Methode aufzurufen oder die Ausgabe an den Manager zu ketten:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image489.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="255" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb468.png" width="501" border="0"></a> </p>
<p><strong>Unit-Tests: Wie teste ich Events?<br></strong>Events kann man über eine nette C# 2.0 Sache testen: ein anonyme delegate. Den Trick habe ich bei <a href="http://haacked.com/archive/2006/12/13/Tip_Jar_Unit_Test_Events_With_Anonymous_Delegates.aspx">Phil Haack</a> gefunden.</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:cc68ffff-5ec4-4073-a2e3-ec0789e360b7" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">[TestMethod]
        public void ConnectionManager_Raise_StateChanged_Event()
        {
            ConnectionManager man = new ConnectionManager();
            Assert.AreEqual(ConnectionStates.Disconnected, man.State);

            bool eventRaised = false;

            man.StateChanged += delegate(object sender, StateChangedEventArgs args)
            {
                eventRaised = true;
            };
            man.State = ConnectionStates.Connecting;

            Assert.IsTrue(eventRaised);
        }</pre></div>
<p>In diesm Test lege ich einen bool "eventRaised" an - sobald das Event geworfen wird, wird ein anonymes delegat aufgerufen (man spart sich hier die zweite Methode) und ich setzt einfach diesen boolean auf "true".<br>Sehr einfach und genial um zu testen, ob das Event wie gehofft auch geworfen wird :)</p>
<p><a href="http://{{BASE_PATH}}/assets/files/democode/myevents/myevents.zip"><strong>[Download Source Code]</strong></a></p>
