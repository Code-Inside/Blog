---
layout: post
title: "Twitter Bootstrap als UI-Baukasten"
date: 2011-10-07 19:37
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [CSS, Frontend, HTML, Twitter, UI]
---
{% include JB/setup %}
<p>HTML und CSS sind für mich keine Fremdworte, jedoch muss ich mich geschlagen geben: Ich selbst bin kein Web<strong>designer</strong> – ich würde mich eher als Webentwickler betrachten. Eine schicke Seite ist aber ein muss. Zum Glück gibt es fertige “Systeme”</p> <p><strong>Twitter Bootstrap</strong></p> <p>Twitter Bootstrap ist ein Toolkit für alle möglichen Arten von Webapplikationen. Es beinhaltet einige Basis Styles und spezielle Styles für Buttons, Tabellen, Formularen etc. Im Grunde ist es ein ausgefeiltes Grid-System. Im Gegensatz zu anderen CSS Grid Frameworks, wirkt Twitter Bootstrap auf den ersten Blick jedenfalls “runder” und bietet schon einige Standardelemente.</p> <p>Am besten kann man sich alles <a href="http://twitter.github.com/bootstrap/"><strong>online</strong></a> anschauen. Sourcen dazu findet man auf <a href="https://github.com/twitter/bootstrap">GitHub</a>.</p> <p><strong>Technik dahinter</strong></p> <p>Twitter Bootstrap nutzt <a href="http://twitter.github.com/bootstrap/#less">Less</a> um das CSS zu erstellen und hat sogar für einige kleine UI Spielerein (Popups, Dropdowns, Dialoge…) fertige <a href="http://twitter.github.com/bootstrap/javascript.html">Javascripts</a></p> <p><strong>Die Einbindung</strong></p> <p>.Es müssen nur die Styles (entweder die LESS Datein + die <a href="http://lesscss.org/">LESS Javascript</a> Datei oder die fertige CSS) eingebunden werden. Ein Beispiel, welches auch in den Examples auf GitHub zu finden ist:</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:08505900-68d7-421a-b8b5-11b41c11ceb9" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;!DOCTYPE html&gt;
&lt;html lang="en"&gt;
  &lt;head&gt;
    &lt;meta charset="utf-8"&gt;
    &lt;title&gt;Bootstrap, from Twitter&lt;/title&gt;
    &lt;meta name="description" content=""&gt;
    &lt;meta name="author" content=""&gt;

    &lt;!-- Le HTML5 shim, for IE6-8 support of HTML elements --&gt;
    &lt;!--[if lt IE 9]&gt;
      &lt;script src="http://html5shim.googlecode.com/svn/trunk/html5.js"&gt;&lt;/script&gt;
    &lt;![endif]--&gt;

    &lt;!-- Le styles --&gt;
    &lt;link href="../bootstrap.css" rel="stylesheet"&gt;
    &lt;style type="text/css"&gt;
      /* Override some defaults */
      html, body {
        background-color: #eee;
      }
      body {
        padding-top: 40px; /* 40px to make the container go all the way to the bottom of the topbar */
      }
      .container &gt; footer p {
        text-align: center; /* center align it with the container */
      }
      .container {
        width: 820px; /* downsize our container to make the content feel a bit tighter and more cohesive. NOTE: this removes two full columns from the grid, meaning you only go to 14 columns and not 16. */
      }

      /* The white background content wrapper */
      .content {
        background-color: #fff;
        padding: 20px;
        margin: 0 -20px; /* negative indent the amount of the padding to maintain the grid system */
        -webkit-border-radius: 0 0 6px 6px;
           -moz-border-radius: 0 0 6px 6px;
                border-radius: 0 0 6px 6px;
        -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.15);
           -moz-box-shadow: 0 1px 2px rgba(0,0,0,.15);
                box-shadow: 0 1px 2px rgba(0,0,0,.15);
      }

      /* Page header tweaks */
      .page-header {
        background-color: #f5f5f5;
        padding: 20px 20px 10px;
        margin: -20px -20px 20px;
      }

      /* Styles you shouldn't keep as they are for displaying this base example only */
      .content .span10,
      .content .span4 {
        min-height: 500px;
      }
      /* Give a quick and non-cross-browser friendly divider */
      .content .span4 {
        margin-left: 0;
        padding-left: 19px;
        border-left: 1px solid #eee;
      }

      .topbar .btn {
        border: 0;
      }

    &lt;/style&gt;

    &lt;!-- Le fav and touch icons --&gt;
    &lt;link rel="shortcut icon" href="images/favicon.ico"&gt;
    &lt;link rel="apple-touch-icon" href="images/apple-touch-icon.png"&gt;
    &lt;link rel="apple-touch-icon" sizes="72x72" href="images/apple-touch-icon-72x72.png"&gt;
    &lt;link rel="apple-touch-icon" sizes="114x114" href="images/apple-touch-icon-114x114.png"&gt;
  &lt;/head&gt;

  &lt;body&gt;

    &lt;div class="topbar"&gt;
      &lt;div class="fill"&gt;
        &lt;div class="container"&gt;
          &lt;a class="brand" href="#"&gt;Project name&lt;/a&gt;
          &lt;ul class="nav"&gt;
            &lt;li class="active"&gt;&lt;a href="#"&gt;Home&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="#about"&gt;About&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="#contact"&gt;Contact&lt;/a&gt;&lt;/li&gt;
          &lt;/ul&gt;
          &lt;form action="" class="pull-right"&gt;
            &lt;input class="input-small" type="text" placeholder="Username"&gt;
            &lt;input class="input-small" type="password" placeholder="Password"&gt;
            &lt;button class="btn" type="submit"&gt;Sign in&lt;/button&gt;
          &lt;/form&gt;
        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;div class="container"&gt;

      &lt;div class="content"&gt;
        &lt;div class="page-header"&gt;
          &lt;h1&gt;Page name &lt;small&gt;Supporting text or tagline&lt;/small&gt;&lt;/h1&gt;
        &lt;/div&gt;
        &lt;div class="row"&gt;
          &lt;div class="span10"&gt;
            &lt;h2&gt;Main content&lt;/h2&gt;
          &lt;/div&gt;
          &lt;div class="span4"&gt;
            &lt;h3&gt;Secondary content&lt;/h3&gt;
          &lt;/div&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;footer&gt;
        &lt;p&gt;&amp;copy; Company 2011&lt;/p&gt;
      &lt;/footer&gt;

    &lt;/div&gt; &lt;!-- /container --&gt;

  &lt;/body&gt;
&lt;/html&gt;
</pre></div>
<p>&nbsp;</p>
<p>Erzeugt diese Seite:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1367.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb549.png" width="554" height="334"></a></p>
<p><strong>Roadmap</strong></p>
<p>Es gibt auch eine <a href="https://github.com/twitter/bootstrap/wiki/Roadmap">Roadmap</a> für das Projekt, welches aktiv von mehreren Entwicklern bei Twitter gepflegt wird:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1368.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb550.png" width="506" height="226"></a></p>
<p><strong>Fazit</strong></p>
<p>Twitter Bootstrap scheint für nicht-Designer ein solider Anfang zu sein, mit vielen netten Elementen. Das einzige was noch fehlt, wäre eine Variante für Mobile Webseiten – schauen wir mal.</p>
<p>Download und alles andere findet man auf <a href="http://twitter.github.com/bootstrap/">GitHub</a>.</p>
