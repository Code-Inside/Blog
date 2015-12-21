---
layout: page
title: "HowTo: eBay API (Suchen mit eBay...)"
date: 2007-04-13 09:27
author: Robert Muehsig
comments: true
categories: []
tags: []
permalink: /artikel/howto-ebay-api-suchen-mit-ebay
---
{% include JB/setup %}
Willkommen zurück zum HowTo über die eBay API.

Sobald die Grundvoraussetzungen für die API Nutzung erfüllt sind, kann es auch schon direkt losgehen.

Unser Ziel ist es, eine Suchanfrage an eBay zu schicken.

<strong>eBay API in Visual Studio nutzbar machen</strong>

Um nun die eBay API auch im Visual Studio komfortabel zu nutzen, fügt man eine "Web Referenz" dem Projekt hinzu:

-&gt; Projektmappen Explorer -&gt; Web References *Rechtsklick* -&gt; Webverweis hinzufügen: <a href="https://api.ebay.com/wsapi">https://api.ebay.com/wsapi</a>

Diese Adresse enthält die Schnittstellendefinition von eBay. Wenn Visual Studio vielleicht meckert, dass bestimmte Elemente in der Beschreibung falsch sind helfen zwei Sachen:
<ul>
	<li>Nochmal versuchen</li>
	<li>Ignorieren</li>
</ul>
Ich weiß leider nicht mehr genau woran es lag, aber bei mir hat es 5 Versuche gedauert, bis mein Visual Studio 2005 es komplett geschluckt hatte. Falls dann immer noch Fehler bei euch auftreten: Einfach ignorieren - seltsamerweise funktioniert es doch und sie verschwinden irgendwann.

Nachdem man das geschafft ist, kann man im Klassenexplorer sich mal die API anschauen, wie man feststellt ist es doch sehr umfangreich. Keine Angst, man braucht niemals alles - jedenfalls erstmal nicht ;)

<strong>Die Suchanfrage</strong>
Da man für jede Suchanfrage die 3 Keys und das Token eingeben muss, habe ich mir eine kleine Klasse geschrieben, die das übernimmt:
<pre>
public class InterfaceService 
{ 
   #region Properties 
   private eBayAPIInterfaceService eBayService = new eBayAPIInterfaceService();       

   public eBayAPIInterfaceService EBayService 
    { 
    get { return eBayService; } 
    set { eBayService = value; } 
   }       

#endregion       

public InterfaceService(string callName) 
{ 
string endpoint = "https://api.ebay.com/wsapi"; 
string siteId = "77" // Deutsche eBay Seitestring 
appId = "" // AppIDstring 
devId = "" // DevIDstring 
certId = "" // CertIdstring 
version = "495" // API Version 
string eBayAuthToken = ""  // Token       

this.EBayService.Url = endpoint + 
                             "?callname=" 
                              + callName+ 
                              "&amp;siteid=" + siteId+ 
                              "&amp;appid=" + appId+ 
                              "&amp;version=" + version+ 
                              "&amp;routing=default"       

this.EBayService.RequesterCredentials = new CustomSecurityHeaderType(); 
this.EBayService.RequesterCredentials.Credentials = new UserIdPasswordType(); 
this.EBayService.RequesterCredentials.Credentials.AppId = appId; 
this.EBayService.RequesterCredentials.Credentials.DevId = devId; 
this.EBayService.RequesterCredentials.Credentials.AuthCert = certId; 
this.EBayService.RequesterCredentials.eBayAuthToken = eBayAuthToken; 
} 
}</pre>
So... eine sehr einfache Klasse, welche aber (jedenfalls mir) das eBay Leben erleichtert hat. Ich hoffe der Code wird hier nicht arg zu sehr vermurkst durch den Blog.

So... nachdem man das gemacht hat, wollen wir aber direkt mal eine Suchanfrage durchführen (in einem oldschool Konsolenprogramm):
<pre>
InterfaceService MyeBay = new InterfaceService("GetSearchResults");       

GetSearchResultsRequestType SearchRequest = new GetSearchResultsRequestType(); 
SearchRequest.Query = "Schrank"; 
SearchRequest.Version = "495"; 
   try 
   { 
   GetSearchResultsResponseType SearchResponse = new GetSearchResultsResponseType(); 
   SearchResponse = MyeBay.EBayService.GetSearchResults(SearchRequest);       

      for (int i = 0; i &lt;= SearchResponse.SearchResultItemArray.Length; i++) 
      { 
      System.Console.WriteLine(SearchResponse.SearchResultItemArray[i].Item.Title); 
      }       

   System.Console.Read(); 
   } 
   catch (Exception e) 
   { 
   System.Console.WriteLine(e.Message); 
   System.Console.Read(); 
   }</pre>
Dieses Beispiel ist sehr einfach, aber ich glaube, hier wird langsam klar, wofür ich die InterfaceService Klasse gebraucht habe - ich brauche in diesem Code keine Keys angeben.

Das Ergebnis von diesem Code ist einfach: Ausgabe von 100 aktuellen Schränke die bei eBay gelistet werden.

Es wird eine Exception ausgelöst, wenn die Suche keine Ergebnisse brauchte, Ihr könnt gerne mal das Suchwort (also SearchRequest.Query) ändern.
Trotz dessen, dass wir in der InterfaceService Klasse die Version angegeben haben, muss sie hier trotzdem beim eigentlichen Request mit angegeben werden.

Auf <a href="http://www.shoppingmap.de">www.shoppingmap.de</a> findet ihr noch 2 andere Details, die für die Suche hilfreich sein können:

- Kategorien
- Umkreis

Diese beiden Sachen, insbesondere, wie man leicht auf die Kategorien von eBay zugreifen kann, kommt dann demnächst.

Grüße
