---
layout: post
title: "Windows Phone, Images & OutOfMemoryException"
date: 2013-04-12 22:48
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [App, Windows Phone]
language: de
---
{% include JB/setup %}
<p>Wer normalerweise Software entwickelt die auf großen Servern oder auf richtigen PC-Clients läuft der schnell Gefahr bei der Entwicklung für mobile Endgeräte recht schnell eine “OutOfMemoryException” zu sehen. Jedenfalls ging es mir so ;)</p> <h3>Szenario: Viele Bilder laden = ಠ_ಠ</h3> <p>Wer in Windows Phone viele Bilder (mit hoher Auflösung) als Bitmap in den Speicher laden oder anzeigen möchte, sollte sich im klaren sein, dass das schief gehen kann.</p> <p><strong>Was sind denn “viele”?</strong></p> <p>Ich hatte bereits das Problem das ich ab 8-10 Bilder ein Problem hatte – hierbei hab ich einfach auf Bilder auf dem Phone zugegriffen <strong>(ohne die Bilder zu skalieren!)</strong> und die Kamera des Nokias schiesst recht hochauflösende Bilder.</p> <p><strong>Ergebnis:</strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1816.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; display: inline; border-top-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb969.png" width="581" height="404"></a> </p> <p><strong>Das Memory-Limit bei Windows Phone Apps</strong></p> <p>Ab 150MB sollte man vorsichtig sein. Mehr dazu in der <a href="http://msdn.microsoft.com/en-us/library/windowsphone/develop/jj681682(v=vs.105).aspx">MSDN</a></p> <p><strong>URIs anstatt Bitmaps</strong></p> <p>Wer eine Foto-Anwendung baut sollte im ViewModel bzw. in der Applikationslogik eher mit URIs (= Pfad zum eigentlichen Bild) arbeiten anstatt direkt mit großen Bitmaps. Um das Bild in der UI anzuzeigen habe ich mir einen Converter geschrieben:</p> <p>Im XAML:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">&lt;Image Width="108" Height="108" Stretch="UniformToFill" Source="{Binding PhotoSource, Converter={StaticResource UriPathToThumbnailConverter}}" /&gt;</pre>
<p>Converter:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">public class UriPathToThumbnailConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            if(ViewModelBase.IsInDesignModeStatic)
            {
                return value;
            }

            IsolatedStorageFile ISF = IsolatedStorageFile.GetUserStoreForApplication();

            Uri path = value as Uri;

            using (var sourceFile = ISF.OpenFile(path.LocalPath, FileMode.Open, FileAccess.Read))
            {
                BitmapImage bm = new BitmapImage();
                bm.DecodePixelWidth = 220;
                bm.SetSource(sourceFile);
                return bm;
            }
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }</pre>
<p>Wichtig ist auch hier “<a href="http://msdn.microsoft.com/en-us/library/system.windows.media.imaging.bitmapimage.decodepixelwidth.aspx">DecodePixelWidth</a>” bzw. “DecodePixelHeight” zu setzen – damit kann wird das Bild auf eine bestimmte größe festgelegt und ich hatte die Memory Probleme in den Griff bekommen.</p>
<h3><strong>Profiler für Windows Phone Apps</strong> </h3>
<p>Im <a href="http://msdn.microsoft.com/en-us/library/windowsphone/develop/jj215908(v=vs.105).aspx">Visual Studio selbst ist auch ein Profiler</a> für Windows Phone Apps enthalten:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1817.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb970.png" width="558" height="478"></a> </p>
<p>Danach öffnet sich noch ein weiteres Menü:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1818.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb971.png" width="422" height="296"></a> </p>
<p>Danach startet die Anwendung und bis man die “Session” beendet werden Daten aufgenommen.</p>
<p><strong>Ergebnis des Profilers:</strong></p>
<p>Ein Graph!</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1819.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb972.png" width="545" height="153"></a> </p>
<p>Damit sollte man den Speicherverbrauch im Auge behalten können und optimieren.</p>
<p><strong>Weitere Tipps für Bilder &amp; Windows Phone</strong></p>
<p><a href="http://blogs.msdn.com/b/swick/archive/2011/04/07/image-tips-for-windows-phone-7.aspx">Dieser Blogpost</a> enthält noch einige weitere Hinweise – auch wenn er mit Windows Phone 7 betitelt ist, scheint es nach wie vor zuzutreffen. Weitere Tipps findet man auch <a href="http://msdn.microsoft.com/en-us/library/windowsphone/develop/ff967560(v=vs.105).aspx">in der MSDN</a>.</p>
<p><strong>Fazit:</strong></p>
<p>App-Entwickler sollten ein wesentlich strengeren Blick auf die Performance- und Memory-Werte der Anwendung schauen da man sehr leicht das System ausreizen kann. Mit den Hinweisen konnte ich jedenfalls meine Memory Probleme lösen ;)</p>
