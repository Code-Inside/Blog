---
layout: post
title: "HowTo: Cascading Dropdowns mit ASP.NET MVC"
date: 2010-02-03 01:35
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, Cascading, DropDown]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image914.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="174" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb99.png" width="136" align="left" border="0"></a> Wenn zwei oder mehrere Eingabefelder, wie z.B. Dropdowns, durch eine bestimmte Auswahl logisch miteinander verknüpfen will, braucht man einen kleinen Mechanismus. Ich habe das ganze mit Javascript, AJAX und ASP.NET MVC gelöst und stelle die recht simple Lösung vor.</p> <p>&nbsp;</p><!--more--> <p><strong>Cascading? Ein Bild sagt mehr als tausend Worte</strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image915.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="98" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb100.png" width="244" align="left" border="0"></a><a href="http://www.asp.net/AJAX/AjaxControlToolkit/Samples/CascadingDropDown/CascadingDropDown.aspx">Die drei Selectboxen</a> stehen in Beziehung zueinander. Erst wenn man die Automarke ausgewählt hat, kann man das Modell auswählen und erst am Ende die Farbe -&gt; Logisch. </p> <p><strong>Zu meinem BeispieL</strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image916.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="107" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb101.png" width="244" align="left" border="0"></a> Nicht ganz so hübsch aussehen, aber ähnliches Prinzip. Erst Landauswählen, dann Bundesland, dann Stadt und am Ende die Straße.</p> <p>&nbsp;</p> <p>Diese Struktur habe ich so auch in meinem Models Ordner, wobei Straßen nur simple Strings sind und ich den deshalb keine eigene Klasse spendiert habe. </p> <p><a href="{{BASE_PATH}}/assets/wp-images/image917.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="137" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb102.png" width="211" border="0"></a>&nbsp;</p> <p>Das LocationRepository erzeugt mir ein paar Dummydaten:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:4cd89d7c-065c-4398-b51f-b7977cdab8de" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class LocationRepository
    {
        public static IList&lt;Country&gt; GetCountries()
        {
            List&lt;Country&gt; countries = new List&lt;Country&gt;();

            for (int i = 0; i &lt; 5; i++)
            {
                Country country = new Country();
                country.Name = "Country " + i.ToString();
                countries.Add(country);
            }

            return countries;
        }

        public static IList&lt;FederalStates&gt; GetFederalStates(string countryName)
        {
            List&lt;FederalStates&gt; states = new List&lt;FederalStates&gt;();

            for (int i = 0; i &lt; 5; i++)
            {
                FederalStates state = new FederalStates();
                state.Name = countryName + " - FederalState " + i.ToString();
                states.Add(state);
            }

            return states;
        }

        public static IList&lt;City&gt; GetCities(string federalStateName)
        {
            List&lt;City&gt; cities = new List&lt;City&gt;();

            for (int i = 0; i &lt; 5; i++)
            {
                City city = new City();
                city.Name = federalStateName + " - City " + i.ToString();
                cities.Add(city);
            }

            return cities;
        }

        public static IList&lt;string&gt; GetStreets(string cityName)
        {
            List&lt;string&gt; streets = new List&lt;string&gt;();

            for (int i = 0; i &lt; 5; i++)
            {
                string street = cityName + " - Street " + i.ToString();
                streets.Add(street);
            }

            return streets;
        }
    }</pre></div>
<p>Prinzip ist immer: Ich geb den Namen des höheren Elementes rein und die kleinen Helper bauen mir die entsprechenden Elemente.</p>
<p><strong>Das HomeViewModel</strong></p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:22e8dfcd-0555-492d-a908-0fc097273478" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class HomeViewModel
    {
        public IList&lt;SelectListItem&gt; Countries { get; set; }
        public IList&lt;SelectListItem&gt; FederalStates { get; set; }
        public IList&lt;SelectListItem&gt; Cities { get; set; }
        public IList&lt;SelectListItem&gt; Streets { get; set; }

        public HomeViewModel()
        {
            this.Countries = new List&lt;SelectListItem&gt;();
            this.Countries.Add(new SelectListItem() { Text = "Please choose...", Value = ""});
            this.FederalStates = new List&lt;SelectListItem&gt;();
            this.FederalStates.Add(new SelectListItem() { Text = "Please choose...", Value = "" });
            this.Cities = new List&lt;SelectListItem&gt;();
            this.Cities.Add(new SelectListItem() { Text = "Please choose...", Value = "" });
            this.Streets = new List&lt;SelectListItem&gt;();
            this.Streets.Add(new SelectListItem() { Text = "Please choose...", Value = "" });
        }
    }</pre></div>
<p>Hier speichern wir unsere 4 Listen und noch einen Default Value.</p>
<p><strong>Der Controller</strong></p>
<p></p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:9cc3007b-c6a2-4151-9865-82a4e21eabf6" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    [HandleError]
    public class HomeController : Controller
    {
        private HomeViewModel GetHomeViewModel(string country, string federalState, string city, string street)
        {
            HomeViewModel model = new HomeViewModel();

            IList&lt;Country&gt; countries = LocationRepository.GetCountries();
            foreach (Country countryItem in countries)
            {
                SelectListItem item = new SelectListItem();
                item.Text = countryItem.Name;
                item.Value = countryItem.Name;
                model.Countries.Add(item);
            }

            if(string.Empty != country)
            {
                IList&lt;FederalStates&gt; fedStates = LocationRepository.GetFederalStates(country);
                foreach (FederalStates fedItem in fedStates)
                {
                    SelectListItem item = new SelectListItem();
                    item.Text = fedItem.Name;
                    item.Value = fedItem.Name;
                    model.FederalStates.Add(item);
                }
            }

            if(string.Empty != federalState)
            {
                IList&lt;City&gt; cities = LocationRepository.GetCities(federalState);
                foreach (City cityItem in cities)
                {
                    SelectListItem item = new SelectListItem();
                    item.Text = cityItem.Name;
                    item.Value = cityItem.Name;
                    model.Cities.Add(item);
                }
            }

            if(string.Empty != city)
            {
                IList&lt;string&gt; streets = LocationRepository.GetStreets(city);
                foreach (string streetItem in streets)
                {
                    SelectListItem item = new SelectListItem();
                    item.Text = streetItem;
                    item.Value = streetItem;
                    model.Streets.Add(item);
                }
            }

            return model;
        }

        public ActionResult Index()
        {
            HomeViewModel model = this.GetHomeViewModel(string.Empty, string.Empty,string.Empty,string.Empty);
            return View(model);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Index(string country, string federalState, string city, string street)
        {
            ViewData.ModelState.AddModelError("Message", "Uppps...!");
            HomeViewModel model = this.GetHomeViewModel(country, federalState, city, street);
            return View(model);
        }

        public JsonResult GetFederalStatesJson(string country)
        {
            IList&lt;FederalStates&gt; fedStates = LocationRepository.GetFederalStates(country);
            return Json(fedStates);
        }

        public JsonResult GetCitiesJson(string federalState)
        {
            IList&lt;City&gt; cities = LocationRepository.GetCities(federalState);
            return Json(cities);
        }

        public JsonResult GetStreetsJson(string cityName)
        {
            IList&lt;string&gt; streets = LocationRepository.GetStreets(cityName);
            return Json(streets);
        }
    }</pre></div>
<p></p>
<p>Die 3 Json Actions sprechen mit dem Repository und geben mir die gewünschten Elemente wieder. Dann gibt es noch zwei Index-Actions. Einmal für POST und einmal für einen GET Aufruf. </p>
<ul>
<li>Bei <strong>GET</strong> wird eine leere Liste zurückgegeben. Wir holen uns das Viewmodel und geben nur die erste Ebene, in meinem Fall die Länder, zurück.</li>
<li>Bei <strong>POST</strong> könnte ja während der Bearbeitung ein Fehler auftreten. Daher schreibe ich dort eine Fehlermeldung in den ModelState. Jetzt übergebe ich alle ausgewählten Daten meiner kleinen "GetHomeViewModel" Methode und lade mir die Daten die ich für den Anzeigen des Views brauche. <strong>Vorteil:</strong> Die Auswahl die der Nutzer getroffen hat geht nicht verloren.</li></ul>
<p>Das war es eigentlich auch schon im Controller. Natürlich könnte man das alles noch schöner oder generischer bauen, das soll aber auch nur zur Inspiration dienen ;)</p>
<p><strong>Jetzt der View</strong></p>
<p>Das Formular, wobei unser View mit dem HomeViewModel typsiert ist:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d8f2779d-c251-4314-9fb0-0afe0c3fe8f5" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    &lt;% using(Html.BeginForm()) { %&gt;
    &lt;div&gt;
        &lt;fieldset&gt;
            &lt;legend&gt;Country/FederalState/City/Street Selection&lt;/legend&gt;
            &lt;p&gt;
                &lt;%=Html.ValidationMessage("Message") %&gt;
            &lt;/p&gt;
            &lt;p&gt;
                &lt;lable&gt;Country&lt;/lable&gt;
                &lt;%=Html.DropDownList("Country",Model.Countries, new { id = "CountrySelection", onchange="changeCountry()" }) %&gt; 
            &lt;/p&gt;
            &lt;p&gt;
                &lt;lable&gt;Federal States&lt;/lable&gt;
                &lt;%=Html.DropDownList("FederalState", Model.FederalStates, new { id = "FedStateSelection", onchange = "changeFederalState()" })%&gt; 
            &lt;/p&gt;
            &lt;p&gt;
                &lt;lable&gt;City&lt;/lable&gt;
                &lt;%=Html.DropDownList("City", Model.Cities, new { id = "CitySelection", onchange = "changeCity()" })%&gt; 
            &lt;/p&gt;
            &lt;p&gt;
                &lt;lable&gt;Street&lt;/lable&gt;
                &lt;%=Html.DropDownList("Street", Model.Streets, new { id = "StreetSelection" })%&gt; 
            &lt;/p&gt;
            &lt;button type="submit"&gt;Submit!&lt;/button&gt;
        &lt;/fieldset&gt;
    &lt;/div&gt;
    &lt;%} %&gt;</pre></div>
<p>Wir registrieren bei jeden Dropdown, bis auf die letzte Ebene, JavascriptEventhandler und geben unser ViewModel als Value jeweils mit rien. </p>
<p><strong>Das Javascript</strong></p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a209c201-17e0-47ce-a1e7-455e3961b42d" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;script type="text/javascript"&gt;

        function resetSelection(element) {
            element.empty();
            element.append("&lt;option value=''&gt;Please choose...&lt;/option&gt;");
        }
        

        function changeCountry() {
            resetSelection($("#FedStateSelection"));
            resetSelection($("#CitySelection"));
            resetSelection($("#StreetSelection"));

            if ($("#CountrySelection").val() != "") {
                var url = "&lt;%=Url.Action("GetFederalStatesJson") %&gt;?country=" + $("#CountrySelection").val();
                $.getJSON(url, null, function(data) {
                    $.each(data, function(index, optionData) {
                        $("#FedStateSelection").append("&lt;option value='"
                         + optionData.Name
                         + "'&gt;" + optionData.Name
                         + "&lt;/option&gt;");
                    });
                });
            }
        }

        function changeFederalState() {
            resetSelection($("#CitySelection"));
            resetSelection($("#StreetSelection"));

            if ($("#FedStateSelection").val() != "") {
                var url = "&lt;%=Url.Action("GetCitiesJson") %&gt;?federalState=" + $("#FedStateSelection").val();
                $.getJSON(url, null, function(data) {
                    $.each(data, function(index, optionData) {
                        $("#CitySelection").append("&lt;option value='"
                         + optionData.Name
                         + "'&gt;" + optionData.Name
                         + "&lt;/option&gt;");
                    });
                });
            }
            
        }

        function changeCity() {
            resetSelection($("#StreetSelection"));

            if ($("#CitySelection").val() != "") {
                var url = "&lt;%=Url.Action("GetStreetsJson") %&gt;?cityName=" + $("#CitySelection").val();
                $.getJSON(url, null, function(data) {
                    $.each(data, function(index, optionData) {
                        $("#StreetSelection").append("&lt;option value='"
                         + optionData
                         + "'&gt;" + optionData
                         + "&lt;/option&gt;");
                    });
                });
            }
        }
    
    &lt;/script&gt;</pre></div>
<p>Auch dies könnte sicherlich nocht etwas schöner gestaltet werden, funktioniert aber erstmal und war ein Prototyp. Bei jedem changeXXX löschen wir die Daten der darunterliegenden Felder, da diese ja in Beziehung stehen und laden die Daten des direkten Kindelementes. </p>
<p>Auch hier habe ich für die URLs die URL Helper genommen. Näheres dazu in <a href="{{BASE_PATH}}/2010/01/22/howto-asp-net-mvc-und-verlinkung-von-javascript-jquery-css-images-etc/">diesem Blogpost</a>.</p>
<p><strong>Im Fehlerfall</strong></p>
<p>Nun hat der User seine Auswahl getroffen und drückt auf "Submit". Wir übertragen die ausgewählten Daten und laden diese im Backend neu und zeigen wieder den View an. Damit bleiben seine gewählten Daten erhalten und der User freut sich:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image918.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="135" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb103.png" width="244" border="0"></a> </p>
<p>*Submit* *Irgendwas läuft schief*</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image919.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="137" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb104.png" width="244" border="0"></a> </p>
<p>:)</p>
<p>Ich würde es jetzt nicht unbedingt als "Control" bezeichnen, da es noch zu viel "Detailimplementierung" benötigt, aber wer es braucht: Es funktioniert recht zuverlässig :)</p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/mvccascadingdropdownjson/mvccascadingdropdownjson.zip">[ Download Democode ]</a></strong></p>
