---
layout: post
title: "Azure Access Control Service, Microsoft Account Login, JSON Web Token und ASP.NET – “ohne WIF-Magic”"
date: 2013-04-09 01:24
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Access Control Service, Azure AD, Login, Security, WAAD]
---
{% include JB/setup %}
<p>Buzzwords?! Nein – am Ende passt es doch alles zusammen und ist sogar ziemlich cool. Ich hatte bereits das kostenlose Buch über <a href="http://code-inside.de/blog/2013/03/19/guide-zu-claims-based-identity-mit-dem-access-control-service/">Claim-based Authentifizierung</a> empfohlen – heute geht es um folgendes Szenario:</p> <p><em>Wie kann ich meine ASP.NET Seite auf “einfachste” und ohne grosse Zauberei mit dem Access Control Service verbinden?</em>&nbsp; </p> <p><strong>Achtung:</strong> Microsoft selbst empfiehlt eher ein grösseres Tooling <a href="http://www.asp.net/vnext/overview/latest/windows-azure-authentication">(im Falle von ASP.NET ist das auch echt schick!),</a> was am Ende die web.config unglaublich aufbläht – zudem hatte ich Schwierigkeiten weil die Handler da “zu viel automatisch” machen. <br>Die Idee hab ich <a href="http://geekswithblogs.net/EltonStoneman/archive/2012/09/19/wif-less-claim-extraction-from-acs-jwt.aspx">von diesem Post</a> – und funktioniert bislang ;) Zudem lernt man einiges über die Protokolle dahinter.</p> <p><strong>Kurzfassung: Was ist der Access Control Service (ACS)</strong></p> <p>Dieser Azure Service darf man sich wie einen zentralen Verteiler für Authentifizierung vorstellen – man kann verschiedene Authentifizierungsanbieter einklicken und ACS übernimmt dabei die Transformation der Tokens in das was wir benötigen. Eure Anwendung soll ADFS (für Business Kunden), Microsoft Account und Facebook unterstützen? Puh… Der Access Control Service kann hierfür interessant sein!&nbsp; </p> <p>Mehr Informationen gibt es <a href="http://www.windowsazure.com/en-us/develop/net/how-to-guides/access-control/">hier</a>.</p> <p>&nbsp;<a href="{{BASE_PATH}}/assets/wp-images/image1806.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb959.png" width="358" height="358"></a> </p> <p><strong>Was ist ein Microsoft Account?</strong></p> <p>Der Microsoft Account war früher bekannt unter dem Namen Windows Live ID. Diese Bezeichnung sieht man immer wieder, aber eigentlich find ich Microsoft Account vom Naming her besser, daher bleiben wir dabei.</p> <p><strong>Was ist ein JSON Web Token (JWT)?</strong></p> <p>Über dieses Format werden am Ende die Claims ausgetauscht. Mehr dazu <a href="http://self-issued.info/docs/draft-ietf-oauth-json-web-token.html">hier</a>.</p> <h3>Vorbereitung: ACS Namespace</h3> <p>Für das Sample benötigen wir ein ACS Namespace, der im Management-Portal eingerichtet werden kann:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1807.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb960.png" width="556" height="412"></a> </p> <p>Dort legen wir eine “Relying party application” an – dies repräsentiert unsere Claim-based Anwendung:</p> <p>(aktuell ist die ACS-Verwaltung immer noch im alten look)</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1808.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb961.png" width="571" height="624"></a> </p> <p>Wichtigster Punkte:</p> <p>- der Realm</p> <p>- die Return URL</p> <p>- das Token Format auf JWT umstellen</p> <p>- Bei Identity Provider “Windows Live ID” auswählen </p> <p>- Eine Rule Group anlegen (bei mir ist die schon angelegt)</p> <p>In der Rule Group sicher stellen, dass auch die Claims weitergegeben werden:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1809.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb962.png" width="624" height="364"></a> </p> <h3>Welche Daten bekomme ich durch die Windows Live ID/Microsoft Account?</h3> <p>Fast keine – bis auf einen kryptischen Key im “nameidentifier”-Claim. D.h. man kommt aktuell an absolut 0 Profil Informationen und man muss den Nutzer diese Geschichte manuell nochmal eintragen lassen. Der Key ist auch pro ACS Namespace eindeutig – die Realms spielen (anders als es vielleicht in der MSDN steht) keine Rolle für den “nameidentifier” </p> <h3></h3> <h3>Schauen wir uns das Sample an:</h3> <p>Standard-MVC App – kein Azure Auth Toolkit etc. in Verwendung! Nur der Link hinter “Log in” verweisst auf einen Controller den ich gleich zeige.</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1810.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb963.png" width="574" height="355"></a> </p> <p>Bei “Log in” werde ich sofort auf die Microsoft Login Seite umgeleitet.</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1811.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb964.png" width="571" height="374"></a> </p> <p><em>Kleiner Hinweis: Die Parameter in der URL wie “wa” oder “wtrealm” stammen aus </em><a href="http://docs.oasis-open.org/wsfed/federation/v1.2/os/ws-federation-1.2-spec-os.html"><em>dem WS-Federation Spec</em></a><em>.</em></p> <p>Oben in der Adresse sieht man auch unseren Access Control Service wieder (bzw. den ich angelegt hab). Danach wird man direkt auf die Startseite umgeleitet und ist unter einem sehr seltsamen Namen “angemeldet”</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1812.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb965.png" width="556" height="358"></a> </p> <h3><strong></strong></h3> <h2>Was passiert im Hintergrund?</h2> <p>&nbsp;</p> <p>Hier der komplette Code meines Authentifzierungs-Controllers:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">/// &lt;summary&gt;
    /// Everything based on WS-Federation: http://docs.oasis-open.org/wsfed/federation/v1.2/os/ws-federation-1.2-spec-os.html
    /// &lt;/summary&gt;
    public class AuthController : Controller
    {
        public ActionResult Index()
        {
            // Microsoft Account Login

            // 2 Option - use hosted Loginpage from ACS or host your own...

            // based on Azure ACS Portal - Login Page Integration - Option 1:
            // Problem: wfresh=0 not supported - logout is :/
            return new RedirectResult("https://codeinside.accesscontrol.windows.net:443/v2/wsfederation?wa=wsignin1.0&amp;wtrealm=urn:sample:wifless");

            // Option 2: Use the link from the JSON - but needed more coding.
            // But wfresh=0 is supported!
            //return new RedirectResult("https://login.live.com/login.srf?wa=wsignin1.0&amp;wtrealm=https%3a%2f%2faccesscontrol.windows.net%2f&amp;wreply=https%3a%2f%2fcodeinside.accesscontrol.windows.net%2fv2%2fwsfederation&amp;wp=MBI_FED_SSL&amp;wctx=cHI9d3NmZWRlcmF0aW9uJnJtPXVybiUzYXNhbXBsZSUzYXdpZmxlc3Mmcnk9aHR0cCUzYSUyZiUyZmxvY2FsaG9zdCUzYTg4MTclMmZBdXRoJTJmQ2FsbGJhY2s1&amp;wfresh=0");
        }

        [ValidateInput(false)]
        public ActionResult Callback(string wresult, string wa)
        {
            if (wa == "wsignin1.0")
            {
                var wrappedToken = XDocument.Parse(wresult);
                var binaryToken = wrappedToken.Root.Descendants("{http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd}BinarySecurityToken").First();
                var tokenBytes = Convert.FromBase64String(binaryToken.Value);
                var token = Encoding.UTF8.GetString(tokenBytes);

                var result = AcsAuthorizationTokenValidator.RetrieveClaims(token,
                                                                          "https://codeinside.accesscontrol.windows.net/",
                                                                          new List&lt;string&gt;() { "urn:sample:wifless" });

                var name = result.Claims.Single(x =&gt; x.Type == ClaimTypes.NameIdentifier);

                FormsAuthentication.SetAuthCookie(name.Value, false);
            }
            else if (wa == "wsignoutcleanup1.0")
            {
                FormsAuthentication.SignOut();
            }
            return RedirectToAction("Index", "Home");
        }

        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();

            return RedirectToAction("Index", "Home");
        }

    }</pre>
<p>Über Auth/Index werd ich direkt zum ACS Login bzw. direkt weiter zum Microsoft Login umgeleitet. Die Links zu dieser Seite findet man in seinem ACS-Namespace unter “Application integration” – in meinem Fall nehm ich die Option 1.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1813.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb966.png" width="565" height="348"></a> </p>
<p>Wenn ich mehrere Identity Provider (z.B. Facebook oder Google) ebenfalls auf das Sample zuschalten (was wirklich so einfach geht wie es klingt), dann würde eine etwas spartanische Login-Seite mit einer Auswahl den User begrüssen. </p>
<p>Der Nachteil der Variante 1:</p>
<p>- Sehr spartanisches UI bei mehreren Identity Providern</p>
<p>- Den Login erzwingen ist gar nicht so einfach. Wenn man irgendwie mit irgendeinem Microsoft Account eingeloggt ist, sieht der Nutzer noch nichtmal den Account. Da man selbst auch keinen Zugriff auf den Microsoft Account Namen hat ist es schwer dem User zu vermitteln mit welchem Account er überhaupt gerade arbeitet.</p>
<p>- Logout ist auch schwieriger – aber ich zeig gleich eine Variante wie es gehen könnte (die ich jetzt nicht umgesetzt hab)</p>
<p>Das Gute an der Variante: Es ist ein sehr simpler Link mit einem Callback…</p>
<p><strong>Noch zur Variante 2:</strong></p>
<p>Dort wird ein Link zu einem JSON angeboten was man recht einfach auswerten kann – mit allen Identity Providern und den richtigen Login-URLs sowie der Logout URL.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1814.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb967.png" width="557" height="154"></a> </p>
<p>Bei dieser LoginUrl (die direkt auf login.live etc. zeigt) wird auch der Parameter “wfresh=0” unterstützt – d.h. der Nutzer muss sich explizit vorher anmelden – was schon wesentlich besser ist.</p>
<p><strong>Zum Callback:</strong></p>
<p>Nachdem die Authentifizierung durch ist schickt der Access Control Service die Antwort zum eingetragenen Callback URL – darin enthalten ist ein XML:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">&lt;t:RequestSecurityTokenResponse xmlns:t="http://schemas.xmlsoap.org/ws/2005/02/trust"&gt;
	&lt;t:Lifetime&gt;
		&lt;wsu:Created xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd"&gt;2013-04-08T23:49:21.754Z&lt;/wsu:Created&gt;
		&lt;wsu:Expires xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd"&gt;2013-04-08T23:59:21.754Z&lt;/wsu:Expires&gt;
	&lt;/t:Lifetime&gt;
	&lt;wsp:AppliesTo xmlns:wsp="http://schemas.xmlsoap.org/ws/2004/09/policy"&gt;
		&lt;EndpointReference xmlns="http://www.w3.org/2005/08/addressing"&gt;
			&lt;Address&gt;urn:sample:wifless&lt;/Address&gt;
		&lt;/EndpointReference&gt;
	&lt;/wsp:AppliesTo&gt;
	&lt;t:RequestedSecurityToken&gt;
		&lt;wsse:BinarySecurityToken wsu:Id="_d3b3e3f6-4bd2-424c-89e9-ebbe662c1305-E64ACB699C73604D58CEA265FE69ECA9" ValueType="urn:ietf:params:oauth:token-type:jwt" EncodingType="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-soap-message-security-1.0#Base64Binary" xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd" xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"&gt;ZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKU1V6STFOaUlzSW5nMWRDSTZJamRUZDFaRmMyNHpVbW93YW5WblNWUjBWRlp4WjJwQ1VVWlJVU0o5LmV5SmhkV1FpT2lKMWNtNDZjMkZ0Y0d4bE9uZHBabXhsYzNNaUxDSnBjM01pT2lKb2RIUndjem92TDJOdlpHVnBibk5wWkdVdVlXTmpaWE56WTI5dWRISnZiQzUzYVc1a2IzZHpMbTVsZEM4aUxDSnVZbVlpT2pFek5qVTBOalE1TmpFc0ltVjRjQ0k2TVRNMk5UUTJOVFUyTVN3aWJtRnRaV2xrSWpvaVMwMVpOR3A1ZUdGSFRWWllZbkl3V2xsRE9DOXJlUzlFTjJabWNXRTBZM1Z0U3pKQ1dFNWxWRUZIV1QwaUxDSnBaR1Z1ZEdsMGVYQnliM1pwWkdWeUlqb2lkWEpwT2xkcGJtUnZkM05NYVhabFNVUWlmUS5VeDFsa0hDaDdBYl85d2lQN1BnR20zNjR4T2tsOHBHUEhNSEF2ZVJSMEVGRTR2VHRybV9wbmF3ajR0STVQZlVFOXB1d1JYNDQzOWRhSkQ4MzM4SG5yOVI1VktmZ3JIYnRuTlM2UVJoeGNIUDREZjBINVFQcFZ2Tm9VU1lJa2ZLWTVFUXE5ei1JVEpiNVZhWEZscF81OENUaDJtMkVYYkIwR3pRLV9BQlF3MWIxZEd1dHV5VHVfdEhWWUdPek9iTDdac0l1dHJXQTdjOEtJYUpoT21NVzNxNEp4RVBLNllnTURERWxkcmR6OFRTVTFZVE8xY3ZqMGZZVHh3d0t3MVlFQmlEamJSLUVxN1FKQzZDZWRsZjJmaDRDbkNBQlFTZzlhbmRVSDZSeTBqU3ctX2tZaHBZOTdkdkpRRDh4eDY2eVMxQmZBNXViQlVMbXF6eWh3U2NYaXc=&lt;/wsse:BinarySecurityToken&gt;
	&lt;/t:RequestedSecurityToken&gt;
	&lt;t:TokenType&gt;urn:ietf:params:oauth:token-type:jwt&lt;/t:TokenType&gt;
	&lt;t:RequestType&gt;http://schemas.xmlsoap.org/ws/2005/02/trust/Issue&lt;/t:RequestType&gt;
	&lt;t:KeyType&gt;http://schemas.xmlsoap.org/ws/2005/05/identity/NoProofKey&lt;/t:KeyType&gt;
&lt;/t:RequestSecurityTokenResponse&gt;</pre>
<p>Interessant hier ist der “BinarySecurityToken”, wenn wir diesen base64 kodierten String umwandeln bekommen wird dies:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IjdTd1ZFc24zUmowanVnSVR0VFZxZ2pCUUZRUSJ9.eyJhdWQiOiJ1cm46c2FtcGxlOndpZmxlc3MiLCJpc3MiOiJodHRwczovL2NvZGVpbnNpZGUuYWNjZXNzY29udHJvbC53aW5kb3dzLm5ldC8iLCJuYmYiOjEzNjU0NjQ5NjEsImV4cCI6MTM2NTQ2NTU2MSwibmFtZWlkIjoiS01ZNGp5eGFHTVZYYnIwWllDOC9reS9EN2ZmcWE0Y3VtSzJCWE5lVEFHWT0iLCJpZGVudGl0eXByb3ZpZGVyIjoidXJpOldpbmRvd3NMaXZlSUQifQ.Ux1lkHCh7Ab_9wiP7PgGm364xOkl8pGPHMHAveRR0EFE4vTtrm_pnawj4tI5PfUE9puwRX4439daJD8338Hnr9R5VKfgrHbtnNS6QRhxcHP4Df0H5QPpVvNoUSYIkfKY5EQq9z-ITJb5VaXFlp_58CTh2m2EXbB0GzQ-_ABQw1b1dGutuyTu_tHVYGOzObL7ZsIutrWA7c8KIaJhOmMW3q4JxEPK6YgMDDEldrdz8TSU1YTO1cvj0fYTxwwKw1YEBiDjbR-Eq7QJC6Cedlf2fh4CnCABQSg9andUH6Ry0jSw-_kYhpY97dvJQD8xx66yS1BfA5ubBULmqzyhwScXiw</pre>
<p>Nun kommt ein NuGet Package ins Spiel – <a href="https://nuget.org/packages/Microsoft.IdentityModel.Tokens.JWT">der JWTSecurityTokenHandler</a> über dies und etwas Code (basierend auf diesem <a href=" http://code.msdn.microsoft.com/AAL-Native-Application-to-fd648dcf/sourcecode?fileId=62849&amp;pathId=697488104">Microsoft Sample</a>) bekommen wir am Ende die Claims als ClaimsPrincipal:</p>
<p>
<strong>Update: In der aktuellen (21.08.2013) Fassung des JWTSecurityTokenHandler gab es ein paar Änderung.</strong> <br/> Die erste: Aus JWTSec... wurde JwtSecurity. <br/>
Die größere Änderung: Der TokenHandler prüft ob ein X.509 Zertifkat im Zertifikatsstore enthalten ist. Wenn man diesen Check nicht machen möchte muss man dem Handler dies zuweisen: "tokenHandler.CertificateValidator = X509CertificateValidator.None;". Dieser Punkt ist auch <a href="http://social.msdn.microsoft.com/forums/windowsazure/fr-fr/730dedff-6ff6-4705-9834-ae92c2339b45/unable-to-use-json-web-token-handler-ga-with-windows-store-and-rest-scenario">hier</a> und <a href="http://social.msdn.microsoft.com/forums/windowsazure/it-it/73a5cd24-a87f-4aec-8e03-0322fcc99f1f/jwt-systemidentitymodeltokensjwt-new-release-100">hier </a>näher beschrieben.
</p>
<pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">/// &lt;summary&gt;
    /// Based on this sample: http://code.msdn.microsoft.com/AAL-Native-Application-to-fd648dcf/sourcecode?fileId=62849&amp;pathId=697488104
    /// &lt;/summary&gt;
    public class AcsAuthorizationTokenValidator
    {
        /// &lt;summary&gt;
        /// 
        /// &lt;/summary&gt;
        /// &lt;param name="token"&gt;= Token&lt;/param&gt;
        /// &lt;param name="allowedAudience"&gt;= Azure ACS Namespace&lt;/param&gt;
        /// &lt;param name="issuers"&gt;= RPs in ACS&lt;/param&gt;
        /// &lt;returns&gt;&lt;/returns&gt;
        public static ClaimsPrincipal RetrieveClaims(string token, string issuer, List&lt;string&gt; allowedAudiences)
        {
            JWTSecurityTokenHandler tokenHandler = new JWTSecurityTokenHandler();

            // Set the expected properties of the JWT token in the TokenValidationParameters 
            TokenValidationParameters validationParameters = new TokenValidationParameters()
                                                                 {
                                                                     AllowedAudiences = allowedAudiences,
                                                                     ValidIssuer = issuer,
                                                                     SigningToken = new X509SecurityToken(new X509Certificate2(GetSigningCertificate(issuer + "FederationMetadata/2007-06/FederationMetadata.xml")))
                                                                 };

            return tokenHandler.ValidateToken(token, validationParameters); 
        }

        private static byte[] GetSigningCertificate(string metadataAddress)
        {
            if (metadataAddress == null)
            {
                throw new ArgumentNullException(metadataAddress);
            }

            using (XmlReader metadataReader = XmlReader.Create(metadataAddress))
            {
                MetadataSerializer serializer = new MetadataSerializer()
                                                    {
                                                        CertificateValidationMode = X509CertificateValidationMode.None
                                                    };

                EntityDescriptor metadata = serializer.ReadMetadata(metadataReader) as EntityDescriptor;

                if (metadata != null)
                {
                    SecurityTokenServiceDescriptor stsd = metadata.RoleDescriptors.OfType&lt;SecurityTokenServiceDescriptor&gt;().First();

                    if (stsd != null)
                    {
                        X509RawDataKeyIdentifierClause clause = stsd.Keys.First().KeyInfo.OfType&lt;X509RawDataKeyIdentifierClause&gt;().First();

                        if (clause != null)
                        {
                            return clause.GetX509RawData();
                        }
                        throw new Exception("The SecurityTokenServiceDescriptor in the metadata does not contain the Signing Certificate in the &lt;X509Certificate&gt; element");
                    }
                    throw new Exception("The Federation Metadata document does not contain a SecurityTokenServiceDescriptor");
                }
                throw new Exception("Invalid Federation Metadata document");
            }
        } 
    }</pre>
<p><strong>Ergebnis:</strong></p>
<p>Claims…von Microsoft! Leider keine “menschlich-lesbaren” – aber immerhin gibt es dabei kein Datenschutz Risiko ;)</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1815.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb968.png" width="576" height="200"></a> </p>
<h3></h3>
<h3>ACS to the rescue!</h3>
<p>Der Access Control Service ist ein recht interessanter Dienst und steht auch in keiner Konkurrenz zum Azure AD – man kann auch <a href="http://www.cloudidentity.com/blog/2012/11/07/PROVISIONING-A-DIRECTORY-TENANT-AS-AN-IDENTITY-PROVIDER-IN-AN-ACS-NAMESPACE/">Azure AD und Facebook in seiner Anwendung über den ACS</a> nutzen. Stellt es euch als Plugin-fähigen Identitiy Provider vor.</p>
<p>Ich versuch demnächst noch zum neuen “Azure AD” zu schreiben – bis dahin können interssierte ein Blick hier reinwerfen wenn man <a href="http://azurecoder.azurewebsites.net/using-windows-azure-active-directory-waad-part-1-setup/">ACS und Azure Active Directory zusammen</a> nutzen möchte.</p>
<p>&nbsp;</p>
<p><a href="https://github.com/Code-Inside/Samples/tree/master/2013/AcsJustMicrosoftAccMvc"><strong>Download Sample @ GitHub</strong></a></p>
