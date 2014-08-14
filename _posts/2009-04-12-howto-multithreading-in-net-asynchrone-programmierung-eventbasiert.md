---
layout: post
title: "HowTo: Multithreading in .NET - Asynchrone Programmierung (Eventbasiert)"
date: 2009-04-12 21:56
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Async, HowTo, Multithreading]
---
<p><a href="{{BASE_PATH}}/assets/wp-images/image706.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; margin: 0px 10px 0px 0px; border-right-width: 0px" height="100" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb684.png" width="147" align="left" border="0" /></a></p>  <p>Hoch performante Systeme oder Desktopprogramme kommen ohne <a href="http://msdn.microsoft.com/de-de/library/ms228969(VS.80).aspx">asynchrone Programmierung</a> nicht weit. Wenn bei einer Windows Anwendung die Anwendung w&#228;hrend einer Aktion &quot;steht&quot; und die Anwendung nicht mehr reagiert, dann wird diese Aktion synchron ausgef&#252;hrt. In diesem HowTo zeige ich einen Einstieg, wie man seine Backend-Logik mit asynchronen Methoden ausstatten kann. </p> 
<!--more-->
  <p><strong>Synchrone Programmierung     <br /></strong>Sehr einfach gesagt, ist synchrone Programmierung dann, wenn immer nur ein Prozess zur gleichen Zeit aktiv sein kann. Wir stellen uns eine Windows Anwendung mit einem Button vor, welche zu einer Datenbank oder eines Webservices Verbindung aufbaut um Daten zu holen und diese sollen hinterher dargestellt werden. Sobald man eine Anwendung startet, wird ein <a href="http://de.wikipedia.org/wiki/Thread_(Informatik)">Thread</a> gestartet (und noch einiges anderes, aber das tut jetzt nix zur Sache) wo die Anwendung drin &quot;lebt&quot;. Als Prozesskette s&#228;he dies so aus:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image707.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="67" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb685.png" width="505" border="0" /></a> </p>  <p>Sobald man den Button dr&#252;ckt, wird in dem Thread der Database/Webservice Call durchgef&#252;hrt. Wenn der Nutzer nun noch einmal klickt, dann wird er sowas sehen:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image708.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="244" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb686.png" width="239" border="0" /></a>&#160; </p>  <p>Beachte das &quot;<strong>Keine R&#252;ckmeldung</strong>&quot;.</p>  <p>W&#252;rden wir jetzt verschiedene andere Systeme um Daten bitten, w&#252;rde die Anwendung ewig f&#252;r den Nutzer nicht &quot;klickbar&quot; sein. </p>  <p><strong>Asynchrone Programmierung     <br /></strong>Nett w&#228;re ja, wenn man das darstellen der GUI und &quot;Worker&quot; Thread getrennt w&#228;ren:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image709.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="193" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb687.png" width="417" border="0" /></a> </p>  <p>Damit bleibt die Anwendung trotzdem noch &quot;klickbar&quot; und andere Aktionen k&#246;nnen gestartet werden. </p>  <p>Im <a href="http://msdn.microsoft.com/en-us/library/ms228969.aspx">.NET Umfeld</a> gibt es drei Varianten, wie man dies realisieren kann:    <br />- <a href="http://msdn.microsoft.com/en-us/library/ms228975.aspx">IAsyncResult Pattern</a>    <br />- <a href="http://msdn.microsoft.com/en-us/library/22t547yb.aspx">Delegate Pattern</a>    <br />- <a href="http://msdn.microsoft.com/en-us/library/hkasytyf.aspx">Event-based Pattern</a></p>  <p>Ein guter Einstieg findet sich auch in der <a href="http://msdn.microsoft.com/de-de/library/cc952527.aspx">MSDN</a> (und <a href="http://msdn.microsoft.com/en-us/library/ms228969.aspx">hier</a>).    <br />In meinem Beispiel nutze ich das <a href="http://msdn.microsoft.com/en-us/library/hkasytyf.aspx">Event-based Pattern</a>, weil mir dies am &quot;einfachsten&quot; vorkam.</p>  <p><strong>Einsatzszenarien     <br /></strong>In Desktopanwendungen ist es nat&#252;rlich meist ein muss, aber auch bei Webanwendungen ist dies interessant, damit die Anwendung besser skaliert. Ein Beispiel ist z.B. bei <a href="http://blog.maartenballiauw.be/post/2009/04/08/Using-the-ASPNET-MVC-Futures-AsyncController.aspx">ASP.NET MVC die Asynchronen Controller</a>.</p>  <p><strong>&quot;Probleme&quot;     <br /></strong>Neben der gesteigerten Komplexit&#228;t muss man sich nat&#252;rlich immer &#252;berlegen ob der Einsatz passt oder nicht. Eine asynchrone Aktion kann theoretisch Studenlang laufen oder einfach abbrechen, weil z.B. am anderen Ende die Datenbank gerade down ist. Wer mit WindowsForms oder WPF arbeitet, findet auch noch ein anderes Problem: Es kann immer nur ein <a href="http://msdn.microsoft.com/en-us/library/ms680112.aspx">Thread die GUI ver&#228;ndern</a>, im WPF Umfeld gibt es da z.B. den <a href="http://msdn.microsoft.com/en-us/library/system.windows.threading.dispatcher.aspx">Dispatcher</a>. Ich zeige in diesem HowTo nur wie man im Backend eine asynchrone Operation bereitstellt. Wie man das zu einer GUI weitergibt ist ein anderes Thema, daher zeige ich dies nur in einem Konsolenprogramm.</p>  <p><strong>Zum Beispiel</strong>    <br />Wir haben ein Kundendatenbank. Ein Kunde wird repr&#228;sentiert durch die Customer Klasse:</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:8cb66856-0d74-43ce-85a8-3eba7cb623e1" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class Customer
    {
        public string Name { get; set; }
        public string Address { get; set; }
        public Guid Id { get; set; }
    }</pre></div>

<p>Unsere Kundendatenbank wollen wir mit einem CustomerRepository ansprechen:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:08bc7e56-9a7e-4786-943b-d269ff5cd41d" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class CustomerRepository
    {
        public List&lt;Customer&gt; GetCustomers()
        {
            Thread.Sleep(10000);
            List&lt;Customer&gt; resultList = new List&lt;Customer&gt;();
            resultList.Add(new Customer() { Address = "New York", Id = Guid.NewGuid(), Name = "Bank ABC" });
            resultList.Add(new Customer() { Address = "Berlin", Id = Guid.NewGuid(), Name = "Manufactor XYZ" });
            resultList.Add(new Customer() { Address = "Paris", Id = Guid.NewGuid(), Name = "Test 123" });
            resultList.Add(new Customer() { Address = "Tokyo", Id = Guid.NewGuid(), Name = "Bank DDD" });
            resultList.Add(new Customer() { Address = "London", Id = Guid.NewGuid(), Name = "Bank HHH" });
            return resultList;
        }

        public void GetCustomersAsync()
        {
            ThreadPool.QueueUserWorkItem(y =&gt;
            {
                List&lt;Customer&gt; result = this.GetCustomers();
                this.OnGetCustomersAsyncCompleted(result);
            });
        }

        private void OnGetCustomersAsyncCompleted(List&lt;Customer&gt; customers)
        {
            if (this.GetCustomersAsyncCompleted != null)
            {
                this.GetCustomersAsyncCompleted(this, new GenericEventArgs&lt;List&lt;Customer&gt;&gt;(customers));
            }
        }

        public event EventHandler&lt;GenericEventArgs&lt;List&lt;Customer&gt;&gt;&gt; GetCustomersAsyncCompleted;
</pre></div>

<p><strong>Erkl&#228;rung:
    <br /></strong>Es gibt zwei &#246;ffentliche Methoden (GetCustomers &amp; GetCustomersAsync) und ein Event (GetCustomersAsyncCompleted)&#160; und eine private Methode (OnGetCustomersAsyncCompleted). 

  <br />Wer noch nie mit Events gearbeitet hat, der kann sich auch <a href="http://code-inside.de/blog/2008/07/12/howto-eigene-net-events-definieren-und-mit-unit-tests-testen/">mein HowTo</a> durchlesen.</p>

<p>Die Methode &quot;<strong>GetCustomers</strong>&quot; macht unseren Fake Datenbankzugriff (daher dort das Thread.Sleep um eine Verz&#246;gerung bei der Verbindung zu zeigen) und gibt die Daten zur&#252;ck. <strong>Diese Methode ist synchron</strong> - wenn ein Client diese direkt so aufruft, dann blockiert im schlimmsten Fall der GUI Thread.</p>

<p>Die Methode &quot;<strong>GetCustomersAsync</strong>&quot; ist der <strong>asynchrone</strong> Gegenpart. Beachtet die <a href="http://msdn.microsoft.com/en-us/library/e7a34yad.aspx">Naming-Convention</a>, asynchrone Methoden m&#252;ssen immer mit einem &quot;<strong>Async</strong>&quot; gekennzeichnet werden und ein Event besitzen, welches mit &quot;<strong>Completed</strong>&quot; aufh&#246;rt.

  <br />In der &quot;GetCustomersAsync&quot; Methode nutze ich den <a href="http://msdn.microsoft.com/en-us/library/system.threading.threadpool.queueuserworkitem.aspx">ThreadPool</a> um mir diese Arbeit abzunehmen. Ich rufe in meinem Beispiel einfach die synchrone Version auf und gebe das Ergebnis einer privaten Methode &quot;OnGetCustomersAsyncCompleted&quot; auf. Anstatt des ThreadPools h&#228;tte ich mir auch direkt einen neuen Thread erstellen k&#246;nnen oder eine andere der unz&#228;hligen M&#246;glichkeiten aussuchen k&#246;nnen. Der Syntax sieht etwas kurios aus, weil ich eine <a href="http://thevalerios.net/matt/2008/05/use-threadpoolqueueuserworkitem-with-anonymous-types/">annonyme Methode</a> benutze.

  <br />Diese Methode pr&#252;ft ob sich irgendjemand auf das Event registriert hat, wenn ja, wird das Event abgefeuert.</p>

<p>Damit die Daten auch entsprechen ankommen, habe ich mir eine Hilfklasse geschrieben, die &quot;GenericEventArgs&quot; - so brauche ich die EventArgs nicht casten, sondern es ist streng typisiert:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:af459c97-195e-4cd1-8874-cbf5ba1284ff" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class GenericEventArgs&lt;TValue&gt; : EventArgs
    {
        public GenericEventArgs(TValue args)
        {
            this.EventArgs = args;
        }

        public TValue EventArgs { get; internal set; }
    }</pre></div>

<p><strong>Program.cs:</strong></p>

<p>In unserer Program.cs nutzen wir nun diesen Code:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:bad403a8-3aa1-4e7b-94a4-35894e193831" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        static void Main(string[] args)
        {
            CustomerRepository rep = new CustomerRepository();

            Console.WriteLine("Sync: A | Async: B");
            string choice = Console.ReadLine();

            if(choice.ToLower() == "a")
            {
                DisplayCustomers(rep.GetCustomers());
            }
            if (choice.ToLower() == "b")
            {
                rep.GetCustomersAsyncCompleted += new EventHandler&lt;GenericEventArgs&lt;List&lt;Customer&gt;&gt;&gt;(rep_GetCustomersAsyncCompleted);
                rep.GetCustomersAsync();
            }

            Console.ReadLine();
        }

        static void rep_GetCustomersAsyncCompleted(object sender, GenericEventArgs&lt;List&lt;Customer&gt;&gt; e)
        {
            DisplayCustomers(e.EventArgs);
        }

        static void DisplayCustomers(List&lt;Customer&gt; customers)
        {
            Console.WriteLine("Finished:");
            foreach (Customer customer in customers)
            {
                Console.WriteLine("+++");
                Console.WriteLine("Customer Name: " + customer.Name);
                Console.WriteLine("Customer Address: " + customer.Address);
                Console.WriteLine("Customer ID: " + customer.Id.ToString());
            }
        }
    }
</pre></div>

<p>Als erstes erstellen wir uns unser CustomerRepository. Danach lass ich den Benutzer entscheiden ob er die Daten synchron oder asynchron laden m&#246;chte, wenn er die Daten <strong>synchron</strong> l&#228;dt wird die &quot;<strong>GetCustomers</strong>&quot; Methode aufgerufen und das Ergebnis in die &quot;<strong>DisplayCustomers</strong>&quot; hineingegeben.</p>

<p>Bei der <strong>asynchronen</strong> Variante registriert man sich auf das Event und ruft die &quot;<strong>GetCustomersAsync</strong>&quot; Methode auf. Wenn die Aktion durchgelaufen ist, wird das Event &quot;<strong>GetCustomersAsyncCompleted</strong>&quot; aufgerufen und im Eventhandler werden die Daten dann ebenfalls der &quot;<strong>DisplayCustomers</strong>&quot; &#252;bergeben.</p>

<p><strong>Ergebnis:
    <br /></strong>Wenn man nun das Programm startet, kann man w&#228;hrend des synchronen Aktion keine weiteren Buchstaben mehr eingeben. Bei der asynchronen Variante kann man die ganze Zeit Buchstaben eintippen (auch wenn diese nix machen).

  <br />Ich wollte noch ein WinForms oder WPF Beispiel beilegen, allerdings kann man dort nicht einfach aus einem anderen Thread in die GUI reinschreiben (siehe &quot;Probleme&quot;). Dies geht nur in einer Konsolenanwendung. 

  <br />Das ist aber ein HowTo f&#252;r sp&#228;ter ;)</p>

<p><strong><a href="http://{{BASE_PATH}}/assets/files/democode/asyncintro/asyncintro.zip">[ Download Democode ]</a></strong></p>
