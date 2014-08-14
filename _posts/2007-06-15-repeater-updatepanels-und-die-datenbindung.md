---
layout: post
title: "Repeater, UpdatePanels und die Datenbindung"
date: 2007-06-15 07:34
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [ASP.NET]
---
Da ich in der letzten Zeit an einer neuen Version der <a target="_blank" href="http://www.shoppingmap.de" title="ShoppingMap">ShoppingMap</a> arbeite und mich auch sonst in die "neuen" Microsoft Technologien einarbeite, bin ich erstmal auf ein paar Probleme gestoßen.

Da ich aus der <a target="_blank" href="http://php.net" title="PHP.net">PHP</a> Richtung komme und mich erstmal komplett in <a target="_blank" href="http://www.asp.net" title="ASP.NET">ASP.NET</a> einarbeiten musste, war mir das "dynamische" erstellen von Controls noch kein richtiger Begriff.

<u>Situationsbeschreibung:
</u>Ich gebe ein Suchwort ein und darauf hin wird ein Webdienst abgefragt. Die Suchergebnisse werden ähnlich wie die <a target="_blank" href="http://search.live.com/images/results.aspx?q=&amp;FORM=BIIR" title="Bildersuche bei Live.com">Bildersuche bei Live.com</a> angezeigt. Es wird also am Anfang ein Bild von dem jeweiligen Suchergebniss gezeigt und sobald man mit der Maus drüber geht, erscheinen nähere Inhalte und man kann dort wiederrum sich mehr Details anzeigen lassen. Diese Details werden wiederrum von einem anderen Webdienst abgefragt - d.h. es müssen mehr oder weniger dynamisch Controls mit Events erzeugt werden.

<u>Lesestoff:</u>
<ul>
	<li><a target="_blank" href="http://msdn2.microsoft.com/en-us/library/ms178472.aspx" title="ASP.NET Page Life Cylce (MSDN)">ASP.NET Page Life Cylce (MSDN)</a></li>
	<li><a target="_blank" href="http://weblogs.asp.net/infinitiesloop/archive/2006/08/25/TRULY-Understanding-Dynamic-Controls-_2800_Part-1_2900_.aspx" title="Blogeintrag ">Blogeintrag "TRULY Understanding Dynamic Controls (Part 1)</a></li>
	<li><a target="_blank" href="http://www.jeffzon.net/Blog/post/A-simple-way-to-handle-the-Buttons-click-event-from-repeaters.aspx" title="Blogeintrag ">Blogeintrag "A simple way to handle the Buttonï¿½s click event from repeaters"</a></li>
</ul>
<u>Problembeschreibung:</u>

Ich konnte leider keine Seite finden, welche datengebunde Repeater mit verschachtelten UpdatePanels anzeigt. Das Problem was ich auch hatte: Dieses &lt;%# DataBinder.Eval(... %&gt; find ich auch nicht gerade sehr elegant. Daher musste es eine andere Möglichkeit geben.

<u>Aufbau der ASPX Seite:</u>

Als erstes mal kurz den Code um zu zeigen, wie der Repeater bei mir (ungefähr) verwendet wird:
<pre class="csharpcode">&lt;asp:Repeater runat=<span class="str">"server"</span> OnItemDataBound=<span class="str">"DetailData"</span> ID=<span class="str">"RepeaterArticleItem"</span>&gt; 
 &lt;ItemTemplate&gt; 
  &lt;asp:Panel ID=<span class="str">"<strong>PanelContent</strong>"</span> style=<span class="str">"display: none;"</span> runat=<span class="str">"server"</span>&gt; 
    &lt;asp:UpdatePanel ID=<span class="str">"<strong>UpdatePanelDetails</strong>"</span> runat=<span class="str">"server"</span>&gt; 
      &lt;ContentTemplate&gt; 
          &lt;asp:Image ID=<span class="str">"<strong>ImageBig</strong>"</span> runat=<span class="str">"server"</span> /&gt; 
          &lt;asp:LinkButton ID=<span class="str">"<strong>LinkButtonTest</strong>"</span> OnClick=<span class="str">"Test"</span> Text=<span class="str">"Test" </span>runat=<span class="str">"server"</span> /&gt; 
      &lt;/ContentTemplate&gt; 
    &lt;/asp:UpdatePanel&gt; 
  &lt;/asp:Panel&gt; 
  &lt;asp:Image ID=<span class="str">"<strong>ImagePreview</strong>"</span> runat=<span class="str">"server"</span> /&gt; 
  &lt;ajaxToolkit:HoverMenuExtender ID=<span class="str">"HoverMenuExtenderContent"</span> 
                                 TargetControlID=<span class="str">"ImagePreview"</span> 
                                 PopupControlID=<span class="str">"PanelContent"</span> 
                                 runat=<span class="str">"server"</span> /&gt; 
 &lt;/ItemTemplate&gt; 
&lt;/asp:Repeater&gt;</pre>
<pre class="csharpcode">Â </pre>
<u>Erklärung:</u>

Das "PanelContent" wird erst sichtbar, sobald man mit der Maus über das "ImagePreview" geht. Durch den "<a target="_blank" href="http://ajax.asp.net/ajaxtoolkit/HoverMenu/HoverMenu.aspx" title="HoverMenuExtender - Control Toolkit">HoverMenuExtender</a>" aus dem <a target="_blank" href="http://ajax.asp.net/downloads/default.aspx?tabid=47" title="Microsoft AJAX Downloads">AJAX Toolkit</a> ist es eigentlich relativ einfach.
Im "PanelContent" ist ein <a target="_blank" href="http://ajax.asp.net/docs/" title="Microsoft AJAX Docs">UpdatePanel</a>, was wiederrum andere Controls enthalten kann.

<u>Datenquelle &amp; Code:</u>

Als Datenquelle kann man eigentlich alles nehmen, was man als <a target="_blank" href="http://msdn2.microsoft.com/de-de/library/system.web.ui.webcontrols.repeater.datasource(VS.80).aspx" title="MSDN DataSource">DataSource</a> angeben kann. In meinem Fall war es eine Collection, welche relativ verschachtelt ist.

Im Code sieht das recht einfach aus:
<pre class="csharpcode">        <span class="kwrd">this</span>.RepeaterArticleItem.DataSource = MyCollection; 
        <span class="kwrd">this</span>.RepeaterArticleItem.DataBind();</pre>
Damit wir jetzt direkt sagen können, welches Objekt aus der Collection welches Control "befüllen" soll, habe ich beim Repeater das "<a target="_blank" href="http://msdn2.microsoft.com/de-de/library/system.web.ui.webcontrols.repeater.itemdatabound(vs.80).aspx" title="MSDN OnItemDataBound">OnItemDataBound</a>"-Event eine kleine Methode hinterlegt.
<pre class="csharpcode">    <span class="kwrd">protected</span> <span class="kwrd">void</span> DetailData(<span class="kwrd">object</span> sender, EventArgs e) 
    { 
        RepeaterItemEventArgs RepeaterArgs = (RepeaterItemEventArgs)e; 
        OneCollectionItem MySingleItem = (OneCollectionItem)RepeaterArgs.Item.DataItem;   

        Image PreviewImage = (Image)RepeaterArgs.Item.FindControl(<span class="str">"ImagePreview"</span>); 
        PreviewImage.ImageUrl = MySingleItem.PictureGallery[0].Url; 
        PreviewImage.AlternateText = MySingleItem.Name;   

        UpdatePanel MyUpdatePanel = (UpdatePanel)RepeaterArgs.Item.FindControl(<span class="str">"UpdatePanelArticle"</span>); 
        Image BigImage = (Image)MyUpdatePanel.FindControl(<span class="str">"ImageDetailArticle"</span>); 
        BigImage.ImageUrl = MySingleItem.BigPicturegallery[0].Url;   

        LinkButton TestLink = (LinkButton)DetailUpdatePanel.FindControl(<span class="str">"LinkButtonTest"</span>); 
        TestLink.CommandArgument = MySingleItem.Id; 
    }</pre>
Das wars im Prinzip schon.
Die Collection hier hab ich mir jetzt nur mal ausgedacht, allerdings verwende ich es ähnlich bei mir und es funktioniert. Wenn man jetzt auf den LinkButten drückt, wird kein kompletter Postback ausgeführt, allerdings hat das UpdatePanel auch seine Tücken wie ich schonmal <a target="_blank" href="http://code-inside.de/blog/2007/06/07/gute-und-schlechte-seiten-des-updatepanels/" title="Code-Inside.de Blogeintrag zu den Guten und Schlechten Seiten des UpdatePanels">schrieb</a>.

Was ich damit zeigen wollte: Es ist sehr einfach, Daten an ein Element zu binden, welches wiederrum Actionen auslöst. Zudem ist es so leicht möglich, verschachtelte Strukturen zu schaffen und diese hässlichen &lt;%#... %&gt; (welche wie ich finde, äußerst ungünstig zu debuggen sind) benötigt man ebenfalls nicht mehr.

<a href="http://www.dotnetkicks.com/kick/?url=http://code-inside.de/blog/2007/06/15/repeater-updatepanels-und-die-datenbindung/"><img src="http://www.dotnetkicks.com/Services/Images/KickItImageGenerator.ashx?url=http://code-inside.de/blog/2007/06/15/repeater-updatepanels-und-die-datenbindung/" border="0" alt="kick it on DotNetKicks.com" /></a>

