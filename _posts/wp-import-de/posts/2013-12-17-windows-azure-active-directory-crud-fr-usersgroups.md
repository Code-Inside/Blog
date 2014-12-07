---
layout: post
title: "Windows Azure Active Directory - CRUD für Users und Groups"
date: 2013-12-17 00:01
author: robert.muehsig
comments: true
categories: [Allgemein, HowTo]
tags: [AD, Azure, REST, WAAD]
language: de
---
{% include JB/setup %}
<p>Die Authentifizierung am Windows Azure Active Directory haben wir sowohl bereits <a href="{{BASE_PATH}}/2013/12/01/windows-azure-active-directory-asp-net-tooling-ein-blick-hinter-die-kulissen/"><strong>mit dem Tooling</strong></a> als <a href="{{BASE_PATH}}/2013/11/10/windows-azure-active-directoryauthentifizierung-nur-code-erste-schritte-mit-der-graph-api/"><strong>auch via Code</strong></a> gesehen. Heute geht es darum, wie man Daten lesen und sogar auch schreiben kann.</p> <h3><strong>Windows Azure Active Directory?</strong></h3> <p>Wer keine Ahnung von der Begrifflichkeit hat, dem empfehle ich ebenfalls die beiden vorangegangen Blogposts oder schaut einfach auf <a href="http://www.windowsazure.com/en-us/documentation/services/active-directory/"><strong>dieser Azure Info Seite</strong></a>. </p> <h3><strong>Welche Ressourcen befinden sich da?</strong></h3> <p>Im Azure AD befinden sich folgende Entitäten:</p> <p>- Users<br>- Groups<br>- Contacts<br>- Roles</p> <h3><strong>Zugriff auf das Directory oder auf den “Directory Graph”</strong></h3> <p>Trotz des “Active Directory” im Namen und den bekannten Entitäten hat dieser Azure Dienst wenig Gemeinsamkeiten zu einem herkömmlichen Active Directory. Der vermutlich grösste Unterschied: Es gibt kein LDAP Zugriff – es ist eine <a href="http://msdn.microsoft.com/en-us/library/windowsazure/hh974478.aspx"><strong>REST API</strong></a>. Die Daten liegen im so genannten <a href="http://msdn.microsoft.com/en-us/library/windowsazure/hh974476.aspx"><strong>Windows Azure Active Directory Graph</strong></a>. Anwendungen die jetzt gegen ein Active Directory funktionieren müssen umgeschrieben werden für Windows Azure AD. </p> <h3><strong>REST … oder auch OData</strong></h3> <p>Als Endpunkt gibt es eine REST bzw. eine <a href="http://www.odata.org/">OData API</a>. Ob OData der eleganteste Weg ist steht auf einem anderen Papier – allerdings arbeitet das Team daran weitere <a href="http://blogs.msdn.com/b/aadgraphteam/archive/2013/09/18/enhancing-graph-api-queries-with-additional-odata-supported-queries.aspx">OData Features mit zu unterstützen.</a></p> <p>Grundsätzlich gibt es zwei Arten von Queries: </p> <p><a href="http://msdn.microsoft.com/en-us/library/windowsazure/jj126255.aspx">“Common Queries"</a>: Eine recht einfache API mit der man alle Daten aus dem AD rausholen kann.</p> <p><a href="http://msdn.microsoft.com/en-us/library/windowsazure/jj836245.aspx">“Differential Queries”</a>: Diese API wird interessant wenn man grosse Datenmengen zwischen der eigenen Anwendung und dem Azure AD synchronisieren möchte. Über diese API kann man nur die Änderungen an einer Ressource zwischen zwei Requests herausbekommen.</p> <h3><strong>Aktuell: Kein nettes NuGet Package</strong></h3> <p>Jetzt weg von der Theorie, hin zur Praxis. Aktuell gibt es leider kein NuGet Package oder ähnliches was die Arbeit mit der Graph API komplett vereinfacht. Zwar gibt es ein <a href="http://www.nuget.org/packages/Auth10.WindowsAzureActiveDirectory/">altes NuGet Package</a>, allerdings stammt dies auch nur aus Sample Code und zudem ist die API entsprechend schon recht alt und untersützt nicht alle Funktion die es heute gibt (Gruppen-Management z.B.)</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1968.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; display: inline; border-top-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb1104.png" width="550" height="588"></a> </p> <h3><strong>Alternative: Hand Made Requests</strong></h3> <p>Da es eine REST API ist, benötigt man natürlich nur einen HttpClient und man kann dagegen entwickeln. Die <a href="http://msdn.microsoft.com/en-us/library/windowsazure/dn151678.aspx">MSDN</a> gibt auch genügend Beispiele wie der Request aussehen kann:</p><pre>GET https://graph.windows.net/contoso.onmicrosoft.com/users/Alex@contoso.onmicrosoft.com?api-version=2013-04-05 HTTP/1.1
Authorization: Bearer eyJ0eX ... FWSXfwtQ
Content-Type: application/json
Host: graph.windows.net</pre>
<p>Da sich die API allerdings recht schnell weiter entwickelt und ich mir die “OData”-like Queries nicht von Hand zusammenschrauben möchte, gibt es noch einen Weg. Dieser scheint wohl mehr oder minder auch der “empfohlene” Weg zu sein.</p>
<h3><strong>Zum Code: Wir nutzen Sample Code – uhh oh…</strong></h3>
<p>Das Azure Graph Team publiziert auf <strong><a href="http://msdn.microsoft.com/en-us/library/windowsazure/hh974459.aspx">dieser MSDN</a></strong> Seite verschiedene Beispiele, darunter auch eine “Graph API Helper Library”. Im Einsatz kommt diese Library auch im <a href="http://code.msdn.microsoft.com/Write-Sample-App-for-79e55502"><strong>.NET Sample</strong></a><strong>.</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1969.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; margin-left: 0px; display: inline; border-top-width: 0px; margin-right: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb1105.png" width="245" align="left" height="425"></a>Das Sample ist eine MVC Anwendung, welche ein CRUD auf User und Groups abbildet. Der GraphHelper enthält die generierte “DataService” aus dem <a href="https://graph.windows.net/contoso.com/$metadata?api-version=2013-04-05">OData-Endpunkt</a> und einige Utilities drum herum – so kann man recht einfach sich gegen die Graph API authentifizieren und Requests abschicken.</p>
<p>Das Sample kommt mit <strong>voreingestellten Settings</strong> – allerdings ist die App nur “lesend” auf das AD berechtigt.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p><strong>Mal ein paar Screenshots von der Applikation:</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1970.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; display: inline; border-top-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb1106.png" width="576" height="544"></a> </p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1971.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; display: inline; border-top-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb1107.png" width="555" height="716"></a> </p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1972.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; display: inline; border-top-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb1108.png" width="548" height="787"></a> </p>
<h3><strong>Generierter Code… uh…</strong></h3><strong></strong>
<p>Der “generierte” Code stammt aus dem <a href="https://graph.windows.net/contoso.com/$metadata?api-version=2013-04-05">OData Endpunkt</a> und ist alles andere als “schön”. Dazu gibt es noch eine “Partial” Klasse, da die generierte Klasse die eigentlichen Entitäten nicht erkennt. </p>
<p>Der eigentliche Code ist nicht sehr komplex, aber vom Syntax nicht ganz so sexy.</p>
<p>So holt man z.B. alle Gruppen ab:</p><pre>   // 
        // GET: /Group/
        // Get: /Group?$skiptoken=xxx
        // Get: /Group?$filter=DisplayName eq 'xxxx'
        public ActionResult Index(string displayName, string skipToken)
        {
            QueryOperationResponse<group> response;
            var groups = DirectoryService.groups;
            // If a filter query for displayName  is submitted, we throw away previous results we were paging.
            if (displayName != null)
            {                
                ViewBag.CurrentFilter = displayName;
                // Linq query for filter for DisplayName property.
                groups = (DataServiceQuery<group>)(groups.Where(group =&gt; group.displayName.Equals(displayName)));
                response = groups.Execute() as QueryOperationResponse<group>;
            }
            else
            {
                // Handle the case for first request vs paged request.
                if (skipToken == null)
                {
                    response = groups.Execute() as QueryOperationResponse<group>;
                }
                else
                {
                    response = DirectoryService.Execute<group>(new Uri(skipToken)) as QueryOperationResponse<group>;
                }
            }
            List<group> groupList = response.ToList();
            // Handle the SkipToken if present in the response.
            if (response.GetContinuation() != null)
            {
                ViewBag.ContinuationToken = response.GetContinuation().NextLinkUri;
            }
            return View(groupList);
        }
</pre>
<h3><strong>Empfehlung: Sample anschauen und nicht direkt auf die generierten Klassen verweisen</strong></h3>
<p>Das Sample enthält die “Common Queries” plus CRUD-Operations und bietet einen einfachen Einstieg. Ich würde aber davon abraten direkt die Entitäten daraus zu nutzen, da die generierten Klassen auch “Unschönheiten” wie z.B. kleine Property-Namen mitbringen.</p>
<p>Weitere Informationen findet man in der <a href="http://msdn.microsoft.com/en-us/library/windowsazure/hh974476.aspx"><strong>MSDN auf der Graph API Seite</strong></a>.</p>
