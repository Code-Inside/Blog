---
layout: post
title: "Windows Phone 8: Async in Json-File schreiben & lesen"
date: 2013-08-05 23:09
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Async, HowTo, JSON.NET, Windows Phone 8]
language: de
---
{% include JB/setup %}
<p>Man kommt immer recht schnell zu dem Punkt an dem man “irgendeinen” Datenspeicher brauch. Da ein normale normale Text-Datei meist zu wenig bietet und Sqlite auf den ersten Blick auch nicht gerade “schlank” ist nehmen wir einfach eine JSON-Datei.</p> <h3>Trivale Beispielstruktur:</h3> <p>Wir möchten in der Demo-Anwendung einfach eine Liste von diesen Objekten speichern:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">    public class Data
    {
        public Guid Id { get; set; }
        public string Value { get; set; }
    }</pre>
<p>&nbsp;</p>
<p>Über diese “API” erzeugen wir einen neuen Datensatz, lesen die komplette Liste aus, hängen das neue Element dran und speichern es erneut. Vermutlich gibt es effizientere Wege dies zu machen – allerdings ist mir im ersten Moment keine einfachere Lösung eingefallen:</p>
<p></p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">private async Task&lt;List&lt;Data&gt;&gt; CreateNewEntry()
        {
            Data demo = new Data();
            demo.Id = Guid.NewGuid();
            demo.Value = Guid.NewGuid().ToString();

            var existing = await Load();

            if (existing == null)
            {
                existing = new List&lt;Data&gt;();
            }

            existing.Add(demo);

            await Save(existing);

            return existing;
        }</pre>
<h3>JSON.NET, async &amp; Streams </h3>
<p>Um die Daten zu schreiben und zu lesen bedienen wir uns der <a href="http://mobile.dzone.com/articles/windows-phone-8-shared-core">“WinRT”-angehauchten APIs von Windows Phone 8</a> und eine Menge async &amp; await Code und <a href="http://james.newtonking.com/archive/2009/02/14/writing-json-to-a-file-using-json-net.aspx">zu guter Letzt JSON.NET</a>:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">private async Task Save(List&lt;Data&gt; data)
        {
            IStorageFolder applicationFolder = ApplicationData.Current.LocalFolder;

            IStorageFolder storageFolder = await applicationFolder.CreateFolderAsync("data", CreationCollisionOption.OpenIfExists);

            string fileName = "data.json";

            IStorageFile storageFile = await storageFolder.CreateFileAsync(fileName, CreationCollisionOption.OpenIfExists);

            using (Stream stream = await storageFile.OpenStreamForWriteAsync())
            using (var sw = new StreamWriter(stream))
            using (JsonWriter jw = new JsonTextWriter(sw))
            {
                jw.Formatting = Formatting.Indented;

                JsonSerializer serializer = new JsonSerializer();
                serializer.Serialize(jw, data);
                await stream.FlushAsync();
            }
        }

        private async Task&lt;List&lt;Data&gt;&gt; Load()
        {
            IStorageFolder applicationFolder = ApplicationData.Current.LocalFolder;

            IStorageFolder storageFolder = await applicationFolder.CreateFolderAsync("data", CreationCollisionOption.OpenIfExists);

            string fileName = "data.json";

            IStorageFile storageFile = await storageFolder.CreateFileAsync(fileName, CreationCollisionOption.OpenIfExists);

            using (Stream stream = await storageFile.OpenStreamForReadAsync())
            using (var sr = new StreamReader(stream))
            using (JsonReader jr = new JsonTextReader(sr))
            {
                JsonSerializer serializer = new JsonSerializer();
                var result = serializer.Deserialize&lt;List&lt;Data&gt;&gt;(jr);
                
                return result;
            }
        }</pre>
<h3>“Access Denied Exception” – UI trotz async “sperren”</h3>
<p>Die Aktion wird über einen Button-Click angestossen. Trotz der ganzen Asynchronität muss man trotzdem darauf achten dass im Grunde nur ein Thread die Methode aufruft – andernfalls kann es zu “Access Denied Exceptions” führen. Der einfachste Weg dies zu bewerkstelligen ist dieser:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">        private async void Button_Click(object sender, RoutedEventArgs e)
        {
            CreateNewEntryButton.IsEnabled = false;
            try
            {
                var result = await CreateNewEntry();
            }
            finally
            {
                CreateNewEntryButton.IsEnabled = true;
            }
        }
</pre>
<p>Die UI bleibt allerdings trotzdem völlig reaktionsfähig – man verhindert aber das zwei verschiedene Threads auf die Datei zugreifen.</p>
<p>Eine tolle Session zum Thema <a href="http://channel9.msdn.com/Events/Build/2013/3-301">“Async” gab es auch auf der Build 2013</a> – auch dort wurde diese Methode angewandt, daher gehe ich mal davon aus, dass dies “in Ordnung” ist.</p>
<h3></h3>
<h3>Ergebnis</h3>
<p>Mit diesen Mitteln kann man recht einfach und “stabil" (aktuell konnte ich noch kein Problem feststellen ;)) seine Daten in eine JSON-Datei schreiben und wieder auslesen. Der Code sollte auch für das “normale” WinRT lauffähig sein.</p>
<p>Ich habe selbst immer einen grossen Respekt vor Datei-Operationen und das Async ist mir leider noch nicht so vertraut – daher: Wer Verbesserungsvorschläge hat – immer her damit :)</p>
<h4>Download auf GitHub</h4>
<p>Das gesamte Projekt gibt es auf <a href="https://github.com/Code-Inside/Samples/tree/master/2013/Wp8AndJson">GitHub</a>. </p>
