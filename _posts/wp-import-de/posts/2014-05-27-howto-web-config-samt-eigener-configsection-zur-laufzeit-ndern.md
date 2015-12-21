---
layout: post
title: "HowTo: Web.config samt eigener ConfigSection zur Laufzeit ändern"
date: 2014-05-27 22:18
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET, HowTo]
language: de
---
{% include JB/setup %}
<p>In dem HowTo geht es darum wie man die Web.config zur Laufzeit ändert und was es dabei zu beachten gilt. Das ganze klappt auch mit komplexeren ConfigSections. </p> <h3>Eigene ConfigSection?</h3> <p>Vor einer ganzen Weile habe ich mal <a href="http://blog.codeinside.eu/2009/11/03/howto-eine-eigene-configsection-schreiben-custom-configsections/">über das Erstellen einer eigenen ConfigSection</a> geschrieben – im Grunde nutzen wir jetzt fast dieselbe Config.</p> <h3>Zur Laufzeit? Startet da die Webapplikation nicht neu?</h3> <p>Im Grunde ist das auch richtig. Ändert man die web.config wird die Applikation neugestartet. Allerdings läuft der Request der zur Änderung geführt hat noch durch. Ich würde aber nicht empfehlen solch eine Änderung häufiger zu machen, sondern beim Aufsetzen der Webanwendung etc. Aber im Grunde funktioniert es auch ziemlich gut ;)</p> <h3></h3> <h3>Zum Code</h3> <p>Die Definition der ConfigSection:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">    public class CodeInsideConfig : ConfigurationSection
    {
        [ConfigurationProperty("webUrl", DefaultValue = "http://DEFAULT.de", IsRequired = true)]
        public string WebUrl
        {
            get
            {
                return this["webUrl"] as string;
            }
        }

        [ConfigurationProperty("id", IsRequired = false)]
        public Guid Id
        {
            get { return (Guid)this["id"]; }
            set { this["id"] = value; }

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

        public static Configuration GetWritableBaseConfig()
        {
            return WebConfigurationManager.OpenWebConfiguration("~");

        }
    }

    public class CodeInsideConfigAuthorCollection : ConfigurationElementCollection
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

        public void Add(CodeInsideConfigAuthor appElement)
        {
            BaseAdd(appElement);

        }

        protected override ConfigurationElement CreateNewElement()
        {
            return new CodeInsideConfigAuthor();
        }

        protected override object GetElementKey(ConfigurationElement element)
        {
            return ((CodeInsideConfigAuthor)element).Name;
        }
    }

    public class CodeInsideConfigAuthor : ConfigurationElement
    {
        [ConfigurationProperty("name", IsRequired = true)]
        public string Name
        {
            get { return this["name"] as string; }
            set { this["name"] = value; }
        }

    }</pre>
<p>Anders als im ursprünglichem Blogpost haben die einzelnen ConfigurationElements auch not Setter und die Collection hat noch eine <a href="http://msdn.microsoft.com/en-us/library/19tyhxbx(v=vs.110).aspx">BaseAdd</a> Methode (welche als Protected Method in der Basisklasse vorhanden ist). Die ConfigSection muss natürlich auch in der Web.config bekannt sein:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">  &lt;configSections&gt;
    &lt;section name="codeInsideConfig" type="UpdatableWebConfig.CodeInsideConfig"/&gt;
  &lt;/configSections&gt;</pre>
<p><strong>Zur Anwendung des Codes…</strong></p>
<p>Das Ganze ist jetzt in einer Standard MVC Applikation im HomeController eingebunden:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">        public ActionResult Index()
        {
            var config = CodeInsideConfig.GetConfig();

            ViewBag.Url = config.WebUrl;
            ViewBag.Id = config.Id;

            ViewBag.NumberOfAuthors = config.Authors.Count;

            return View();
        }

        public ActionResult About()
        {
            var config = CodeInsideConfig.GetWritableBaseConfig();

            var writableConfigSection = config.GetSection("codeInsideConfig") as CodeInsideConfig;
            writableConfigSection.Id = Guid.NewGuid();
            writableConfigSection.Authors.Add(new CodeInsideConfigAuthor() { Name = "Hello World!" + Guid.NewGuid() });

            try
            {
                config.Save();
                return RedirectToAction("Index", "Home");
            }
            catch (ConfigurationErrorsException exc)
            {
                throw;
            }
        }
</pre>
<p>Im Index() wird nur gelesen und im About() werden neue Werte eingetragen. </p>
<h4></h4>
<h3>Erklärung:</h3>
<p><a href="http://msdn.microsoft.com/en-us/library/system.configuration.configurationmanager.getsection.aspx">ConfigurationSettings.GetConfig(…)</a> gibt immer nur lesenden Zugriff auf die Web.config Einträge. <br>Zum Schreiben benötigt man den Zugriff über den <a href="http://msdn.microsoft.com/en-us/library/ms151456(v=vs.110).aspx">WebConfigurationManager</a>. Danach kann man auch <a href="http://msdn.microsoft.com/en-us/library/ms134087(v=vs.110).aspx">Save</a> aufrufen. Danach wird auch direkt die Config aktualisiert und nachdem der Request durch ist wird auch die Webapplikation neugestartet.</p>
<p>Bei Fehlern kann evtl. eine ConfigurationErrorsException auftreten, daher der “tote” Code im Beispiel. </p>
<p>Den gesamten <a href="https://github.com/Code-Inside/Samples/tree/master/2014/UpdatableWebConfig"><strong>Code gibts auch auf GitHub</strong></a>.</p>
