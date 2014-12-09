---
layout: post
title: "HowTo: WPF Windows mit dem Vista Glass Effekt ausstatten"
date: 2008-01-17 23:22
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [.NET 3.0, Aero, Glass Effect, HowTo, Vista, Visual Studio 2008, WPF, XAML]
language: de
---
{% include JB/setup %}
<p>Eine optische Verbesserung (jedenfalls für mich) stellt in Vista der so genannte Glass Effekt dar. Wer nun mit WPF arbeitet, wird vielleicht denken, dass solch ein Effekt direkt mit geliefert wird (immerhin ist .NET 3.0 in Vista fest integriert) - jedoch geht dies nicht so einfach.</p> <p>Im Internet bin ich auf diesen <a href="http://blogs.msdn.com/adam_nathan/archive/2006/05/04/589686.aspx" target="_blank">Blogpost</a> gestoßen - da das nicht schwierig aussah und auch schick war, ich aber nach einem simplen Beispiel suchte, habe ich mir schnell selber etwas zusammengetippt.</p> <p><u>Hier das Ergebnis mal als Screenshot:</u></p> <p>Ein Standard WPF Window:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image228.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="232" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb207.png" width="244" border="0"></a> </p> <p>Das Aero Window:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image229.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="241" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb208.png" width="244" border="0"></a> </p> <p><u>Was muss man dafür machen:</u></p> <p>Wie in dem Blogartikel oben erwähnt, legt man folgende Klasse mit dem Source Code an:</p> <div class="CodeFormatContainer"><pre class="csharpcode"><span class="kwrd">using</span> System;
<span class="kwrd">using</span> System.Collections.Generic;
<span class="kwrd">using</span> System.Linq;
<span class="kwrd">using</span> System.Text;
<span class="kwrd">using</span> System.Runtime.InteropServices;
<span class="kwrd">using</span> System.Windows.Media;
<span class="kwrd">using</span> System.Windows;
<span class="kwrd">using</span> System.Windows.Interop;

<span class="kwrd">namespace</span> WPFAero
{
    <span class="kwrd">public</span> <span class="kwrd">class</span> GlassHelper
    {
        <span class="kwrd">public</span> <span class="kwrd">static</span> <span class="kwrd">bool</span> ExtendGlassFrame(Window window, Thickness margin)
        {
            <span class="kwrd">if</span> (!DwmIsCompositionEnabled())
                <span class="kwrd">return</span> <span class="kwrd">false</span>;

            IntPtr hwnd = <span class="kwrd">new</span> WindowInteropHelper(window).Handle;
            <span class="kwrd">if</span> (hwnd == IntPtr.Zero)
                <span class="kwrd">throw</span> <span class="kwrd">new</span> InvalidOperationException(<span class="str">"The Window must be shown before extending glass."</span>);

            <span class="rem">// Set the background to transparent from both the WPF and Win32 perspectives</span>
            window.Background = Brushes.Transparent;
            HwndSource.FromHwnd(hwnd).CompositionTarget.BackgroundColor = Colors.Transparent;

            MARGINS margins = <span class="kwrd">new</span> MARGINS(margin);
            DwmExtendFrameIntoClientArea(hwnd, <span class="kwrd">ref</span> margins);
            <span class="kwrd">return</span> <span class="kwrd">true</span>;
        }


        [DllImport(<span class="str">"dwmapi.dll"</span>, PreserveSig = <span class="kwrd">false</span>)]
        <span class="kwrd">static</span> <span class="kwrd">extern</span> <span class="kwrd">void</span> DwmExtendFrameIntoClientArea(IntPtr hwnd, <span class="kwrd">ref</span> MARGINS margins);

        [DllImport(<span class="str">"dwmapi.dll"</span>, PreserveSig = <span class="kwrd">false</span>)]
        <span class="kwrd">static</span> <span class="kwrd">extern</span> <span class="kwrd">bool</span> DwmIsCompositionEnabled();
    }

    
<span class="kwrd">struct</span> MARGINS
{
  <span class="kwrd">public</span> MARGINS(Thickness t)
  {
    Left = (<span class="kwrd">int</span>)t.Left;
    Right = (<span class="kwrd">int</span>)t.Right;
    Top = (<span class="kwrd">int</span>)t.Top;
    Bottom = (<span class="kwrd">int</span>)t.Bottom;
  }
  <span class="kwrd">public</span> <span class="kwrd">int</span> Left;
  <span class="kwrd">public</span> <span class="kwrd">int</span> Right;
  <span class="kwrd">public</span> <span class="kwrd">int</span> Top;
  <span class="kwrd">public</span> <span class="kwrd">int</span> Bottom;
}

}
</pre></div>
<p>Aero wird über die "dwmapi.dll" gebildet - am Ende ruft man eine einzelne statische Methode auf, welche man das Window übergibt.<br>Auf Codeproject habe ich dann noch eine andere Erweiterung dafür gefunden: <a href="http://www.codeproject.com/KB/WPF/WPFGlass.aspx" target="_blank">Glass Effekt als Attached Property (Adding Glass Effect to WPF using Attached Properties)</a></p>
<p>Somit wäre es möglich, einem Window im Xaml direkt den Glass Effekt zuzuweisen:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">&lt;Window x:Class=<span class="str">"GlassEffectDemo.MainWindow"</span>
    xmlns=<span class="str">"http://schemas.microsoft.com/winfx/2006/xaml/presentation"</span>
    xmlns:x=<span class="str">"http://schemas.microsoft.com/winfx/2006/xaml"</span>
    xmlns:src=<span class="str">"clr-namespace: GlassEffectDemo"</span>
    src:GlassEffect.IsEnabled=<span class="str">"True"</span>
    Title=<span class="str">"GlassEffect demo"</span> Height=<span class="str">"300"</span> Width=<span class="str">"300"</span>&gt;
    &lt;Grid&gt;
    &lt;/Grid&gt;
&lt;/Window&gt;  </pre></div>
<p><strong>Wichtiger Hinweis: Aero gibt es nur auf Vistabasis und auch nur bei aktivierem Aero (sollte klar sein)</strong></p>
<p>Wäre interessant zu erfahren, ob es bei diesem aktivieren Aero zu irgendwelchen WPF Schwierigkeiten kommen kann - getestet habe ich es noch nicht ;)</p>
<p>Das Demoprojekt könnt ihr wie immer Downloaden - Visual Studio 2008 &amp; Vista ist aber Voraussetzung.</p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/wpfaero/wpfaero.zip" target="_blank">[ Download Democode ]</a></strong></p>
