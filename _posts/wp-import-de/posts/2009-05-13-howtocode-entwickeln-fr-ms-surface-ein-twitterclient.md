---
layout: post
title: "HowToCode: Entwickeln für MS Surface – ein Twitterclient"
date: 2009-05-13 08:40
author: Robert Muehsig
comments: true
categories: [HowToCode]
tags: [Surface, Twitter]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images-de/twitter.jpg"><img title="twitter" style="border-top-width: 0px; display: inline; border-left-width: 0px; border-bottom-width: 0px; margin: 0px 10px 0px 0px; border-right-width: 0px" height="111" alt="twitter" src="{{BASE_PATH}}/assets/wp-images-de/twitter-thumb.jpg" width="167" align="left" border="0" /></a></p>  <p>Der <a href="http://www.microsoft.com/surface/">Microsoft Surface</a> &#8220;Tisch&#8221; (oder das &#8220;Device&#8221;) ist ein recht tolles Spielzeug und kommt auch mit einem entsprechenden SDK daher. Leider ist dieses SDK nicht frei verf&#252;gbar (sondern muss mitsamt einem <a href="http://www.microsoft.com/surface/Default.aspx?page=howtobuy#section=Microsoft%20Surface%20SDK">Surface gekauft</a> werden), allerdings m&#246;chte ich trotzdem f&#252;r Interessierte meine erste Anwendung und &#252;ber den Entwicklungsprozess einer Surface Anwendung bloggen.</p>  <p></p> 
<!--more-->
  <p></p>  <p><strong>Die Werkzeuge: Surface Simulator &amp; Visual Studio</strong>     <br />Das wichtigste Werkzeug im SDK ist eigentlich der Surface Simulator, welcher alle wesentlichen Funktionen des Surfaces enth&#228;lt:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images-de/image731.png"><img title="image" style="border-top-width: 0px; display: inline; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="418" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb709.png" width="501" border="0" /></a></p>  <p>Der bekannte Multitouch Input ist ebenfalls m&#246;glich: Einfach noch eine USB Maus anstecken und schon sieht man 2 Finger &#8211; ich hab allerdings noch nicht ausprobiert, wieviele &#8220;Finger&#8221; der Simulator unterst&#252;tzt:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images-de/image732.png"><img title="image" style="border-top-width: 0px; display: inline; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="149" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb710.png" width="244" border="0" /></a></p>  <p>Diese kann man drehen, bewegen und &#8220;klicken&#8221; etc. und damit entsprechend rumspielen.</p>  <p><strong>Meine Anwendung: Ein Twitter Client f&#252;r den Surface!      <br /></strong>Da <a href="http://twitter.com/">Twitter</a> eine <a href="{{BASE_PATH}}/2009/04/20/howto-twittern-mit-c/">nette API bietet</a>, habe ich mich einfach mal dazu entschlossen einen simplen Client zu bauen, mit welchen man seine letzten Tweets sehen kann und selber auch Tweets absenden kann.     <br /><em><u>Achtung:</u></em> Von der Code Qualit&#228;t bin ich selber nicht &#252;berzeugt. Das liegt daran, dass es nur ein Testprojekt ist/war und ich mit WPF auch gerade Neuland begehe :)</p>  <p><strong>So sieht die Anwendung aus:</strong></p>  <p>Login Screen:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images-de/image733.png"><img title="image" style="border-top-width: 0px; display: inline; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="381" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb711.png" width="454" border="0" /></a></p>  <p>Screen zum Schreiben und Ansicht der letzten Tweets:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images-de/image734.png"><img title="image" style="border-top-width: 0px; display: inline; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="376" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb712.png" width="450" border="0" /></a></p>  <p><strong>Fazit:</strong> Designtechnisch arg bedenklich &#8211; Funktional ist es aber :)&#160; <br />Das Bild, welches man da malen kann, wird ge&#8221;twittpict&#8221; und der Tweet wird mit einem Link auf das Bild, gesendet.</p>  <p>Die Tastatur ist Element vom Surface um Texteingaben zu erm&#246;glichen. Die anderen Elemente sind ebenfalls spezielle Surface Elemente.</p>  <p><strong>Aufbau der Applikation      <br /></strong>Um die Elemente aus dem Surface SDK nutzen k&#246;nnen, wird ein neuer XML Namespace eingebunden (beginnend mit einem &#8220;s&#8221;). Im Projekt sind auch 3 spezielle Surface DLLs eingebunden.</p>  <p>Meine UI-Elemente liegen insgesamt in einem &#8220;ScatterView&#8221; (dies kann man <a href="{{BASE_PATH}}/2007/11/13/surface-sdk-in-action-bildbetrachten-mit-dem-scatterview/">auch hier</a> in Aktion sehen):</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e13d0057-80d3-4041-9ae9-4d777cf91b04" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">   <pre class="c#" name="code">&lt;s:SurfaceWindow
    xmlns=&quot;http://schemas.microsoft.com/winfx/2006/xaml/presentation&quot;
    xmlns:x=&quot;http://schemas.microsoft.com/winfx/2006/xaml&quot;
    xmlns:s=&quot;http://schemas.microsoft.com/surface/2008&quot;
    xmlns:d=&quot;http://schemas.microsoft.com/expression/blend/2008&quot; xmlns:mc=&quot;http://schemas.openxmlformats.org/markup-compatibility/2006&quot; x:Class=&quot;SurfaceTwitter.SurfaceWindowApp&quot;
    Title=&quot;SurfaceTwitter&quot;
    mc:Ignorable=&quot;d&quot;
    &gt;
  &lt;s:SurfaceWindow.Resources&gt;
    &lt;ImageBrush x:Key=&quot;WindowBackground&quot; Stretch=&quot;None&quot; ImageSource=&quot;pack://application:,,,/Resources/WindowBackground.jpg&quot;/&gt;
    &lt;Style x:Key=&quot;Error&quot;&gt;
        &lt;Setter Property=&quot;Control.Foreground&quot; Value=&quot;Red&quot; /&gt;
        &lt;Setter Property=&quot;Control.FontWeight&quot; Value=&quot;Bold&quot; /&gt;
    &lt;/Style&gt;
    &lt;/s:SurfaceWindow.Resources&gt;
    &lt;s:ScatterView Background=&quot;{StaticResource WindowBackground}&quot;&gt;
        &lt;!-- Tweets --&gt;
        &lt;s:ScatterViewItem CanScale=&quot;False&quot; x:Name=&quot;TweetsList&quot; Visibility=&quot;Hidden&quot; Margin=&quot;0,0,0,0&quot; Padding=&quot;20,20,20,20&quot; Width=&quot;310&quot; Height=&quot;500&quot; Background=&quot;#FFFFFFFF&quot;&gt;
	...
        &lt;/s:ScatterViewItem&gt;
        &lt;!--  Login --&gt;
        &lt;s:ScatterViewItem CanScale=&quot;False&quot; x:Name=&quot;Login&quot; VerticalAlignment=&quot;Bottom&quot; RenderTransformOrigin=&quot;0.5,0.5&quot; Height=&quot;136.252&quot; Margin=&quot;-45.49,0,-117.519,-109.58&quot;&gt;
        	...
        &lt;/s:ScatterViewItem&gt;
        &lt;!-- Drawing Pad - InkCanvas with white background and small border --&gt;
        &lt;s:ScatterViewItem CanScale=&quot;False&quot; Height=&quot;Auto&quot; x:Name=&quot;Writer&quot; Visibility=&quot;Hidden&quot; Background=&quot;Transparent&quot; Width=&quot;Auto&quot; BorderThickness=&quot;1,1,1,1&quot;&gt;
           ...
        &lt;/s:ScatterViewItem&gt;
    &lt;/s:ScatterView&gt;
&lt;/s:SurfaceWindow&gt;</pre>
</div>

<p><strong>Surface Controls</strong></p>

<p>Im SDK sind einige Surface Controls enthalten, die Multitouch bzw. &#8220;Touch&#8221; Input besser weiterverarbeiten als die Standard WPF Controls, darunter sind z.B.</p>

<ul>
  <li>SurfaceTextBox </li>

  <li>SurfaceButton </li>

  <li>ScatterView </li>

  <li>&#8230; </li>
</ul>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image735.png"><img title="image" style="border-top-width: 0px; display: inline; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="262" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb713.png" width="234" border="0" /></a>&#160;</p>

<p>Also eine ganze Menge.</p>

<p><strong>Debugging</strong></p>

<p>Solange der Simulator l&#228;uft, &#246;ffnet sich die Anwendung auch im Simulator. Falls nicht, startet es als normale WPF Applikation ohne Multitouch Sachen.</p>

<p><strong>XNA</strong></p>

<p>Neben der WPF Entwicklung kann man auch XNA f&#252;r die Surface Entwicklung verwenden:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image736.png"><img title="image" style="border-top-width: 0px; display: inline; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="63" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb714.png" width="369" border="0" /></a></p>

<p><strong>Unterschied zu WPF/Silverlight</strong></p>

<p>Neben den erweiterten Controls muss man nat&#252;rlich auch etwas mehr Gedanken &#252;ber das Design der Applikation machen. Im Idealfall sollten Surface Anwendungen von jeder Seite des Tisches aus bedient werden und es k&#246;nnen auch mehrere Leute damit rumspielen. Es gibt nicht wie in klassischen Anwendungen oben und unten &#8211; wenn das einem bewusst ist und man in WPF/XNA richtig fit ist, kann man sich mit dem Surface SDK gut austoben.</p>

<p><strong>Wie bin ich an das SDK gekommen? 
    <br />

    <br /></strong><a href="{{BASE_PATH}}/assets/wp-images-de/image737.png"><img title="image" style="border-top-width: 0px; display: inline; border-left-width: 0px; border-bottom-width: 0px; margin: 10px 10px 0px 0px; border-right-width: 0px" height="63" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb715.png" width="134" align="left" border="0" /></a> <strong></strong></p>

<p>Mein <a href="http://www.t-systems-mms.com">Arbeitgeber</a> ist einer der L&#246;sungspartner f&#252;r <a href="http://www.t-systems-mms.com/workplace/de/Informationsmanagement/Microsoft/Surface/surface_index">Microsoft Surface Anwendungen</a> &#8211; leider ist das SDK wie gesagt nicht frei verf&#252;gbar.&#160; Meine Kollegen haben auch bereits andere Anwendungen f&#252;r den Tisch entwickelt. Videos von diesen Anwendungen findet man <a href="http://www.youtube.com/user/TSystemsMMS">hier</a>.</p>

<p><strong>Microsoft Surface Service Pack 1
    <br />

    <br /></strong>Auf <a href="http://www.golem.de/0905/67048.html">Golem</a> gibt es zudem einen Artikel mit einem <a href="http://www.youtube.com/watch?v=g4xxNpijEKQ">Video</a> &#252;ber das Service Pack 1 f&#252;r den Surface, wo viele weitere nette Spielerein eingebaut wurden.</p>

<p><strong>Source Code</strong></p>

<p>Auch wenn das SDK nicht frei runterzuladen ist (und es daher bei 99% der Leser hier sicherlich nicht funktioniert), stelle ich den Source Code f&#252;r Interessierte zum Download bereit. Bei Fragen/Anregungen meldet euch einfach.</p>

<p><strong><a href="{{BASE_PATH}}/assets/files/democode/surfacetwitter/surfacetwitter.zip">[ Download Source Code ]</a></strong></p>
