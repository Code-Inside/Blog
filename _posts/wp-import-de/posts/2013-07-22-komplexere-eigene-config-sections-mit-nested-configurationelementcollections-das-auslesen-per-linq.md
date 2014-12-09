---
layout: post
title: "Komplexere eigene Config-Sections mit Nested-ConfigurationElementCollections & das Auslesen per LINQ"
date: 2013-07-22 23:25
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Config, ConfigSection, HowTo]
language: de
---
{% include JB/setup %}
<p>Ein (Ur)-altes Thema, aber trotzdem braucht man es immer mal wieder: </p> <p>Wer eine Applikation mit komplexeren Konfigurationsmöglichkeiten baut stößt mit dem Key/Value Standard-System schnell an die Grenze. Vor 4 Jahren hatte ich bereits über das <a href="{{BASE_PATH}}/2009/11/03/howto-eine-eigene-configsection-schreiben-custom-configsections/">Thema gebloggt</a>.</p> <p>In dem Blogpost erweitere ich das Beispiel noch etwas und zeige wie man in einer Collection eine andere Collection hinterlegen kann. So kann man seine Konfiguration beliebig tief verschachteln. </p> <h3>Demo Config:</h3><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">  &lt;codeInsideConfig webUrl="http://code-inside.de" startedOn="2007"&gt;
    &lt;authors&gt;
      &lt;author name="Robert Mühsig"&gt;
        &lt;topics&gt;
          &lt;add name="Foobar 1" /&gt;
          &lt;add name="Foobar 2" /&gt;
          &lt;add name="Foobar 3" /&gt;
          &lt;add name="Buzz 1" /&gt;
          &lt;add name="Buzz 2" /&gt;
          &lt;add name="Buzz 3" /&gt;
        &lt;/topics&gt;
      &lt;/author&gt;
      &lt;author name="Oliver Guhr"&gt;
        &lt;topics&gt;
          &lt;add name="Foobar 1" /&gt;
          &lt;add name="Foobar 2" /&gt;
          &lt;add name="Foobar 3" /&gt;
          &lt;add name="Buzz 1" /&gt;
          &lt;add name="Buzz 2" /&gt;
          &lt;add name="Buzz 3" /&gt;
        &lt;/topics&gt;
      &lt;/author&gt;
    &lt;/authors&gt;
  &lt;/codeInsideConfig&gt;</pre>
<h3>Nested ConfigurationElementCollection:</h3>
<p>Rein von der Struktur her haben wir “codeInsideConfig” - “authors” - “author” - “topics” - “topic”. In Code gegossen ergibt dies sowas:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">    public class CodeInsideConfig : ConfigurationSection
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
    }

    public class CodeInsideConfigAuthorCollection : ConfigurationElementCollection
    {
        // define "author" as child-element-name (and not add...)
        public CodeInsideConfigAuthorCollection()
        {
            AddElementName = "author";
        }

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
    }

    public class CodeInsideConfigAuthor : ConfigurationElement
    {
        [ConfigurationProperty("name", IsRequired = true)]
        public string Name
        {
            get
            {
                return this["name"] as string;
            }
        }

        [ConfigurationProperty("topics")]
        public CodeInsideConfigTopicCollection Topics
        {
            get
            {
                return this["topics"] as CodeInsideConfigTopicCollection;
            }
        }

    }

    public class CodeInsideConfigTopicCollection : ConfigurationElementCollection
    {
        public CodeInsideConfigTopic this[int index]
        {
            get
            {
                return base.BaseGet(index) as CodeInsideConfigTopic;
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
            return new CodeInsideConfigTopic();
        }

        protected override object GetElementKey(ConfigurationElement element)
        {
            return ((CodeInsideConfigTopic)element).Name;
        }
    }

    public class CodeInsideConfigTopic : ConfigurationElement
    {
        [ConfigurationProperty("name", IsRequired = true)]
        public string Name
        {
            get
            {
                return this["name"] as string;
            }
        }

    } </pre>
<p>Wichtigster Punkt: Wir müssen dem Configuration-Framework mitteilen was eigentlich der Tag “author” bedeutet. Im Standardfall geht das Framework bei einer Collection von dem Tag “add” aus. Im Konstruktor der Collection können wir aber das <a href="http://msdn.microsoft.com/en-us/library/system.configuration.configurationelementcollection.addelementname.aspx">AddElementName</a> setzen – dies ist im Grunde schon der gesamte Trick.</p>
<h3></h3>
<h3>LINQ &amp; ConfigurationElements</h3>
<p>Auf dem ersten Blick verträgt sich LINQ und die Config-API nicht wirklich:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1875.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1016.png" width="433" height="61"></a> </p>
<p>Gibt man aber immer explizit die Typen mit an, kann man auch komplexere LINQ-Abfragen wie gewohnt machen:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;"> static void Main(string[] args)
        {
            // LINQ &amp; config demo
            var authors = from CodeInsideConfigAuthor author in CodeInsideConfig.GetConfig().Authors
                          select author;

            foreach (var codeInsideConfigAuthor in authors)
            {
                Console.WriteLine(codeInsideConfigAuthor.Name);
                Console.WriteLine("Foobar-Topics:");

                var topicsWithFoobar = from CodeInsideConfigTopic topic in codeInsideConfigAuthor.Topics
                                    where topic.Name.Contains("Foobar")
                                    select topic;


                foreach (CodeInsideConfigTopic topics in topicsWithFoobar)
                {
                    Console.WriteLine(topics.Name);
                }
            }

            Console.ReadLine();
        }</pre>
<p><strong>Ergebnis:</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1876.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1017.png" width="595" height="320"></a> </p>
<p>Quellen waren der <a href="http://stackoverflow.com/questions/8413760/configurationelementcollection-and-linq">LINQ Stackoverflow Thread</a> und <a href="http://www.endswithsaurus.com/2008/11/custom-configuration-section.html">über diesen Blogpost</a> bin ich auf die Zauberzutat “AddElementName” gekommen. Natürlich noch mein <a href="{{BASE_PATH}}/2009/11/03/howto-eine-eigene-configsection-schreiben-custom-configsections/">eigener Blogpost</a>.</p>
<p><a href="https://github.com/Code-Inside/Samples/tree/master/2013/NestedConfigurationElementCollection"><strong><u>Demo-Code auf GitHub</u></strong></a></p>
