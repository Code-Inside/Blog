---
layout: post
title: "Prototyp für Google+ ähnliches Feedback-Modul mit Html2Canvas–Screenshots mit Javascript"
date: 2011-07-27 00:12
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [Canvas, File, HTML5, Javascript, Upload]
language: de
---
{% include JB/setup %}
<p>Häufig gibt es das Problem, dass man als Entwickler nicht wirklich weiß, was der Benutzer sieht. Die Google+ Entwickler haben daher ein schickes Feedback-Modul integriert, indem man selber ein Bereich der Seite markieren kann und dies als Screenshot zu Google schicken kann. Sowohl für den Benutzer als auch für den Entwickler hinterher ist das ein echter Usability Gewinn.</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1303.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb485.png" width="509" height="343"></a></p> <p>Heute bin ich durch Zufall auf ein Javascript-Framework gestoßen, welche das HTML in ein Canvas packt. Das ganze nennt sich <a href="http://html2canvas.hertzen.com/"><strong>Html2Canvas</strong></a> und ist noch experimentell und hat einige Einschränkungen, funktioniert aber mit einigen Seiten. Hier die <a href="http://html2canvas.hertzen.com/screenshots.html"><strong>Testkonsole</strong></a>:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1304.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb486.png" width="408" height="275"></a></p> <p><strong>Wichtig:</strong> Hierbei werden die Bilder clientseitig erzeugt, anders als z.B. über <a href="{{BASE_PATH}}/2008/09/10/howto-dynamisch-webseiten-screenshots-erzeugen/">diese Variante</a> welche das Bild “serverseitig” erzeugt. </p> <p>Kleiner Wermutstropfen: Es wird natürlich kein echter Screenshot gemacht, sondern es wird anhand der DOM ein Abbild geschaffen. Mehr dazu kann man auf der <a href="http://html2canvas.hertzen.com/">Entwicklerseite nachlesen</a>. Natürlich funktioniert Html2Canvas auch nur, wenn der Browser das Canvas Element unterstützt.</p> <p>Da ich bislang noch nie was mit dem Canvas Element gemacht habe, fand ich aber das Google+ Feedback-Modul ein interessantes Szenario.</p> <p><strong>Das Canvas als Image umwandeln und zum Server posten</strong></p> <p>Ich hab also die Demoseite etwas angepasst und in eine ASP.NET MVC Anwendung integriert und ein Upload-Button hinzugefügt (und das Script ein wenig angepasst und das Canvas mit einer ID ausgestattet).</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1305.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb487.png" width="589" height="211"></a></p> <p> Das HTML Canvas Objekt verfügt eine Javascript-Methode um es in base64 umzuwandeln (entscheidender Tipp kam von <a href="http://stackoverflow.com/questions/1590965/uploading-canvas-image-data-to-the-server">hier</a>). Über AJAX wird nun dieses base64 Bild an den Controller gesendet. Über die zusätzlichen Url.Action Parameter erzwinge ich nur, dass die vollstänige URL gerendert wird, weil das Javascript vom Html2Canvas die Location der Seite “vermurkst”.</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:04758621-6451-482b-ae3a-bc743668e552" class="wlWriterEditableSmartContent"><pre name="code" class="c#">            function upload() {
                var canvas = $("#CanvasTest").get(0).toDataURL('image/jpeg');
                
                $.post('@Url.Action("Upload", "Home", null, "http")',
                    {
                        img: canvas
                    });
            }</pre></div>
<p>&nbsp;</p>
<p>Da hier nicht der reguläre Fileupload genutzt wird und ich deswegen <a href="{{BASE_PATH}}/2009/11/02/howto-fileupload-mit-asp-net-mvc/">nicht das HttpPostedFileBase nutzen</a> kann, muss ich manuell das Bild aus den Form Daten holen und speichern.</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:75ff3e06-1eb0-470b-b88b-dc84a0f463f3" class="wlWriterEditableSmartContent"><pre name="code" class="c#">        public ActionResult Upload()
        {
            string fullString = this.Request.Form["img"];
            var base64 = fullString.Substring(fullString.IndexOf(",") + 1);
            byte[] b;
            b = Convert.FromBase64String(base64);

            MemoryStream ms = new System.IO.MemoryStream(b);

            Image img = System.Drawing.Image.FromStream(ms);


            img.Save(Path.Combine(
              AppDomain.CurrentDomain.BaseDirectory, Guid.NewGuid().ToString() + ".jpg"), System.Drawing.Imaging.ImageFormat.Jpeg);

            return RedirectToAction("Index");
        }</pre></div>
<p>&nbsp;</p>
<p>Das Resultat ist doch schon mal nett:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1306.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb488.png" width="244" height="129"></a></p>
<p>Allerdings wird meine Seite nicht richtig gerendert, aber immerhin fast <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images/wlEmoticon-winkingsmile7.png"></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1307.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb489.png" width="420" height="332"></a></p>
<p>Die Bilder werden im Verzeichnis der Anwendung abgespeichert.</p>
<p><strong>Gelernte Dinge:</strong></p>
<p>- Html2Canvas ist eine spannendes Projekt</p>
<p>- Ein Canvas kann man leicht zum Server posten</p>
<p>- Ich hab mal wieder was über <a href="http://forums.asp.net/p/1679283/4524525.aspx/1?Re+Convert+base64+to+image+">base64 codierte Bilder gelernt</a>. </p>
<p>Mit dem Canvas kann man natürlich <a href="http://www.youtube.com/watch?v=wbSoSCStodA">noch viel mehr machen</a>, sodass es wirklich Google+ ähnlich wird. </p>
<p>Wie bereits im Titel gesagt: Es ist nur ein Prototyp <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images/wlEmoticon-winkingsmile7.png"></p>
<p><strong><a title="Download Democode" href="{{BASE_PATH}}/assets/files/democode/html2canvas/html2canvas.zip">[ Download Democode ]</a></strong></p>
