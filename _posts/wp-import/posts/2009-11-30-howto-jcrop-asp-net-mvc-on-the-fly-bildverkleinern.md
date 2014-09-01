---
layout: post
title: "HowTo: jCrop & ASP.NET MVC - On the fly Bildverkleinern"
date: 2009-11-30 01:36
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET, ASP.NET MVC, Crop, jCrop, jQuery, MVC]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image874.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="138" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb59.png" width="142" align="left" border="0"></a> Auf vielen Seiten kann man Profilbilder hinterlegen. Meinstens müssen diese eine bestimmte Größe haben, ansonsten wird das Bild gestaucht oder gezerrt. Beides eher suboptimal. Mit <a href="http://deepliquid.com/projects/Jcrop/demos.php?demo=live_crop">jCrop</a> gibt es ein kleines, nützliches <a href="http://jquery.com/">jQuery Plugin</a>, welches man benutzen kann um bestimmte Ausschnitte aus einem Bild auszuschneiden. jCrop macht dies Client-Seitig und ich möchte das "ausgeschnittene" Bild nun auch in <a href="http://asp.net/mvc">ASP.NET MVC</a> verarbeiten...</p><p><strong>ASP.NET jCrop Control</strong></p> <p>Auf Codeplex gibt es bereits ein <a href="http://webcropimage.codeplex.com/">vorgefertiges ASP.NET Control</a>. Evtl. funktioniert das Control auch in ASP.NET MVC, dies habe ich nicht getestet, da ich den "Cropping" Code bei mir in ein Controller-Action getan habe. Daher schonmal großen <a href="http://cemsisman.com/index.php/asp-net-web-crop-image-control/">Dank an Cem Sisman</a>.</p> <p><strong>Schritt für Schritt:</strong></p> <p><strong>1. Grundlagen</strong></p> <p>- ASP.NET MVC Projekt anlegen<br>- jQuery in der Site.Master hinzufügen<br>- in der Site.Master noch ein ContentPlaceHolder für Javascript hinzufügen (dort kommt der Javascript Teil von jCrop hin).</p> <p><br><strong>2. </strong><a href="http://deepliquid.com/content/Jcrop_Download.html"><strong>jCrop runterladen</strong></a></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image875.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="369" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb60.png" width="195" align="left" border="0"></a> </p> <p>Nun benötigt man ein Bild (ich hab ein Beispielbild von jCrop genommen), die jquery.Jcrop.css Datei und die jquery.JCrop.min.js Javascript Datei.</p> <p>Die Javascript und CSS Datei muss natürlich in der Site.Master noch mit angegeben werden.</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p><strong>5. Der "View" - HTML</strong></p> <p>Wir stellen uns vor, dass Bild wäre schon hochgeladen und wir möchten jetzt ein Ausschnitt auswählen. Dem Benutzer zeigen wir direkt eine kleine Preview an, so wie <a href="http://deepliquid.com/projects/Jcrop/demos.php?demo=thumbnail">hier</a>.</p> <p>Im ersten "p" ist das Originalbild. Im zweiten "p" kommt die Preview hin. Die Styleattribute beim p werden benötigt, da ansonsten das Bild "rausragen würde. So beschränken wir es auf 100px.</p> <p><em>Was macht jCrop eigentlich?</em></p> <p>jCrop zeigt in der Preview nur den ausgewählten Bereich an. Das Ursprungsbild wird hierbei nicht verändern. Stattdessen wir nur der Sichtbereich geändert.</p> <p>Unter "Form Data" kommt für die Verarbeitung dann die wichtigen Daten: X/Y als Startkoordinaten und eine Höhe und Breite. Diese Daten schicken wir per POST an die PostPicture Methode.</p> <p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:86dbb93f-5537-4816-8036-996a1a96f57d" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server"&gt;
    &lt;h2&gt;Crop&lt;/h2&gt;
    
    &lt;p&gt;
        &lt;!-- "Original" --&gt;
        &lt;img id="cropbox" src="&lt;%=Url.Content("~/Content/flowers.jpg") %&gt;" /&gt;
    &lt;/p&gt;
    &lt;p style="width:100px;height:100px;overflow:hidden;"&gt;
        &lt;!-- Crop Preview --&gt;
        &lt;img id="preview" src="&lt;%=Url.Content("~/Content/flowers.jpg") %&gt;" /&gt;
    &lt;/p&gt;
    &lt;p&gt;
        &lt;!-- Form Data --&gt;
        &lt;form action="&lt;%=Url.Action("PostPicture") %&gt;" method="post"&gt;
            &lt;input type="hidden" id="x" name="x" /&gt;
            &lt;input type="hidden" id="y" name="y" /&gt;
            &lt;input type="hidden" id="w" name="w" /&gt;
            &lt;input type="hidden" id="h" name="h" /&gt;
        &lt;button type="submit"&gt;Send&lt;/button&gt;
        &lt;/form&gt;
    &lt;/p&gt;
&lt;/asp:Content&gt;</pre></div></p>
<p><strong>5. Der View - der Javascript Teil</strong></p>
<p>Sobald die Seite geladen wird, werden dem original Bild "Eventhandler" angehangen. Hier kann man auch alle <a href="http://deepliquid.com/content/Jcrop_Manual.html">Optionen</a> die man möchte mit angeben.</p>
<p>In der "showPreview" Funktion wird als Parameter die Koordinaten des gezeichneten Rahmens übergeben. In der if-Abfrage wird das Preview Bild anhand von CSS Eigenschaften "erzeugt" und im letzten Abschnitt werden die 4 Werte in die Inputfelder geschrieben: X,Y,W,H.</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5a679716-d903-4e8c-a5a9-1151edbee97a" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">		&lt;script language="Javascript"&gt;

			// Remember to invoke within jQuery(window).load(...)
			// If you don't, Jcrop may not initialize properly
			jQuery(window).load(function(){

				jQuery('#cropbox').Jcrop({
					onChange: showPreview,
					onSelect: showPreview,
					aspectRatio: 1
				});

			});

			// Our simple event handler, called from onChange and onSelect
			// event handlers, as per the Jcrop invocation above
			function showPreview(coords)
			{
				if (parseInt(coords.w) &gt; 0)
				{
					var rx = 100 / coords.w;
					var ry = 100 / coords.h;

					jQuery('#preview').css({
						width: Math.round(rx * 500) + 'px',
						height: Math.round(ry * 370) + 'px',
						marginLeft: '-' + Math.round(rx * coords.x) + 'px',
						marginTop: '-' + Math.round(ry * coords.y) + 'px'
					});
	            }

	            $('#x').val(coords.x);
	            $('#y').val(coords.y);
	            $('#w').val(coords.w);
	            $('#h').val(coords.h);
			}

		&lt;/script&gt;</pre></div>
<p><strong>6. Der Controller - Crop</strong></p>
<p>Die 4 Werte kommen in die Methode rein. Dann hole ich mir mein Bild, welches in diesem Fall statisch im Code drin steht. Dann erzeuge ich mir ein Rechteck der neuen größe und male das Ursprungsbild mit <a href="http://msdn.microsoft.com/de-de/library/system.drawing.graphics.drawimage(VS.80).aspx">DrawImage</a> auf die neue Fläche.</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:be1b6710-5acc-4012-bdc3-c2856af0ecfa" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        public ImageResult PostPicture(int x, int y, int h, int w)
        {
            Image image = Image.FromFile(Path.Combine(this.Request.PhysicalApplicationPath,"Content/flowers.jpg"));
            Bitmap cropedImage = new Bitmap(w, h, image.PixelFormat);
            Graphics g = Graphics.FromImage(cropedImage);

            Rectangle rec = new Rectangle(0, 0,
                                w,
                                h);

            g.DrawImage(image, rec, x, y, w, h, GraphicsUnit.Pixel);
            image.Dispose();
            g.Dispose();

            return new ImageResult { Image = cropedImage, ImageFormat = ImageFormat.Jpeg }; 
        }</pre></div>
<p><strong>ImageResult? Was ist das denn?</strong></p>
<p>Ich möchte am Ende einfach nur das Bild anzeigen, dabei soll das Bild nicht auf der Platte gespeichert sein. Man könnte es nun <a href="http://www.eggheadcafe.com/PrintSearchContent.asp?LINKID=395">direkt in den Stream</a> schreiben oder man nutzt eine kleine <a href="http://blog.maartenballiauw.be/post/2008/05/ASPNET-MVC-custom-ActionResult.aspx">Hilfsklasse von Maarten Balliauw: Das ImageResult</a>. Das macht die ganze Sache etwas sauberer IMHO. Natürlich kann man auch einen View oder etwas anderes zurückgeben.</p>
<p>ImageResult:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:55476604-28fe-4179-aa63-da151107464e" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public class ImageResult : ActionResult
{
    public ImageResult() { }

    public Image Image { get; set; }
    public ImageFormat ImageFormat { get; set; }

    public override void ExecuteResult(ControllerContext context)
    {
        // verify properties
        if (Image == null)
        {
            throw new ArgumentNullException("Image");
        }
        if (ImageFormat == null)
        {
            throw new ArgumentNullException("ImageFormat");
        }

        // output
        context.HttpContext.Response.Clear();

        if (ImageFormat.Equals(ImageFormat.Bmp)) context.HttpContext.Response.ContentType = "image/bmp";
        if (ImageFormat.Equals(ImageFormat.Gif)) context.HttpContext.Response.ContentType = "image/gif";
        if (ImageFormat.Equals(ImageFormat.Icon)) context.HttpContext.Response.ContentType = "image/vnd.microsoft.icon";
        if (ImageFormat.Equals(ImageFormat.Jpeg)) context.HttpContext.Response.ContentType = "image/jpeg";
        if (ImageFormat.Equals(ImageFormat.Png)) context.HttpContext.Response.ContentType = "image/png";
        if (ImageFormat.Equals(ImageFormat.Tiff)) context.HttpContext.Response.ContentType = "image/tiff";
        if (ImageFormat.Equals(ImageFormat.Wmf)) context.HttpContext.Response.ContentType = "image/wmf";

        Image.Save(context.HttpContext.Response.OutputStream, ImageFormat);
    }
}
</pre></div>
<p><strong>Ergebnis:</strong></p>
<p>Startansicht</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image876.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="374" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb61.png" width="343" border="0"></a> </p>
<p>Einen Teil ausschneiden:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image877.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="393" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb62.png" width="349" border="0"></a> </p>
<p>Nach dem Drücken auf "Send":</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image878.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="161" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb63.png" width="154" border="0"></a> </p>
<p>Wenn man das nun noch mit einen fetzigen <a href="{{BASE_PATH}}/2009/11/02/howto-fileupload-mit-asp-net-mvc/">Uploader</a> verbindet, wird das sogar richtig praktisch ;)</p><strong><a href="{{BASE_PATH}}/assets/files/democode/mvcjcrop/mvcjcrop.zip">[ Download Democode ]</a></strong>
<p><strong>Update: Für VB.NET Entwickler</strong></p>
<p><a href="http://www.daniel-klein.at">Daniel Klein</a> hat den Code im Controller für VB.NET Entwickler umgeschrieben - funktionieren müsste er noch gleich ;)<p>
<pre>
Dim x As Integer
Dim y As Integer
Dim w As Integer
Dim h As Integer

x = Request.Form("x")
y = Request.Form("y")
w = Request.Form("w")
h = Request.Form("h")

Dim image As Image = System.Drawing.Image.FromFile(Path.Combine(Me.Request.PhysicalApplicationPath, "upload/fotoalbum/gross/" + Labelbild.Text))
Dim cropedImage As Bitmap = New Bitmap(w, h, image.PixelFormat)
Dim g As Graphics = Graphics.FromImage(cropedImage)
Dim rec As Rectangle = New Rectangle(0, 0, w, h)
g.InterpolationMode = Drawing2D.InterpolationMode.HighQualityBicubic
g.DrawImage(image, rec, x, y, w, h, GraphicsUnit.Pixel)

cropedImage.Save(Server.MapPath("~/upload/fotoalbum/klein/" + Labelbild.Text), ImageFormat.Jpeg)
</pre>
