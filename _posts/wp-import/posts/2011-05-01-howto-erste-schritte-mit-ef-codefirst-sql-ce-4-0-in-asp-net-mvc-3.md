---
layout: post
title: "HowTo: Erste Schritte mit EF CodeFirst & SQL CE 4.0 in ASP.NET MVC 3"
date: 2011-05-01 23:44
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [CodeFirst, EF, HowTo, SQL CE]
---
{% include JB/setup %}
<p><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb441.png" width="179" height="161" />Wenn man mal "schnell” eine kleine Datenbank braucht - ohne großen SQL Server oder sich erst mit Sqlite und co. rumzuschlagen kann auch auf SQL CE 4.0 zurückgegriffen werden. Zusammen mit dem Entity Framework CodeFirst Modell kann man recht schnell eine kleine Anwendung zusammenbauen. CodeFirst kann natürlich auch in Verbindung mit einem richtigen SQL Server angewandt werden. Hier mal ein kurzes Tutorial, wie man das Initial zum Laufen bekommt.</p> <!--more-->  <p><strong>SQL CE 4.0? Warum nicht Sqlite, eine XML Datei etc.?</strong></p>  <p>Geht natürlich auch - allerdings muss man dann auf das Entity Framework verzichten (ob das schlimm ist, muss jeder für sich entscheiden ;) ). SQL CE 4.0 ist der Mini-Bruder vom SQL Server - demzufolge könnte man auch später ein Upgrade ohne Probleme vollziehen. SQL CE 4.0 läuft mit im Prozess und bedarf keiner weiteren Installation beim Betrieb. Man muss nur die passenden Dlls mit ausliefern und es läuft. </p>  <p>Eine genauere Beschreibung liefert ScottGu: <a href="http://weblogs.asp.net/scottgu/archive/2011/01/11/vs-2010-sp1-and-sql-ce.aspx">VS 2010 SP1 and SQL CE</a></p>  <p><strong>EF CodeFirst? Was das?</strong></p>  <p>Das Entity Framework mit seinem gigantischen .EDMX Model ist schon etwas ziemlich gewaltiges und meiner Meinung nach nicht gerade elegant und nützlich. Mit EF CodeFirst wird ein "leichtes” Modell angeboten, in dem man sowohl die Vorzüge des EFs (LINQ!) und das Mappen auf eigene POCOs nutzen kann. (Andere Frameworks (z.B. NHibernate) bieten solch ein Feature bereits seit einiger Zeit an, aber diesen fehlte (?) zum Teil lange ein netter LINQ Support.)</p>  <p>Ganz detailliert natürlich auch bei ScottGu: <a href="http://weblogs.asp.net/scottgu/archive/2010/07/16/code-first-development-with-entity-framework-4.aspx">Code-First Development with Entity Framework 4</a></p>  <p><strong>Beispielapp - wie sieht der Entwicklungsprozess aus?</strong></p>  <p>Da das erste Setup mit Code-First &amp; SQL CE 4.0 etwas Forschungsarbeit mit sich gebracht hat, zeige ich mal ganz kurz wie man die ersten Schritte unternimmt.</p>  <p>Vermutlich ist es besser, wenn man das VS2010 SP1 installiert hat - bin mir aber jetzt nicht ganz sicher ob es wirklich von Nöten ist. </p>  <p>Wir fangen an und erstellen eine ASP.NET MVC 3 Applikation. <strong>Wichtig:</strong> Vorher das <a href="http://www.microsoft.com/downloads/en/details.aspx?FamilyID=82cbd599-d29a-43e3-b78b-0f863d22811a&amp;displaylang=en">ASP.NET MVC 3 Tools Update installieren</a>. Damit kommt das Entity Framework Update als NuGet Package gleich mit. Nachprüfen kann man das, indem man die Assembly "EntityFramework” in den Referenzen sucht. Diese wird benötigt! Ansonsten via NuGet z.B. nach Code First suchen :)</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1261.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb442.png" width="240" height="243" /></a></p>  <p><strong>Prüfen ob SQL 4.0 Dev Tools installiert sind</strong></p>  <p>Um zu schauen ob die Dev Tools installiert sind, kann man ein Blick in das "Add Items” (irgendwo in einem Ordner im Projekt *rechtsklick*) Menü werfen:</p>  <p><strong>Sieht</strong> man das <strong>SQL Server Compact 4.0</strong> Item ist alles ok.<strong> Empfehlung von mir:</strong> <strong>Legt euch eine SQL Server Compact 4.0 DB an</strong>, damit werden alle benötigten Referenzen automatisch ins Projekt eingebunden. <strong>Anschließend aber die DB wieder rauslöschen</strong>, weil diese uns weiter unten ein paar Probleme bereitet :)</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1262.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb443.png" width="517" height="267" /></a> </p>  <p>Wenn man das Item nicht sieht: Im <strong>Web Platform Installer</strong> die <strong>"VS 2010 SP1 Tools for SQL Server Compact” installieren</strong> (Alternativ über diesen <a href="http://go.microsoft.com/fwlink/?LinkId=212219">Link</a> - allerdings fängt dann sofort der Download an und dummerweise nimmt er bei mir immer die deutsche Version (welche ich aber nicht haben will) - besser Web PI)</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1263.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb444.png" width="510" height="352" /></a> </p>  <p>Nach dem Installieren bekam ich diese Meldung:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1264.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb445.png" width="504" height="158" /></a> </p>  <p>Nach der Installation muss das VS 2010 neugestartet werden - nun im Projekt eine SQL CE DB anlegen um die benötigten Referenzen zu bekommen.</p>  <p><strong>Nächster Schritt: App_Data Verzeichnis erstellen</strong></p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1265.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb446.png" width="209" height="156" /></a></p>  <p>Dieser Schritt sollte bereits erledigt sein: Wenn ihr die DB angelegt habt, sollte euch VS auch gleich das App_Data Verzeichnis angelegt haben. Wenn nicht: Im App_Data Verzeichnis sollen alle Datenbanken und sonstige "Data” Sachen landen. Allerdings wird der Ordner nicht sofort mit angelegt - daher müssen wir den noch manuell hinzufügen (über *rechtsklick* auf das Projekt *Add* - *Add ASP.NET Folders* - App_Data).</p>  <p><strong>ConnectionString anlegen</strong></p>  <p>Nun hinterlegen wir in der Web.config z.B. folgenden ConnectionString:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:3426b8bb-3aab-4fc0-8949-df1898175557" class="wlWriterEditableSmartContent"><pre name="code" class="c#">  &lt;connectionStrings&gt;
    &lt;add name="DatabaseContext" connectionString="Data Source=|DataDirectory|TestWebsiteModelDatabase.sdf" providerName="System.Data.SqlServerCe.4.0"/&gt;
  &lt;/connectionStrings&gt;</pre></div>

<p>Ein paar Anmerkungen:</p>

<ul>
  <li>DataDirectory steht für das App_Data Verzeichnis der Anwendung.</li>

  <li>.SDF ist ein SQL Server Compact File (anders als das .MDF vom großen SQL Server)</li>

  <li>Der Providername ist auf SQL CE 4.0 eingestellt.</li>

  <li>Der Name des ConnectionStrings wird später noch eine wichtige Rolle spielen!</li>
</ul>

<p><strong>Ein Model erstellen - Code-First Style</strong></p>

<p>Wir haben User und Kommentare dazu - nichts wirklich aufregendes. Wichtig hierbei: Keine Attribute von irgendwelchen Entity Framework Sachen - simple POCOs.</p>

<p>
  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:32c1c9d1-53d8-4899-97ec-276b10b1571c" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    public class User
    {
        public string Name { get; set; }
        public Guid Id { get; set; }
        public List&lt;Comment&gt; Comments { get; set; }
    }

    public class Comment
    {
        public Guid Id { get; set; }
        public User User { get; set; }
        public string Text { get; set; }
    }</pre></div>
</p>

<p><strong>Controller mit Scaffolding erzeugen</strong></p>

<p>Nun fügen wir ein MVC Controller dazu (<strong>auf den Controller Ordner *Rechtsklick* - *Add Controller*</strong>).</p>

<p>Hier geben wir den Controller-Namen an, wählen das Scaffolding Template mit den EF Options und wählen die User Klasse aus. Falls die Klasse dort nicht erscheint: <u>Vorher ein Rebuild ausführen!</u></p>

<p><strong>Als Data context class muss derselbe Name genommen werden wie der <u>Name des Connection Strings</u>! (in meinem Fall also: DatabaseContext).</strong></p>

<p>"Convention over configuration” ist hier das Motto.</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1266.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb447.png" width="513" height="365" /></a> </p>

<p> In den Advanced Options kann man auch noch eine Masterpage auswählen:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1267.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb448.png" width="445" height="291" /></a></p>

<p><strong>Ergebnis:</strong></p>

<p>Es wurde dieser Controller automatisch erstellt:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:8c7aa685-84df-40f2-aeed-68cb280885f4" class="wlWriterEditableSmartContent"><pre name="code" class="c#">using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcEFCodeFirst.Models;

namespace MvcEFCodeFirst.Controllers
{ 
    public class UserController : Controller
    {
        private DatabaseContext db = new DatabaseContext();

        //
        // GET: /User/

        public ViewResult Index()
        {
            return View(db.Users.ToList());
        }

        //
        // GET: /User/Details/5

        public ViewResult Details(Guid id)
        {
            User user = db.Users.Find(id);
            return View(user);
        }

        //
        // GET: /User/Create

        public ActionResult Create()
        {
            return View();
        } 

        //
        // POST: /User/Create

        [HttpPost]
        public ActionResult Create(User user)
        {
            if (ModelState.IsValid)
            {
                user.Id = Guid.NewGuid();
                db.Users.Add(user);
                db.SaveChanges();
                return RedirectToAction("Index");  
            }

            return View(user);
        }
        
        //
        // GET: /User/Edit/5
 
        public ActionResult Edit(Guid id)
        {
            User user = db.Users.Find(id);
            return View(user);
        }

        //
        // POST: /User/Edit/5

        [HttpPost]
        public ActionResult Edit(User user)
        {
            if (ModelState.IsValid)
            {
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(user);
        }

        //
        // GET: /User/Delete/5
 
        public ActionResult Delete(Guid id)
        {
            User user = db.Users.Find(id);
            return View(user);
        }

        //
        // POST: /User/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(Guid id)
        {            
            User user = db.Users.Find(id);
            db.Users.Remove(user);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}</pre></div>

<p>Es wurden diese Views angelegt (voll funktionsfähig) :</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1268.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb449.png" width="230" height="214" /></a> </p>

<p>Es wurde eine DatabaseContext Klasse angelegt:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:4dbbc34b-6be5-436f-8c12-bf6c07d39942" class="wlWriterEditableSmartContent"><pre name="code" class="c#">using System.Data.Entity;

namespace MvcEFCodeFirst.Models
{
    public class DatabaseContext : DbContext
    {
        // You can add custom code to this file. Changes will not be overwritten.
        // 
        // If you want Entity Framework to drop and regenerate your database
        // automatically whenever you change your model schema, add the following
        // code to the Application_Start method in your Global.asax file.
        // Note: this will destroy and re-create your database with every model change.
        // 
        // System.Data.Entity.Database.SetInitializer(new System.Data.Entity.DropCreateDatabaseIfModelChanges&lt;MvcEFCodeFirst.Models.DatabaseContext&gt;());

        public DbSet&lt;User&gt; Users { get; set; }
    }
}
</pre></div>

<p>Über diese Klasse passieren (siehe Controller) die Zugriffe und es geschieht das Mapping auf das POCO. Interessant ist noch Zeile 14. Wenn man den Anweisungen folgt und diese Zeile in der Global.asax einfügt, wird bei Schemaänderungen eine neue Datenbank angelegt. Datenmigrationen erfolgen aber nicht!</p>

<p>Für Development-Zwecke aber sehr praktisch.</p>

<p>Achtung: Es darf aber keine Datenbank diesen Namens bereits existieren - weil das Framework sonst damit nicht umgehen kann.</p>

<p><u>Die erstellte Datenbank sieht von der Struktur so aus:</u></p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1269.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb450.png" width="160" height="244" /></a> </p>

<p><strong>Was ist mit den Comments? Tauchen die auch irgendwo auf?</strong></p>

<p>In unserem Model hatten wir weiter oben eine Verbindung zwischen User und Comment gemacht - in der DB wird diese auch abgebildet, allerdings sind diese in den Templates nicht wiederzusehen. Man kann allerdings sicherlich das Scaffolding anpassen, sodass dies nur eine Frage der verfügbaren Templates ist - passender Google Suchbegriff: MvcScaffolding.</p>

<p><strong>Wie sieht so ein View aus:</strong></p>

<p>Da wir nicht wirklich viele Properties festgelegt haben ("ID” wird auch vom Framework erzeugt und kann daher nicht angepasst werden - auch eine Konvention) sieht es nur so aus:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1270.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb451.png" width="244" height="217" /></a> </p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1271.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb452.png" width="242" height="244" /></a> </p>

<p>usw.</p>

<p><strong>Fazit</strong></p>

<p>Für schnelle Prototypen sehr praktisch. Wie sich das Mapping bei komplexeren Sachverhalten verhält: Keine Ahnung. Durch die LINQ Unterstützung und das Scaffolding macht es trotz mancher Setup-Sachen durchaus Spaß.</p>

<p><strong>Deployment</strong></p>

<p>Wer alle Assemblies sich für ein sicheres Deployment zusammensuchen möchte, dem empfehle ich *Rechtsklick* auf das Projekt zu machen und *Add Deployable Dependencies* auszuwählen (in dem Fall hier: Alles anklicken ;) ) :</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1272.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb453.png" width="308" height="221" /></a> </p>

<p>Dann wird noch ein recht großer Ordner in das Projekt ein gehangen in dem die Abhängigkeiten mit drin sind.</p>

<p>Soviel zum kurzen Einstieg in das Thema :)</p>

<p><a href="{{BASE_PATH}}/assets/files/democode/mvcefcodefirst/mvcefcodefirst.zip">[ Download Democode ]</a></p>
