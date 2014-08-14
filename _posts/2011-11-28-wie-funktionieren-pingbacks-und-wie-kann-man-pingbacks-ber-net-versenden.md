---
layout: post
title: "Wie funktionieren Pingbacks und wie kann man Pingbacks über .NET versenden?"
date: 2011-11-28 22:48
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, Pingback, XMLRPC]
---
{% include JB/setup %}
<p>Ganz technisch gesprochen: Pingbacks dienen der Benachrichtigung einer Seite, wenn diese auf einer anderen Seite verlinkt wird. Größtes (und einzigstes?) Einsatzgebiet ist in der Blogwelt zu finden. Ziel davon ist es, dass ein Autor benachrichtigt wird, wenn jemand über einen Artikel etwas schreibt. Meistens landet der <a href="http://de.wikipedia.org/wiki/Pingback">Pingback</a> mit in den Kommentaren.</p> <p>Eine ältere Form davon sind die “<a href="http://de.wikipedia.org/wiki/Trackback">Trackbacks</a>”, allerdings sind diese scheinbar etwas aus der Mode gekommen. <a href="http://blog.akismet.com/2010/04/22/state-of-web-spam/">Hier</a> ein Beispiel aus der Praxis (auf die Spam Thematik gehen wir dann noch ein)</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1414.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb592.png" width="495" height="514"></a></p> <p><strong>Die Spezifikation &amp; Konzept der Pingbacks</strong></p> <p>Auf <a href="http://www.hixie.ch/specs/pingback/pingback">dieser Seite</a> gibt es die Spezifikation der Pingbacks zum Nachlesen. Pingbacks müssen vom “Pingback Empfänger” auch unterstützt werden. </p> <p>Um die Sache einfacher zu Erklären hier ein Beispiel: Ich hab einen Artikel auf code-inside.de verfasst und jemand anderes schreibt über diesen Artikel und verlinkt diesen. Im Hintergrund der Blogengine (oder des “Quell-Systems”) läuft dann ungefähr folgendes Schema ab:</p> <p>Zuerst wird geprüft ob die Zielseite Pingbacks unterstützt:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1415.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb593.png" width="506" height="114"></a></p> <p>Hierbei wird einfach nur ein GET-Webrequest zum Ziel gemacht ohne besondere Parameter.</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1416.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb594.png" width="504" height="113"></a></p> <p>Als Antwort muss im Header <strong>X-Pingback</strong> angegeben sein – wenn nicht, dann unterstützt das Ziel keinen Pingback-Mechanismus.</p> <p>&nbsp;</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1417.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb595.png" width="504" height="430"></a></p> <p>Nun wird der eigentliche Pingback zur XMLRPC Schnittstelle geschickt. Dabei wird die URL aus dem Header genommen und ein XMLRPC Aufruf gemacht, welches so ein XML beinhaltet:</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:0ae8f69e-e271-43d1-8e6e-cf031aeaa1e1" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;?xml version="1.0" encoding="utf-16" standalone="yes"?&gt;
&lt;methodCall&gt;
	&lt;methodName&gt;pingback.ping&lt;/methodName&gt;
	&lt;params&gt;
		&lt;param&gt;
			&lt;value&gt;&lt;string&gt;http://www.bizzbingo.com/what-is/ravendb&lt;/string&gt;&lt;/value&gt;
		&lt;/param&gt;
		&lt;param&gt;
			&lt;value&gt;&lt;string&gt;http://code-inside.de/blog-in/2011/11/05/use-ravendb-as-embedded-filebase/&lt;/string&gt;&lt;/value&gt;
		&lt;/param&gt;
	&lt;/params&gt;
&lt;/methodCall&gt;</pre></div>
<p>&nbsp;</p>
<p><strong>Überprüfung auf der Zielseite</strong></p>
<p>Das Ziel (in meinem Beispiel also mein Blog), überprüft nun die Herkunft und ob diese Seite auch wirklich diesen Artikel verlinkt (ansonsten gibt es eine Fehlermeldung). Die Zielseite sucht sich dann (scheinbar) selbstständig ein Auszug von dem Aufrufer. </p>
<p><strong>Pingbacks in .NET</strong></p>
<p>Der Code stammt zu fast 100% aus dem <a href="http://blogengine.codeplex.com/releases/view/69117">Blogengine.NET Projekt</a>, da ich selber erst nicht durch die Spezifikation durchgesehen hatte :)</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:9a2a4647-e9e6-4152-a435-58f095cce734" class="wlWriterEditableSmartContent"><pre name="code" class="c">namespace pingback.webapp.Controllers
{
    using System;
    using System.IO;
    using System.Net;
    using System.Text;
    using System.Xml;

    /// &lt;summary&gt;
    /// Sends pingbacks to website that the blog links to.
    /// &lt;/summary&gt;
    public static class Pingback
    {
        #region Events

        /// &lt;summary&gt;
        ///     Occurs just before a pingback is sent.
        /// &lt;/summary&gt;
        public static event EventHandler&lt;EventArgs&gt; Sending;

        /// &lt;summary&gt;
        ///     Occurs when a pingback has been sent
        /// &lt;/summary&gt;
        public static event EventHandler&lt;EventArgs&gt; Sent;

        #endregion

        #region Public Methods

        /// &lt;summary&gt;
        /// Sends pingbacks to the targetUrl.
        /// &lt;/summary&gt;
        /// &lt;param name="sourceUrl"&gt;
        /// The source Url.
        /// &lt;/param&gt;
        /// &lt;param name="targetUrl"&gt;
        /// The target Url.
        /// &lt;/param&gt;
        public static void Send(Uri sourceUrl, Uri targetUrl)
        {
            if (sourceUrl == null || targetUrl == null)
            {
                return;
            }

            try
            {
                var request = (HttpWebRequest)WebRequest.Create(targetUrl);
                request.Credentials = CredentialCache.DefaultNetworkCredentials;
                var response = (HttpWebResponse)request.GetResponse();
                string pingUrl = null;

                var pingUrlKeyIndex = Array.FindIndex(
                    response.Headers.AllKeys,
                    delegate(string k)
                        {
                            return k.Equals("x-pingback", StringComparison.OrdinalIgnoreCase) ||
                                   k.Equals("pingback", StringComparison.OrdinalIgnoreCase);
                        });

                if (pingUrlKeyIndex != -1)
                {
                    pingUrl = response.Headers[pingUrlKeyIndex];
                }

                Uri url;
                if (!string.IsNullOrEmpty(pingUrl) &amp;&amp; Uri.TryCreate(pingUrl, UriKind.Absolute, out url))
                {
                    OnSending(url);
                    request = (HttpWebRequest)WebRequest.Create(url);
                    request.Method = "POST";

                    // request.Timeout = 10000;
                    request.ContentType = "text/xml";
                    request.ProtocolVersion = HttpVersion.Version11;
                    request.Headers["Accept-Language"] = "en-us";
                    AddXmlToRequest(sourceUrl, targetUrl, request);
                    var response2 = (HttpWebResponse)request.GetResponse();

                    string answer;
                    using (var sr = new StreamReader(response2.GetResponseStream()))
                    {
                        answer = sr.ReadToEnd();
                    }

                    response2.Close();

                    OnSent(url);
                }
            }
            catch (Exception ex)
            {
                ex = new Exception();

                // Stops unhandled exceptions that can cause the app pool to recycle
            }
        }

        #endregion

        #region Methods

        /// &lt;summary&gt;
        /// Adds the XML to web request. The XML is the standard
        ///     XML used by RPC-XML requests.
        /// &lt;/summary&gt;
        /// &lt;param name="sourceUrl"&gt;
        /// The source Url.
        /// &lt;/param&gt;
        /// &lt;param name="targetUrl"&gt;
        /// The target Url.
        /// &lt;/param&gt;
        /// &lt;param name="webreqPing"&gt;
        /// The webreq Ping.
        /// &lt;/param&gt;
        private static void AddXmlToRequest(Uri sourceUrl, Uri targetUrl, HttpWebRequest webreqPing)
        {
            var stream = webreqPing.GetRequestStream();
            using (var writer = new XmlTextWriter(stream, Encoding.ASCII))
            {
                writer.WriteStartDocument(true);
                writer.WriteStartElement("methodCall");
                writer.WriteElementString("methodName", "pingback.ping");
                writer.WriteStartElement("params");

                writer.WriteStartElement("param");
                writer.WriteStartElement("value");
                writer.WriteElementString("string", sourceUrl.ToString());
                writer.WriteEndElement();
                writer.WriteEndElement();

                writer.WriteStartElement("param");
                writer.WriteStartElement("value");
                writer.WriteElementString("string", targetUrl.ToString());
                writer.WriteEndElement();
                writer.WriteEndElement();
                

                writer.WriteEndElement();
                writer.WriteEndElement();
            }
        }

        /// &lt;summary&gt;
        /// Called when [sending].
        /// &lt;/summary&gt;
        /// &lt;param name="url"&gt;The URL Uri.&lt;/param&gt;
        private static void OnSending(Uri url)
        {
            if (Sending != null)
            {
                Sending(url, new EventArgs());
            }
        }

        /// &lt;summary&gt;
        /// Called when [sent].
        /// &lt;/summary&gt;
        /// &lt;param name="url"&gt;The URL Uri.&lt;/param&gt;
        private static void OnSent(Uri url)
        {
            if (Sent != null)
            {
                Sent(url, new EventArgs());
            }
        }

        #endregion
    }
}</pre></div>
<p>&nbsp;</p>
<p>Die Anwendung ist auch recht einfach:</p>
<p>&nbsp;</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:792eb02d-d6f6-413b-a473-2a758df7247f" class="wlWriterEditableSmartContent"><pre name="code" class="c#">            // source must be available from the target url (e.g. localhost doesn´t work)
            string source = "http://www.bizzbingo.com/what-is/ravendb";

            // source must contain the target link... otherwise: Error.
            string target = "http://code-inside.de/blog-in/2011/11/05/use-ravendb-as-embedded-filebase/";
            Pingback.Send(new Uri(source), new Uri(target));</pre></div>
<p>&nbsp;</p>





<p><strong>Die Response:</strong></p>
<p>Je nachdem ob alles gut gegangen ist oder nicht, gibt die aufgerufenen Seite auch eine Antwort. Die kann z.B. im Fehlerfall so aussehen:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a7911f6d-c347-484d-bca1-cadb7fb494e7" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;?xml version="1.0"?&gt;
&lt;methodResponse&gt;
  &lt;fault&gt;
    &lt;value&gt;
      &lt;struct&gt;
        &lt;member&gt;
          &lt;name&gt;faultCode&lt;/name&gt;
          &lt;value&gt;&lt;int&gt;17&lt;/int&gt;&lt;/value&gt;
        &lt;/member&gt;
        &lt;member&gt;
          &lt;name&gt;faultString&lt;/name&gt;
          &lt;value&gt;&lt;string&gt;The source URL does not contain a link to the target URL, and so cannot be used as a source.&lt;/string&gt;&lt;/value&gt;
        &lt;/member&gt;
      &lt;/struct&gt;
    &lt;/value&gt;
  &lt;/fault&gt;
&lt;/methodResponse&gt;
</pre></div>
<p><strong></strong>&nbsp;</p>
<p>Oder im besten Fall so:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d6dc63a9-fe42-4da9-a1ab-e19e3a9e4d1a" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;?xml version="1.0"?&gt;
&lt;methodResponse&gt;
  &lt;params&gt;
    &lt;param&gt;
      &lt;value&gt;
      &lt;string&gt;Pingback from http://www.bizzbingo.com/what-is/ravendb to http://code-inside.de/blog-in/2011/11/05/use-ravendb-as-embedded-filebase/ registered. Keep the web talking! :-)&lt;/string&gt;
      &lt;/value&gt;
    &lt;/param&gt;
  &lt;/params&gt;
&lt;/methodResponse&gt;
</pre></div>
<p>&nbsp;</p>
<p>Die Fehlercodes finden sich auch in der <a href="http://www.hixie.ch/specs/pingback/pingback">Spezifikation</a> wieder.</p>
<p><strong> P</strong><strong>roblematisch: Spam</strong></p>
<p>Pingbacks sind vom Prinzip her eine gute Sache, können allerdings leicht ausgenutzt werden, daher werden Sie entweder durch Blogspam-Filter (wie <a href="http://akismet.com/">Akismet</a>) herausgefiltert oder gar nicht mehr angezeigt. Spammer nutzen gerne diese Schnittstelle um Links auf allen möglichen Seiten abzulegen. Mein Blogtemplate z.B. zeigt keine Pingbacks an. Vermutlich muss die Quelle erst einen gewissen Grad an Reputation haben um nicht mehr als Spam für <a href="http://blog.akismet.com/2010/04/22/state-of-web-spam/">Akismet &amp; co.</a> zu gelten. </p>
<p><a href="http://code.google.com/p/code-inside/source/browse/#git%2F2011%2Fpingback"><strong>[ Code @ Google Code ]</strong></a></p>
