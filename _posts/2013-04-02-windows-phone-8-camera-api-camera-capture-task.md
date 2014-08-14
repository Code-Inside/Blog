---
layout: post
title: "Windows Phone 8 Camera API & Camera Capture Task"
date: 2013-04-02 21:51
author: robert.muehsig
comments: true
categories: [HowTo, Windows Phone]
tags: [Camera, Windows Phone]
---
{% include JB/setup %}
<p>Wer ein Windows Phone sein eigen nennt und .NET Entwickler ist da liegt es nah mal das Windows Phone SDK auszuprobieren. Der Zugriff auf Hardware geht bei “nativen” Anwendungen naturgemäß deutlich einfacher als es selbst bei modernsten Webanwendung im Jahre 2013 möglich wäre, daher hab ich mir die Kamera API unter Windows Phone 8 angeschaut.</p> <p>In meinem Beispiel möchte ich einfach nur auf die Kamera zugreifen und ein aktuelles Bild aufnehmen und anzeigen – keine Speicherung, keine Videoaufnahme etc.</p> <h3>Variante 1: Camera Capture Task</h3> <p>Die einfachste Möglichkeit ein Bild aufzunehmen ist auf die mitgelieferte Foto-App zu verweisen – dafür gibt es den “<a href="http://msdn.microsoft.com/en-us/library/windowsphone/develop/hh394006(v=vs.105).aspx">Camera Capture Task</a>”. </p> <p><strong>Vorteil:</strong> </p> <p>Spezielle Bildeinstellungen (ISO…), Kamerablitz, Zoomeinstellungen etc. kann der Nutzer wie gewohnt nutzen und die eigene App benötigt prinzipell keinen direkten Zugriff auf die Kamera. Generell kann man auch davon ausgehen dass die Foto-App sehr gut getestet ist.</p> <p><strong>Nachteil:</strong></p> <p>Aufgenommen Bilder werden auch in der “Camera Roll” gespeichert. Hat der Nutzer nun noch eingestellt dass das Bild automatisch zu Skydrive geladen wird, passiert dies ebenfalls. Die eigene Anwendung bekommt eine Kopie des Bildes. Wenn man also nur temporär das Bild benötigt, die Bilddaten nur innerhalb der Anwendung behalten möchte oder eine eigene (vll. bessere) UI bauen möchte, für den ist diese Variante eher nicht geeignet.</p> <p><strong>Code:</strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1802.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; display: inline; border-top-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb956.png" width="568" height="359"></a> </p> <p>Das Bild selbst zeige ich hinterher im Image Element namens “Result” an. In der Application Bar ist einfach ein Button der zur eigentlichen Camera App weiterleitet.</p> <p><strong>Der Code ist hierbei denkbar einfach:</strong></p> <p><a href="http://msdn.microsoft.com/en-us/library/windowsphone/develop/microsoft.phone.tasks.cameracapturetask(v=vs.105).aspx">CameraCaptureTask</a> definieren und auf Button-Click wird “Show” aufgerufen.</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">    public partial class MainPage : PhoneApplicationPage
    {
        CameraCaptureTask cameraCaptureTask;

        // Constructor
        public MainPage()
        {
            InitializeComponent();

            cameraCaptureTask = new CameraCaptureTask();
            cameraCaptureTask.Completed += new EventHandler&lt;PhotoResult&gt;(cameraCaptureTask_Completed);
        }

        private void ApplicationBarIconButton_Click(object sender, EventArgs e)
        {
            cameraCaptureTask.Show();
        }

        private void cameraCaptureTask_Completed(object sender, PhotoResult e)
        {
            if(e.TaskResult == TaskResult.OK)
            {
                BitmapImage image = new BitmapImage();
                image.SetSource(e.ChosenPhoto);
                Result.Source = image;
            }
        }


        private void ApplicationBarIconButtonApi_Click(object sender, EventArgs e)
        {
            NavigationService.Navigate(new Uri("/CameraPreview.xaml", UriKind.Relative));
        }
    }</pre>
<p>Bei “<a href="http://msdn.microsoft.com/en-us/library/windowsphone/develop/microsoft.phone.tasks.cameracapturetask.show(v=vs.105).aspx">Show</a>” wird die Camera App gestartet:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1803.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb957.png" width="155" height="240"></a> </p>
<p>Nachdem man das Foto gemacht hat kommt man in das “Complete”-Event. Wobei man aber hier noch prüfen muss ob wirklich ein Bild gemacht wurde oder nicht.</p>
<p>Fertig.</p>
<h2>Variante 2: Camera API</h2>
<p>Die <a href="http://msdn.microsoft.com/en-us/library/windowsphone/develop/jj662940(v=vs.105).aspx">Camera API</a> ist wesentlich mächtiger – erfordert allerdings auch mehr Aufwand. In meinem Demo zeig ich nur das aktuelle Kamerabild an und kann dann ein Bild knipsen. </p>
<p><strong>Vorteil:</strong></p>
<p>Komplette Kontrolle, die Bilder bleiben in der App (bzw. kann ich es selbst entscheiden) und man kann die wildesten Sachen machen (vermutlich ;))</p>
<p><strong>Nachteil:</strong></p>
<p>Man muss alles selber machen – Blitz, Kameraeinstellungen (wenn man die braucht), Preview-Bild darstellen etc. und die Anwendung braucht den Zugriff auf die Kamera:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1804.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb958.png" width="583" height="266"></a> </p>
<p><strong>Code:</strong></p>
<p>Der Aufbau ist fast identisch – nur das ein Canvas-Element benutze um darin das Kamerabild anzuzeigen:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">        ...&lt;Grid x:Name="ContentPanel" Grid.Row="1"&gt;
            &lt;Canvas x:Name="VideoCanvas"&gt;
                &lt;Canvas.Background&gt;
                    &lt;VideoBrush x:Name="videoBrush"&gt;
                        &lt;VideoBrush.RelativeTransform&gt;
                            &lt;CompositeTransform x:Name="previewTransform"
                            CenterX=".5"
                            CenterY=".5" /&gt;
                        &lt;/VideoBrush.RelativeTransform&gt;
                    &lt;/VideoBrush&gt;
                &lt;/Canvas.Background&gt;
            &lt;/Canvas&gt;
            &lt;Image Visibility="Collapsed" x:Name="Result" /&gt;
        &lt;/Grid&gt;...</pre>
<p>Etwas sonderbar, aber ich hab es nicht anders hin bekommen: Das Bild über die API ist immer im Panorama-Mode – wenn ich es im Portrait-Mode anzeigen möchte muss ich das Bild drehen, daher die Transform. </p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">    public partial class CameraPreview : PhoneApplicationPage
    {
        private PhotoCamera cam;

        public CameraPreview()
        {
            InitializeComponent();
        }

        protected override void OnNavigatedTo(System.Windows.Navigation.NavigationEventArgs e)
        {
            VideoCanvas.Visibility = Visibility.Visible;
            Result.Visibility = Visibility.Collapsed;
            if (PhotoCamera.IsCameraTypeSupported(CameraType.Primary))
            {
                cam = new PhotoCamera(CameraType.Primary);
                cam.CaptureImageAvailable += new EventHandler&lt;Microsoft.Devices.ContentReadyEventArgs&gt;(cam_CaptureCompleted);
                videoBrush.SetSource(cam);
                previewTransform.Rotation = cam.Orientation;
            }
        }

        private void cam_CaptureCompleted(object sender, ContentReadyEventArgs e)
        {
            this.Dispatcher.BeginInvoke(() =&gt;
                                            {
                                                BitmapImage tempImage = new BitmapImage();
                                                tempImage.SetSource(RotateStream(e.ImageStream, Convert.ToInt32(cam.Orientation)));

                                                Result.Source = tempImage;
                                                Result.Visibility = Visibility.Visible;
                                                VideoCanvas.Visibility = Visibility.Collapsed;
                                            });

        }

        /// &lt;summary&gt;
        /// Picture needs to be rotated - dunno why (because of the ImageRotateTransform... sucks...)
        /// &lt;/summary&gt;
        /// &lt;param name="stream"&gt;&lt;/param&gt;
        /// &lt;param name="angle"&gt;&lt;/param&gt;
        /// &lt;returns&gt;&lt;/returns&gt;
        private Stream RotateStream(Stream stream, int angle)
        {
          ...
        }

        protected override void OnNavigatingFrom(System.Windows.Navigation.NavigatingCancelEventArgs e)
        {
            if (cam != null)
            {
                cam.Dispose();

                cam.CaptureImageAvailable -= cam_CaptureCompleted;
            }
        }

        private void like_Click(object sender, EventArgs e)
        {
            cam.CaptureImage();
        }

    }</pre>
<p>Beim Navigieren zu dieser Page prüfen wir ob das Phone überhaupt eine Kamera besitzt und initialisieren&nbsp; das “<a href="http://msdn.microsoft.com/en-US/library/windowsphone/develop/microsoft.devices.photocamera(v=vs.105).aspx">PhotoCamera</a>” Objekt und setzen einen Event-Handler. Dann muss ich noch das Camerabild richtig drehen (previewTransform.Rotation = cam.Orientation), ansonsten passiert dies:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/wp_ss_20130402_0003.jpg"><img title="wp_ss_20130402_0003" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="wp_ss_20130402_0003" src="{{BASE_PATH}}/assets/wp-images/wp_ss_20130402_0003_thumb.jpg" width="271" height="440"></a> </p>
<p>Irgendwie… schräg – daher haben wir auch die Rotation drin.</p>
<p>Wenn ich auf den Button drücke wird “CaptureImage” aufgerufen und es geht in den Event-Handler rein. Hierbei passiert fast dasselbe wie bei der ersten Variante, aber durch den Trick mit dem drehen ist jetzt auch das Bild gedreht (keine Ahnung warum… vielleicht kann mir ein XAML/Windows Phone Experte einen Tipp geben was ich falsch mache) und muss entweder “optisch” zurückgedreht werden oder wir drehen das gesamte “File”. Da ich auf Byte/Pixtel/Stream-Niveau eine ziemliche Niete bin und ich den <a href="http://timheuer.com/blog/archive/2010/09/23/working-with-pictures-in-camera-tasks-in-windows-phone-7-orientation-rotation.aspx">Blogpost von Tim Heuer</a> gefunden hab geb ich einfach den Source Code der Methode wieder ohne es zu kommentieren ;)</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">/// &lt;summary&gt;
        /// Picture needs to be rotated - dunno why (because of the ImageRotateTransform... sucks...)
        /// Origin: http://timheuer.com/blog/archive/2010/09/23/working-with-pictures-in-camera-tasks-in-windows-phone-7-orientation-rotation.aspx
        /// &lt;/summary&gt;
        private Stream RotateStream(Stream stream, int angle)
        {
            stream.Position = 0;
            if (angle % 90 != 0 || angle &lt; 0) throw new ArgumentException();
            if (angle % 360 == 0) return stream;

            BitmapImage bitmap = new BitmapImage();
            bitmap.SetSource(stream);
            WriteableBitmap wbSource = new WriteableBitmap(bitmap);

            WriteableBitmap wbTarget = null;
            if (angle % 180 == 0)
            {
                wbTarget = new WriteableBitmap(wbSource.PixelWidth, wbSource.PixelHeight);
            }
            else
            {
                wbTarget = new WriteableBitmap(wbSource.PixelHeight, wbSource.PixelWidth);
            }

            for (int x = 0; x &lt; wbSource.PixelWidth; x++)
            {
                for (int y = 0; y &lt; wbSource.PixelHeight; y++)
                {
                    switch (angle % 360)
                    {
                        case 90:
                            wbTarget.Pixels[(wbSource.PixelHeight - y - 1) + x * wbTarget.PixelWidth] = wbSource.Pixels[x + y * wbSource.PixelWidth];
                            break;
                        case 180:
                            wbTarget.Pixels[(wbSource.PixelWidth - x - 1) + (wbSource.PixelHeight - y - 1) * wbSource.PixelWidth] = wbSource.Pixels[x + y * wbSource.PixelWidth];
                            break;
                        case 270:
                            wbTarget.Pixels[y + (wbSource.PixelWidth - x - 1) * wbTarget.PixelWidth] = wbSource.Pixels[x + y * wbSource.PixelWidth];
                            break;
                    }
                }
            }
            MemoryStream targetStream = new MemoryStream();
            wbTarget.SaveJpeg(targetStream, wbTarget.PixelWidth, wbTarget.PixelHeight, 0, 100);
            return targetStream;
        }</pre>
<p><strong>Fazit:</strong></p>
<p>Am “einfachsten” ist es vermutlich den Task zu nehmen – wenn der Anwendungsfall es zulässt. Die Sache mit der Rotation bei der Camera API ist mir etwas schleierhaft – vielleicht mach ich da auch etwas grundsätzlich falsch. Allerdings dauert es auch einige Sekunden bis man Pixel für Pixel den Stream umgebaut hat – daher würde ich das produktiv so nur “ungern” nehmen. Irgendwer eine Idee? ;)</p>
<p><strong>Weiterführende Links und Beispiele:</strong></p>
<p>Auf der Suche nach ein paar guten Beispielen und weiteren Informationen bin ich auf diese Links gestossen, wobei nicht alles geklappt hat – aber vielleicht nützt es dem einen oder anderen etwas:</p>
<p>EXIF Daten auslesen:</p>
<p><a href="http://www.codeproject.com/Articles/47486/Understanding-and-Reading-Exif-Data">Understanding and Reading Exif Data</a></p>
<p><a href="http://igrali.com/2011/11/01/reading-and-displaying-exif-photo-data-on-windows-phone/">Reading and displaying EXIF photo data on Windows Phone</a> (konnte ich nur teilweise auslesen…)</p>
<p><a href="http://stackoverflow.com/questions/13722898/read-exif-data-from-image-on-wp">Read Exif data from Image on WP</a>&nbsp;</p>
<p>Camera:</p>
<p><a href="http://msdn.microsoft.com/en-us/magazine/hh708750.aspx">MSDN: Using Cameras in Your Windows Phone Application</a></p>
<p><a href="http://msdn.microsoft.com/en-us/library/windowsphone/develop/hh202956(v=vs.105).aspx">How to create a base camera app for Windows Phone</a></p>
<p><a href="http://blogs.msdn.com/b/swick/archive/2011/04/07/image-tips-for-windows-phone-7.aspx">Image Tips for Windows Phone 7</a></p>
<p><a href="http://timheuer.com/blog/archive/2010/09/23/working-with-pictures-in-camera-tasks-in-windows-phone-7-orientation-rotation.aspx">Handling picture orientation in CameraCaptureTask in Windows Phone 7</a> (Orientation scheint ziemlich “komplex” zu sein – die Exif Variante ging bei mir nicht)</p>
<p><a href="http://stackoverflow.com/questions/10330959/rotating-an-image-in-windows-phone">Rotating an Image in Windows Phone</a></p>
<p>UI:</p>
<p><a href="http://code.msdn.microsoft.com/wpapps/PhotoHub-Windows-Phone-8-fd7a1093">PhotoHub - Windows Phone 8 XAML LongListSelector Grid Layout sample</a></p>
<p>&nbsp;</p>
<h2></h2>
<h2>Sample Code @ GitHub</h2>
<p><strong></strong>&nbsp;</p>
<p><a href="https://github.com/Code-Inside/Samples/tree/master/2013/PhoneCamSample"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; margin-left: 0px; border-left: 0px; display: inline; margin-right: 0px" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image1805.png" width="284" height="123"></a></p>
