---
layout: post
title: "HowTo: ASP.NET Chart Controls mit ASP.NET MVC nutzen"
date: 2008-11-27 01:39
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET, ASP.NET MVC, Charting, Charts, Diagrams, HowTo, MVC]
---
<p>Microsoft hat heute ein neues kleines ASP.NET Feature ver&#246;ffentlicht. Die Rede ist von den <a href="http://weblogs.asp.net/scottgu/archive/2008/11/24/new-asp-net-charting-control-lt-asp-chart-runat-quot-server-quot-gt.aspx">ASP.NET Chart Controls</a> (welche zum Teil auf den <a href="http://dundas.com/">Dundas Charts basieren</a>).     <br />Diese Controls schauen eigentlich ziemlich nett aus:</p> <a href="{{BASE_PATH}}/assets/wp-images/image569.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="354" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb547.png" width="498" border="0" /></a>   <p>Das beste daran: Es funktioniert mit 2 Tricks auch recht gut mit ASP.NET MVC.</p>  <p><strong>Download Links f&#252;r die ASP.NET Charts (alles kostenlos) :</strong></p>  <ul>   <li><a href="http://www.microsoft.com/downloads/details.aspx?FamilyID=130f7986-bf49-4fe5-9ca8-910ae6ea442c&amp;DisplayLang=en">Download the free Microsoft Chart Controls</a></li>    <li><a href="http://www.microsoft.com/downloads/details.aspx?familyid=1D69CE13-E1E5-4315-825C-F14D33A303E9&amp;displaylang=en">Download the VS 2008 Tool Support for the Chart Controls</a></li>    <li><a href="http://code.msdn.microsoft.com/mschart/Release/ProjectReleases.aspx?ReleaseId=1591">Download the Microsoft Chart Controls Samples</a></li>    <li><a href="http://www.microsoft.com/downloads/details.aspx?FamilyId=EE8F6F35-B087-4324-9DBA-6DD5E844FD9F&amp;displaylang=en">Download the Microsoft Chart Controls Documentation</a></li> </ul>  <p><strong>Web.Config editieren</strong></p>  <p>Unter &quot;&lt;system.web&gt;&lt;pages&gt;&lt;controls&gt;&quot; dieses hinzuf&#252;gen:</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:9adfab10-0fa6-4131-92fe-1a259b53eecc" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;add tagPrefix="asp" namespace="System.Web.UI.DataVisualization.Charting" assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"/&gt;</pre></div>

<p>Und unter den &quot;&lt;httpHandlers&gt;&quot; folgendes:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ab2233f7-9ee6-4377-b0ac-5cafa88ec17b" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;add path="ChartImg.axd" verb="GET,HEAD" type="System.Web.UI.DataVisualization.Charting.ChartHttpHandler, System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" validate="false"/&gt;</pre></div>

<p><em>Meine Quelle: <a href="http://weblogs.asp.net/melvynharbour/archive/2008/11/25/combining-asp-net-mvc-and-asp-net-charting-controls.aspx">Combining ASP.NET MVC and ASP.NET Charting Controls</a></em></p>

<p><strong>Chart Control hinzuf&#252;gen:</strong></p>

<p><strong><u>Variante A: ASP.NET Control + Code behind</u></strong>

  <br />Bei dieser Variante muss man ein paar Zeilen Code in der Code behind hinzuf&#252;gen, allerdings sollte die gesamten Daten vom Controller kommen, sodass man dies noch als OK ansehen kann.

  <br />Ich habe dabei das &quot;GettingStartet&quot; Control aus den Samples genommen.</p>

<p>Index.aspx:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:edbf7da6-ca78-411a-af53-412433c03597" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;asp:chart id="Chart1" runat="server" Height="296px" Width="412px" Palette="BrightPastel" imagetype="Png" BorderDashStyle="Solid" BackSecondaryColor="White" BackGradientStyle="TopBottom" BorderWidth="2" backcolor="#D3DFF0" BorderColor="26, 59, 105"&gt;
	&lt;Titles&gt;
		&lt;asp:Title Text="With datasource in code behind" /&gt;
	&lt;/Titles&gt;
	&lt;legends&gt;
		&lt;asp:Legend IsTextAutoFit="False" Name="Default" BackColor="Transparent" Font="Trebuchet MS, 8.25pt, style=Bold"&gt;&lt;/asp:Legend&gt;
	&lt;/legends&gt;
	&lt;borderskin skinstyle="Emboss"&gt;&lt;/borderskin&gt;
	&lt;series&gt;
		&lt;asp:Series Name="Column" BorderColor="180, 26, 59, 105"&gt;
		&lt;/asp:Series&gt;
	&lt;/series&gt;
	&lt;chartareas&gt;
		&lt;asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BorderDashStyle="Solid" BackSecondaryColor="White" BackColor="64, 165, 191, 228" ShadowColor="Transparent" BackGradientStyle="TopBottom"&gt;
			&lt;area3dstyle Rotation="10" perspective="10" Inclination="15" IsRightAngleAxes="False" wallwidth="0" IsClustered="False"&gt;&lt;/area3dstyle&gt;
			&lt;axisy linecolor="64, 64, 64, 64"&gt;
				&lt;labelstyle font="Trebuchet MS, 8.25pt, style=Bold" /&gt;
				&lt;majorgrid linecolor="64, 64, 64, 64" /&gt;
			&lt;/axisy&gt;
			&lt;axisx linecolor="64, 64, 64, 64"&gt;
				&lt;labelstyle font="Trebuchet MS, 8.25pt, style=Bold" /&gt;
				&lt;majorgrid linecolor="64, 64, 64, 64" /&gt;
			&lt;/axisx&gt;
		&lt;/asp:ChartArea&gt;
	&lt;/chartareas&gt;
&lt;/asp:chart&gt;</pre></div>

<p>Was das genau bedeuted kann in der Doku nachgelesen werden, wichtig ist, dass wir eine &quot;Serie&quot; namens &quot;<strong>Column</strong>&quot; haben - dies repr&#228;sentiert sp&#228;ter unseren Balken auf dem Balkendiagram.</p>

<p>Index.aspx.cs:</p>

<p>
  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b5daf32c-7014-43dd-8c2c-8907cf56ca1d" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public partial class Index : ViewPage
    {
        protected void Page_Load(object sender, System.EventArgs e)
        {
            foreach (int value in (List&lt;int&gt;)this.ViewData["Chart"])
            {
                this.Chart1.Series["Column"].Points.Add(value);
            }
        }
    }</pre></div>
</p>

<p>Ergebnis:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image570.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="264" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb548.png" width="361" border="0" /></a> </p>

<p><strong><u>Variante B: Inline ASP.NET Control</u></strong></p>

<p>Ohne Codebehind, direkt auf der Seite mit Inline Code:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:89f9b4c7-1693-427f-a00c-a312af8ef71f" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        &lt;p&gt;
        &lt;%
						System.Web.UI.DataVisualization.Charting.Chart Chart2 = new System.Web.UI.DataVisualization.Charting.Chart();
                        Chart2.Width = 412;
                        Chart2.Height = 296;
                        Chart2.RenderType = RenderType.ImageTag;

                        Chart2.Palette = ChartColorPalette.BrightPastel;
                        Title t = new Title("No Code Behind Page", Docking.Top, new System.Drawing.Font("Trebuchet MS", 14, System.Drawing.FontStyle.Bold), System.Drawing.Color.FromArgb(26, 59, 105));
                        Chart2.Titles.Add(t);
                        Chart2.ChartAreas.Add("Series 1");

						// create a couple of series
                        Chart2.Series.Add("Series 1");
                        Chart2.Series.Add("Series 2");
						
						// add points to series 1
                        foreach (int value in (List&lt;int&gt;)ViewData["Chart"])
                        {
                            Chart2.Series["Series 1"].Points.AddY(value); 
                        }

                        // add points to series 2
                        foreach (int value in (List&lt;int&gt;)ViewData["Chart"])
                        {
                            Chart2.Series["Series 2"].Points.AddY(value + 1);
                        }

                        Chart2.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;
                        Chart2.BorderColor = System.Drawing.Color.FromArgb(26, 59, 105);
                        Chart2.BorderlineDashStyle = ChartDashStyle.Solid;
                        Chart2.BorderWidth = 2;

                        Chart2.Legends.Add("Legend1");

						// Render chart control
                        Chart2.Page = this;
						HtmlTextWriter writer = new HtmlTextWriter(Page.Response.Output);
						Chart2.RenderControl(writer);
					
                     %&gt;
        &lt;/p&gt;</pre></div>

<p>Ergebnis:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image571.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="240" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb549.png" width="334" border="0" /></a> </p>

<p><strong>Beide Controls zusammen:</strong></p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image572.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="409" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb550.png" width="291" border="0" /></a> </p>

<p><strong><a href="http://{{BASE_PATH}}/assets/files/democode/mvccharting/mvccharting.zip">[ Download Source Code ]</a></strong></p>
