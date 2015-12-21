---
layout: post
title: "WPF Apps im Metro / Windows 8 Look mit MahApps.Metro"
date: 2012-11-14 07:00
author: Robert Muehsig
comments: true
categories: [Allgemein, HowTo]
tags: [HowTo, Metro, WPF]
language: de
---
{% include JB/setup %}
<p>Es gibt sie noch – die großen WPF Applikationen, welche mehr Funktionalität brauchen als es momentan über den normalen “Windows 8” Store möglich ist. Dennoch lässt sich natürlich auch da das Aussehen an den “Windows 8 Style”&nbsp; aka “Metro” anpassen. </p> <p>Bei dem Blogpost der <a href="{{BASE_PATH}}/2012/11/11/howto-rahmenlose-wpf-apps-mit-schattenwurf/">“Rahmenlosen” WPF Fenster</a> habe ich ja bereits einige Beispiele erwähnt welche den Metro-Style auch in einer Desktop-Applikation anwenden:</p> <p><img style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px" border="0" src="{{BASE_PATH}}/assets/wp-images-de/image1640.png" width="579" height="279"></p> <p><img style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px" border="0" src="{{BASE_PATH}}/assets/wp-images-de/image1641.png" width="575" height="231"></p> <p><img style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px" border="0" src="{{BASE_PATH}}/assets/wp-images-de/image1642.png" width="570" height="303"></p> <p><strong>Den Weg zum Metro / Windows 8 Design</strong></p> <p>Ganz wichtig (und ich widerhole es noch unten) : Wer seine WPF App in dem Metro Style (ich schwanke noch zwischen der Metro Bezeichnung und Windows 8 Style ;)) umsetzen möchte, sollte sich ein paar Gedanken dazu gemacht haben. Metro ist mehr als Ecken und Kanten. MahApps.Metro ist nur ein Tool – <strong>den Design-Prozess müsst ihr selber erledigen</strong>.</p> <p><strong>MahApps.Metro</strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1660.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb818.png" width="588" height="382"></a> </p> <p><a href="http://mahapps.com/MahApps.Metro/">MahApps.Metro</a> ist eine Library, welche eine WPF App recht schnell in den Metro Style umwandeln kann. Es bringt allerhand Controls, Styles und sogar Icons mit und wird auch über NuGet bereitgestellt. Der Code steht auf GitHub zur <a href="https://github.com/MahApps/MahApps.Metro">Verfügung</a>.</p> <p>Das ganze animiert:</p> <p><img style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px" border="0" src="http://mahapps.com/MahApps.Metro/images/animatedtabcontrol.gif"></p> <p><strong>Demo:</strong></p> <p>Um das mal nachzuvollziehen wollen wir diese App etwas mehr im “Metro” / “Windows 8 Style” glänzen lassen.</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1655.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb813.png" width="468" height="311"></a>&nbsp;</p> <p>Der Code dazu:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">&lt;Window x:Class="MetroWpf.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="MainWindow" Height="350" Width="525"&gt;
    &lt;StackPanel Margin="50"&gt;
        &lt;Label Margin="10"&gt;Hello World!&lt;/Label&gt;
        &lt;TextBox Margin="10"&gt;&lt;/TextBox&gt;
        &lt;DatePicker Margin="10" /&gt;
        &lt;Button Margin="10"&gt;Click Me&lt;/Button&gt;
    &lt;/StackPanel&gt;
&lt;/Window&gt;
</pre>
<p>Jetzt fügen wir das NuGet Package hinzu:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1656.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb814.png" width="479" height="218"></a> </p>
<p>Und machen wenige Anpassungen:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">&lt;Controls:MetroWindow x:Class="MetroWpf.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:Controls="clr-namespace:MahApps.Metro.Controls;assembly=MahApps.Metro"
        Title="MainWindow" Height="350" Width="525"&gt;
    &lt;StackPanel Margin="50"&gt;
        &lt;Label Margin="10"&gt;Hello World!&lt;/Label&gt;
        &lt;TextBox Margin="10"&gt;&lt;/TextBox&gt;
        &lt;DatePicker Margin="10" /&gt;
        &lt;Button Margin="10"&gt;Click Me&lt;/Button&gt;
    &lt;/StackPanel&gt;
&lt;/Controls:MetroWindow&gt;</pre>
<p>Und in der Code-Behinde:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">    public partial class MainWindow : MetroWindow
    {
        public MainWindow()
        {
            InitializeComponent();
        }
    }</pre>
<p>Erstes Ergebnis:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1657.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb815.png" width="446" height="298"></a> </p>
<p>Jetzt noch den Style ändern (direkt unterhalb des MetroWindow Element einfügen) :</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">    &lt;Window.Resources&gt;
        &lt;ResourceDictionary&gt;
            &lt;ResourceDictionary.MergedDictionaries&gt;
                &lt;ResourceDictionary Source="pack://application:,,,/MahApps.Metro;component/Styles/Colours.xaml" /&gt;
                &lt;ResourceDictionary Source="pack://application:,,,/MahApps.Metro;component/Styles/Fonts.xaml" /&gt;
                &lt;ResourceDictionary Source="pack://application:,,,/MahApps.Metro;component/Styles/Controls.xaml" /&gt;
                &lt;ResourceDictionary Source="pack://application:,,,/MahApps.Metro;component/Styles/Accents/Blue.xaml" /&gt;
                &lt;ResourceDictionary Source="pack://application:,,,/MahApps.Metro;component/Styles/Accents/BaseLight.xaml" /&gt;
            &lt;/ResourceDictionary.MergedDictionaries&gt;
        &lt;/ResourceDictionary&gt;
    &lt;/Window.Resources&gt;</pre>
<p><strong>Resultat:</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1658.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb816.png" width="536" height="364"></a> </p>
<p>Für wenige Handgriffe: Ganz nett. In der Doku ist noch mehr Beschrieben – das ist ja ein recht triviales Beispiel was ich hier gebaut hab. Die Demo App welche dem Quellcode von MahApps beiliegt zeigt ziemlich eindrucksvoll wie man z.B. auch ein VS 2012 nachbauen könnte:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1659.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb817.png" width="551" height="443"></a> </p>
<p>Wer WPF Apps in diesem Style machen möchte – der sollte sich diese Bibliothek mal ansehen.</p>
<p><strong>WICHTIG: Nur das Styling macht noch keine Metro App aus!</strong></p>
<p>Nur weil man das aussehen “kantiger” macht ist es natürlich noch keine Metro App. Hier muss man sich intensiv Gedanken machen, wie meine Applikation in die “Metro”-Schiene hineinpasst. MahApps kann bei der Realisierung allerdings eine Hilfe sein.</p>
<p><strong>Links</strong></p>
<p><a href="http://mahapps.com/MahApps.Metro/">Doku MahApps</a></p>
<p><a href="https://github.com/MahApps/MahApps.Metro">GitHub MahApps</a></p>
<p><a href="https://github.com/Code-Inside/Samples/tree/master/2012/MetroWpf">Meine Demo App auf GitHub</a></p>
<p><strong>Happy Coding</strong></p>
