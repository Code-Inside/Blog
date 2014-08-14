---
layout: post
title: "Interaktionen zwischen Web und Windows Desktop/Windows Phone/WinRT mit ObjectForScripting & window.external.notify"
date: 2013-09-04 20:59
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Browser, HowTo, IE, Metro, ObjectForScripting]
---
{% include JB/setup %}
<p>Aus einer Desktop-Anwendung eine Web-Applikation aufzurufen ist trivial und es gibt je nach Art des Aufrufs unterschiedliche Wege. Man kann einen HTTP Request erzeugen, oder man verweisst einfach mit einem Link auf die Seite und der Browser geht auf oder man hat einen “embedded” Browser, der die Seite direkt im “App-Host” anzeigt. Recht einfach, aber wie könnte eine Web-Anwendung eine Desktop-Anwendung aufrufen? </p> <h3>Vom Web zur Desktop-Anwendung über URIs</h3> <p> Die erste Variante wären “Custom-URIs”, welche einfach als Link dargestellt werden. Bekanntestes Beispiel dürfte der “mailto” Link sein. Aber auch Skype, iTunes, Visual Studio, Spotify oder GitHub haben ähnliches gemacht. Wie das gemacht wird habe ich bereits <a href="http://code-inside.de/blog/2013/08/04/custom-uri-handler-aus-dem-web-mit-dem-desktop-reden-so-wie-spotify-github-for-windows/">hier beschrieben</a>.</p> <p><strong>Vorteil:</strong> Lockere Bindung zwischen Web- und Desktop.<br><strong>Nachteil:</strong> Die Interaktion geht vom “Web” aus und von der Funktionalität ist es wie ein Deep-Link in eine Desktop-Anwendung.</p> <p>Weitere Informationen dazu in meinem <a href="http://code-inside.de/blog/2013/08/04/custom-uri-handler-aus-dem-web-mit-dem-desktop-reden-so-wie-spotify-github-for-windows/"><strong>Blogpost</strong></a> bzw. gab es bei der <a href="http://dd-dotnet.de/">User Group Dresden</a> ebenfalls eine <a href="http://de.slideshare.net/dd.dotnet/deeplinking-in-eine-winformsanwendung?from=ss_embed"><strong>Präsentation</strong></a> dazu.</p> <h3>Vom Web zur Desktop-Anwendung über window.external.notify</h3> <p>Auf diese Variante bin ich erst vor kurzem gestossen und war ein wenig begeistert. Grundgedanke ist, dass eine Desktop-Anwendung eine Web-Applikation über einen “embedded” WebBrowser anzeigen kann. Dem WebBrowser kann man ein “<a href="http://msdn.microsoft.com/en-us/library/system.windows.forms.webbrowser.objectforscripting.aspx">ObjectForScripting</a>” mitgeben. Die angezeigte Webseite kann dann über den Javascript Aufruf von “<a href="http://msdn.microsoft.com/en-us/library/ie/ms535246(v=vs.85).aspx">window.external</a>.notify(…)” das “ObjectForScripting” im Host aufrufen. </p> <p><strong>Ok – ganz langsam:</strong></p> <p>Dies ist die Web-App die wir in unserer WPF App “embedden” wollen:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">&lt;!DOCTYPE html&gt;
&lt;html xmlns="http://www.w3.org/1999/xhtml"&gt;
&lt;head&gt;
    &lt;title&gt;SamplePage for notify&lt;/title&gt;
    &lt;meta http-equiv="X-UA-Compatible" content="IE=edge" /&gt; 
&lt;/head&gt;
&lt;body&gt;
    &lt;h1&gt;Foobar!&lt;/h1&gt;
    &lt;button onclick="foobar()"&gt;Click Me!&lt;/button&gt;
    &lt;script type="text/javascript"&gt;

        function foobar() {
            if (window.external == 'WebBrowserNotify.ScriptingContext') {
                window.external.notify("Hello World!");
            }
        }

    &lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>
<p>Der Aufbau ist simpel – drückt man einen Button soll die “notify”-Funktion mit “Hello World!” aufgerufen werden. Durch den Check auf den “WebBrowserNotify.ScriptingContext” bekomme ich in Chrome und IE keine Fehlermeldung wenn ich die Seite so aufrufe.</p>
<p>Die WPF-Applikation ist auch sehr simpel gemacht und besteht nur aus zwei Bereichen:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1918.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb1057.png" width="516" height="332"></a> </p>
<p>Der erste Kasten ist einfach nur das WebBrowser Control und im unteren Bereich ist ein TextBlock in dem ich später die Ergebnisse anzeigen möchte.</p>
<p>Im Xaml:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">&lt;Window x:Class="WebBrowserNotify.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="MainWindow" Height="350" Width="525"&gt;
    &lt;StackPanel&gt;
        &lt;WebBrowser Height="200" x:Name="Host" /&gt;
        &lt;TextBlock x:Name="Result" /&gt;
    &lt;/StackPanel&gt;
&lt;/Window&gt;
</pre>
<p>Code:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();

            var scripting = new ScriptingContext();
            scripting.NotifyInvoked += (sender, args) =&gt;
                                           {
                                               this.Result.Text += args.Result;
                                           };

            this.Host.ObjectForScripting = scripting;
            this.Host.Navigate("http://localhost:40414/Index.html");
        }
    }

    [ComVisible(true)]
    public class ScriptingContext
    {
        public delegate void NotifyInvokedEventHandler(object sender, NotifyInvokedEventArgs e);

        public event NotifyInvokedEventHandler NotifyInvoked;

        public void notify(string result)
        {
            if (NotifyInvoked != null)
            {
                var args = new NotifyInvokedEventArgs { Result = result };
                NotifyInvoked(this, args);
            }
        }
    }

    public class NotifyInvokedEventArgs : EventArgs
    {
        public string Result { get; set; }

    }</pre>
<p><strong>Erklärung: </strong></p>
<p>Der “Host” ist ein WPF <a href="http://msdn.microsoft.com/en-us/library/system.windows.controls.webbrowser.aspx">WebBrowser</a> Objekt. Auf WinForms Seite gibt es sogar noch ein “mächtigeres” <a href="http://msdn.microsoft.com/en-us/library/system.windows.forms.webbrowser.aspx">Control</a>. Diesem geben wir ein “ObjectForScripting” mit. Dies muss “ComVisible” sein und hat per Konvention eine Methode “notify”.<strong> Das ist genau die Methode die aus dem Javascript aufgerufen wird.</strong> Im ScriptingContext habe ich nur noch ein <a href="http://code-inside.de/blog/2008/07/12/howto-eigene-net-events-definieren-und-mit-unit-tests-testen/">Event definiert</a> und darauf registriert sich der Code. Am Ende wird bei jedem Klick in der WebApp das Ergebnis in der WPF-Anwendung ausgegeben.</p>
<p>Hier gibt es noch eine <a href="http://blogs.msdn.com/b/wpf/archive/2011/05/27/how-does-wpf-webbrowser-control-handle-window-external-notify.aspx">Erklärung</a> von WPF Team. Kleine Erinnerung: In der Web-Anwendung habe ich external == “WebBrowserNotify.ScriptingContext” abgefragt – dies ist einfach nur der Namespace + der Klassenname des “ObjectForScripting”. Man kann diese Abfrage aber auch anders gestalten.</p>
<p><strong>Wichtig: Wo die WebApp läuft ist egal. </strong></p>
<p>Die Web-Anwendung kann irgendwo laufen – lokal, im Intranet oder irgendwo anders. Im Grunde ist es ein normaler WebBrowser welcher in der Anwendung genutzt wird, nur das noch zusätzlich ein Objekt mitgegeben wird, welches aus dem Javascript aufgerufen werden kann.</p>
<h3></h3>
<h3>Was macht man damit?</h3>
<p>Ich kann mir gut vorstellen das iTunes im Grunde sowas macht. Soweit ich dies mal beobachtet hab ist der iTunes Client auch nur ein “Browser”. Um bestimmte Daten von der Web-Anwendung an den Host weiterzugeben wäre so eine Variante vorstellbar.</p>
<p>Auch Authentifizierungs-Dialog können so umgesetzt werden: Ein Fat-Client authentifiziert sich damit gegen eine Web-Anwendung und nach der Authentifizierung wird die “notify” Methode im Fat-Client aufgerufen. Dies ist die Mechanik die sich auch Microsoft mit der <a href="http://msdn.microsoft.com/en-us/library/windowsazure/jj573266.aspx">Azure Authentication Library</a> zunutze macht. Ein iOS Entwickler hat dieses Vorgehen sogar <a href="http://www.stevesaxon.me/posts/2011/window-external-notify-in-ios-uiwebview/">im UIWebView zum Laufen gebracht</a>. </p>
<h3>window.external.notify – WinRT &amp; Windows Phone Support</h3>
<p>Auf der Windows-Desktop Welt kann man dem ObjectForScripting beliebige Methoden mitgeben. Auf WinRT und Windows Phone gelang es mir aber nur mit der “notify” Methode – andere Methoden waren nicht unterstützt. Aber man kann beliebige Daten über diese Methode tunneln (z.B. als JSON). Wie oben bereits verlinkt geht es wohl über Tricks auch mit <a href="http://www.stevesaxon.me/posts/2011/window-external-notify-in-ios-uiwebview/">iOS</a>.</p>
<h3>Fazit</h3>
<p>Über solch ein Hosting einer WebApp innerhalb der eigenen Anwendung kann man recht interessante Szenarios abdecken. </p>
<p>Den kompletten Sample-Code gibt es wie immer auf <a href="https://github.com/Code-Inside/Samples/tree/master/2013/WebBrowserNotify"><strong>GitHub</strong></a>.</p>
