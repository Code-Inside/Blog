---
layout: post
title: "HowTo: Rahmenlose WPF Apps mit Schattenwurf"
date: 2012-11-11 14:47
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [WPF]
language: de
---
{% include JB/setup %}
<p>Die Standard-Fenster von Windows verschwinden immer mehr und werden ersetzt durch schicker anmutende Bedienelemente. Diesmal meine ich allerdings keine “Metro” Apps, sondern normale, full-power Windows Applikationen.</p> <p><strong>Achtung:</strong> Der Blogpost ist sehr “Low-Level”. Es gibt bestimmt einige Libraries oder NuGet Packages, die diese Sachen mitbringen. Die herangehensweise hat auch 2 Nachteile! </p> <p>Aus dem Drögen Standard (für Windows Desktop Applikationen):</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1639.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; display: inline; border-top-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb798.png" width="556" height="395"></a> </p> <p>Wird zum Beispiel sowas:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1640.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; display: inline; border-top-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb799.png" width="559" height="271"></a> </p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1641.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; display: inline; border-top-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb800.png" width="563" height="234"></a> </p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1642.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; display: inline; border-top-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb801.png" width="578" height="312"></a> </p> <p>&nbsp;<strong>1. Schritt: WPF Window Rahmenlos machen</strong></p> <p>Um ein “Window” komplett rahmenlos zu bekommen muss man die Eigenschaften “WindowStyle” auf “none” setzen und den “ResizeMode” auf “NoResize”. </p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">&lt;Window x:Class="DropShadow.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="MainWindow" Height="350" Width="525" WindowStyle="None" ResizeMode="NoResize" WindowStartupLocation="CenterScreen"&gt;
    &lt;Grid&gt;
        
    &lt;/Grid&gt;
&lt;/Window&gt;</pre>
<p>Ergebnis:</p>
<p>Man hat nun eine gänzlich weiße Fläche.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1643.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; display: inline; border-top-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb802.png" width="514" height="368"></a> </p>
<p><strong>2. Schritt: Den Rahmen erzeugen</strong></p>
<p>Ich hatte erst über diverse Styles es probiert, allerdings hab ich dann <a href="https://groups.google.com/forum/?fromgroups=#!topic/wpf-disciples/gtQI5Wngtfk" target="_blank">diese Lösung</a> gefunden, welche direkt Betriebssystem Funktionen nutzt. Vorteil: Auf Windows 8 sieht es “dezenter” aus als auf Windows 7 – sprich: Es passt besser in das Gesamtbild des Betriebssystem.</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">    /// &lt;summary&gt;
    /// Interaction logic for MainWindow.xaml
    /// &lt;/summary&gt;
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct Margins
        {
            public int leftWidth;
            public int rightWidth;
            public int topHeight;
            public int bottomHeight;
        }

        protected override void OnSourceInitialized(EventArgs e)
        {
            base.OnSourceInitialized(e);

            var helper = new WindowInteropHelper(this);

            int val = 2;

            DwmSetWindowAttribute(helper.Handle, 2, ref val, 4);
            var m = new MainWindow.Margins { bottomHeight = -1, leftWidth = -1, rightWidth = -1, topHeight = -1 };

            DwmExtendFrameIntoClientArea(helper.Handle, ref m);
            IntPtr hwnd = new WindowInteropHelper(this).Handle;
        }

        [DllImport("dwmapi.dll", PreserveSig = true)]
        public static extern int DwmSetWindowAttribute(IntPtr hwnd, int attr, ref int attrValue, int attrSize);

        [DllImport("dwmapi.dll")]
        public static extern int DwmExtendFrameIntoClientArea(IntPtr hWnd, ref Margins pMarInset);
    }</pre>
<p>Resultat:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1644.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; display: inline; border-top-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb803.png" width="524" height="389"></a></p>
<p><strong>Was man dabei beachten sollte:</strong></p>
<p>Durch das rahmenlose Fenster muss man sich natürlich jetzt selber darum kümmern, dass der Anwender es vergrößern bzw. verkleinern kann und das man das Fenster verschieben kann. Ich vermute es gibt hier (wie oben erwähnt) irgendwelche Frameworks/Libraries/NuGet Packges die einem das Leben vereinfachen.</p>
<p><strong>Die kompletten Sourcen </strong><a href="https://github.com/Code-Inside/Samples/tree/master/2012/DropShadow" target="_blank"><strong>findet ihr auf GitHub</strong></a><strong>.</strong></p>
