---
layout: post
title: "HowTo: Eine eigene ConfigSection schreiben / Custom ConfigSections"
date: 2009-11-03 00:11
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Configs, ConfigSection, Custom, HowTo]
---
{% include JB/setup %}
<a href="{{BASE_PATH}}/assets/wp-images/image864.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; margin: 0px 10px 0px 0px; border-right-width: 0px" height="106" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb49.png" width="140" align="left" border="0"></a>.NET bietet eine recht einfache Möglichkeit Applikations Einstellungen in eine .config zu speichern. Wenn allerdings die Anwendung und damit das "einstellbare" komplexer wird, reicht vielleicht die einfachen <a href="http://msdn.microsoft.com/de-de/library/ms228154(VS.80).aspx">AppSettings</a> nicht aus. In diesem HowTo geht es darum, wie man seine komplett eigenen Custom <a href="http://msdn.microsoft.com/en-us/library/ms228256.aspx">ConfigSections</a> bauen kann. <!--more--> <p>&nbsp;</p> <p><strong>Wie soll unsere Konfiguration am Ende aussehen?</strong></p> <p>Im meinem Beispiel stellen wir uns vor, wir wollen eine Art Konfiguration von einem Blog namens Code-Inside in der .config nach diesem Schema speichern:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:f5037e30-a3f4-4a2d-8515-1f83f9545693" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;codeInsideConfig webUrl="http://code-inside.de" startedOn="2007"&gt;
  &lt;authors&gt;
    &lt;add name="Robert Mühsig"/&gt;
    &lt;add name="Oliver Guhr"/&gt;
    &lt;add name="..."/&gt;
  &lt;/authors&gt;
&lt;/codeInsideConfig&gt;</pre></div>
<p>Der Vorteil gegenüber den normalen <a href="http://code-inside.de/blog/2009/10/01/howto-settings-aus-der-web-config-in-einer-bibliothek-auslesen/">AppSettings</a> ist natürlich, dass man Hierarchien aufbauen kann und dass man im Code auch typsicher sein kann. Wenn man viele Konfigurationen in den AppSettings hat, geht zudem stark der Überblick verloren. </p>
<p><strong>Konfiguration: "Backend"</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image865.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="101" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb50.png" width="244" align="left" border="0"></a> Die Definition der ConfigSection mache ich in einem Klassenbibliotheks-Projekt. Es gibt 3 Teile: Die "CodeInsideConfig", welche den codeInsideConfig Tag beschreibt. Dann die "CodeInsideConfigAuthor" Klasse, welche den Aufbau eines "Authoren" beschreibt und die Collection davon.</p>
<p>Wichtig noch zu Wissen: Die System.Configuration DLL muss mit eingebunden werden.</p>
<p><strong>CodeInsideConfig:</strong></p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:dd9874a1-f521-4529-9ec9-756e5d30eb71" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class CodeInsideConfig : ConfigurationSection
    {
        [ConfigurationProperty("webUrl", DefaultValue = "http://DEFAULT.de", IsRequired = true)]
        public string WebUrl
        {
            get
            {
                return this["webUrl"] as string;
            }
        }

        [ConfigurationProperty("startedOn", IsRequired = false)]
        public int StartedOn
        {
            get
            {
                return (int)this["startedOn"];
            }
        }

        [ConfigurationProperty("authors")]
        public CodeInsideConfigAuthorCollection Authors
        {
            get
            {
                return this["authors"] as CodeInsideConfigAuthorCollection;
            }
        }

        public static CodeInsideConfig GetConfig()
        {
            return ConfigurationSettings.GetConfig("codeInsideConfig") as CodeInsideConfig;
        } 
    }</pre></div>
<p>Abgeleitet wird diese Klasse von <a href="http://msdn.microsoft.com/en-us/library/system.configuration.configurationsection.aspx">ConfigurationSection</a>. Danach folgen zwei ConfigurationProperties:</p>
<ul>
<li>WebUrl</li>
<li>StartedOn</li></ul>
<p>Diesen Properties kann man z.B. noch Defaultvalues mitgeben oder ob diese benötigt sind.</p>
<p>Auf das <a href="http://msdn.microsoft.com/de-de/library/system.configuration.configurationproperty(VS.80).aspx">ConfigurationProperty</a> "Authors" gehe ich gleich ein.</p>
<p>Der letzte Punkt in dieser Klasse ist die statische Methode "GetConfig". Damit kann man später vom "Clientcode" leicht darauf zugreifen ohne jedes mal "ConfigurationSettings.GetConfig('xxx')" schreiben zu müssen.</p>
<p><strong>Die Authors-Collection</strong></p>
<p>Als erstes müssen wir einen "Author" beschreiben - dies passiert in der&nbsp; CodeInsideConfigAuthor Klasse, welche von "<a href="http://msdn.microsoft.com/en-us/library/system.configuration.configurationelement.aspx">ConfigurationElement</a>" abgeleitet ist.</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:59b721fc-4436-413c-8bfb-687ae929cb1e" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class CodeInsideConfigAuthor : ConfigurationElement
    {
        [ConfigurationProperty("name", IsRequired = true)]
        public string Name
        {
            get
            {
                return this["name"] as string;
            }
        }

    } </pre></div>
<p>Hier wird nach dem gleichen Schema wie bei dem Oberelement verfahren.</p>
<p>Nun müssen wir noch die Collection definieren:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e70ae73d-9ebb-4cbc-9036-051f00ea5cf0" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class CodeInsideConfigAuthorCollection : ConfigurationElementCollection
    {
        public CodeInsideConfigAuthor this[int index]
        {
            get
            {
                return base.BaseGet(index) as CodeInsideConfigAuthor;
            }
            set
            {
                if (base.BaseGet(index) != null)
                {
                    base.BaseRemoveAt(index);
                }
                this.BaseAdd(index, value);
            }
        }

        protected override ConfigurationElement CreateNewElement()
        {
            return new CodeInsideConfigAuthor();
        }

        protected override object GetElementKey(ConfigurationElement element)
        {
            return ((CodeInsideConfigAuthor)element).Name;
        } 
    }</pre></div>
<p>Diese Klasse ist abgeleitet von <a href="http://msdn.microsoft.com/en-us/library/system.configuration.configurationelementcollection.aspx">ConfigurationElementCollection</a>. Wie der Name verrät speichert Sie eine Abfolge von Elementen. </p>
<p>Diese Collection nun haben wir als dritte Property in unserer CodeInsideConfig aufgenommen.</p>
<p><strong>Die Konfiguration jetzt nutzen...</strong></p>
<p>In der Web.Config fügen wir nun unsere ConfigSection hinzu:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b0d7ff83-7bca-42ab-90f5-9fb616346e29" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">	&lt;configSections&gt;
		...
		&lt;section name="codeInsideConfig" type="YourOwnConfigSection.Infrastructure.CodeInsideConfig"/&gt;
	&lt;/configSections&gt;</pre></div>
<p><em><a href="http://code-inside.de/blog/2009/10/04/howto-full-qualified-type-name-klassentypnamen-richtig-schreiben/">(Infos zur Type Bezeichnung)</a></em></p>
<p>Nun können wir einfach unsere codeInsideConfig in die Web.config schreiben.</p>
<p><strong>Zugriff auf die Konfiguration</strong></p>
<p>Man kann nun entweder immer über "ConfigurationSettings.GetConfig('CONFIGNAME')" zugreifen und dann in den entsprechenden Typ casten oder man nutzt z.B. solch eine statische Methode.</p>
<p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:9082aa87-3bcf-4392-977f-14cfdcc6e8f1" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">            CodeInsideConfig config = CodeInsideConfig.GetConfig();
            ViewData["webUrl"] = config.WebUrl;
            ViewData["startedOn"] = config.StartedOn;

            string authors = "";
            foreach (CodeInsideConfigAuthor author in config.Authors)
            {
                authors += author.Name + ",";    
            }

            ViewData["authors"] = authors;</pre></div></p>
<p><strong>Ergebnis:</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image866.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="139" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb51.png" width="244" border="0"></a> </p>
<p><strong>Konfigurationen aus der Web.Config auslagern</strong></p>
<p>Was mit den normalen Settings geht, geht natürlich auch mit den Custom Settings: Man kann die Konfiguration in eine externe Datei auslagern:</p>
<p>In der Web.config:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c05b04f0-06b2-44cd-bf14-500985b5815a" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">	&lt;configSections&gt;
		...
		&lt;section name="codeInsideConfig" type="YourOwnConfigSection.Infrastructure.CodeInsideConfig"/&gt;
	&lt;/configSections&gt;
  &lt;codeInsideConfig configSource="CodeInside.config" /&gt;</pre></div>
<p>In der CodeInside.config:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:0eb6c7fa-f057-415a-a11c-f3c5e585f5be" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;?xml version="1.0" encoding="utf-8" ?&gt;
&lt;codeInsideConfig webUrl="http://code-inside.de" startedOn="2007"&gt;
  &lt;authors&gt;
    &lt;add name="Robert Mühsig"/&gt;
    &lt;add name="Oliver Guhr"/&gt;
    &lt;add name="..."/&gt;
  &lt;/authors&gt;
&lt;/codeInsideConfig&gt;</pre></div>
<p><strong>Fazit:</strong></p>
<p>Wenn man eine etwas komplexere Anwendung mit einigen Einstellungen hat, kann es sich lohnen eine eigene Custom Section zu schreiben. Dies macht nicht so viel Arbeit wie man erst denkt und man kann seine Einstellungen nach seinen Wünschen gruppieren.</p>
<p>Meine Inspiration kam von <a href="http://aspnet.4guysfromrolla.com/articles/032807-1.aspx">dieser Seite.</a></p>
<p><strong><a href="http://{{BASE_PATH}}/assets/files/democode/yourownconfigsection/yourownconfigsection.zip">[ Download Democode ]</a></strong></p>
