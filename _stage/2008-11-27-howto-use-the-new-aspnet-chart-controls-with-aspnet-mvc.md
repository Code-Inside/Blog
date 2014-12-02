---
layout: post
title: "HowTo: Use the new ASP.NET Chart Controls with ASP.NET MVC"
date: 2008-11-27 02:55
author: codemin
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, Charting, Charts, HowTo, Microsoft, MVC]
---
{% include JB/setup %}
<p>Microsoft released today a new feature for ASP.NET - <a href="http://weblogs.asp.net/scottgu/archive/2008/11/24/new-asp-net-charting-control-lt-asp-chart-runat-quot-server-quot-gt.aspx">free chart controls</a> (which are based on the <a href="http://dundas.com/">Dundas Chart Controls</a>). There are many nice looking charts in this download included:</p> <a href="http://code-inside.de/blog-in/wp-content/uploads/image-thumb211.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="329" alt="image_thumb[2]" src="http://code-inside.de/blog-in/wp-content/uploads/image-thumb2-thumb1.png" width="459" border="0" /></a>   <p>The best thing is: It should work with ASP.NET MVC!</p>  <p><strong>Download links for the ASP.NET Charts (free) :</strong></p>  <ul>   <li><a href="http://www.microsoft.com/downloads/details.aspx?FamilyID=130f7986-bf49-4fe5-9ca8-910ae6ea442c&amp;DisplayLang=en">Download the free Microsoft Chart Controls</a> </li>    <li><a href="http://www.microsoft.com/downloads/details.aspx?familyid=1D69CE13-E1E5-4315-825C-F14D33A303E9&amp;displaylang=en">Download the VS 2008 Tool Support for the Chart Controls</a> </li>    <li><a href="http://code.msdn.microsoft.com/mschart/Release/ProjectReleases.aspx?ReleaseId=1591">Download the Microsoft Chart Controls Samples</a> </li>    <li><a href="http://www.microsoft.com/downloads/details.aspx?FamilyId=EE8F6F35-B087-4324-9DBA-6DD5E844FD9F&amp;displaylang=en">Download the Microsoft Chart Controls Documentation</a> </li> </ul>  <p><strong>Edit the Web.Config      <br /></strong>To enable the controls you have to edit the web.config file.     <br />Add this under the controls tag (<em>path: &quot;&lt;system.web&gt;&lt;pages&gt;&lt;controls&gt;&quot;</em>) :</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:df63fe1d-044f-451f-ad59-254edc2af360" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;add tagPrefix="asp" namespace="System.Web.UI.DataVisualization.Charting" assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"/&gt;</pre></div>

<p>And add this httpHandler (<em>under &quot;&lt;httpHandlers&gt;&quot;</em>) :</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:097866ed-94a4-49a4-98cf-a60639f533ea" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;add path="ChartImg.axd" verb="GET,HEAD" type="System.Web.UI.DataVisualization.Charting.ChartHttpHandler, System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" validate="false"/&gt;</pre></div>

<br /><em>Via: <a href="http://weblogs.asp.net/melvynharbour/archive/2008/11/25/combining-asp-net-mvc-and-asp-net-charting-controls.aspx">Combining ASP.NET MVC and ASP.NET Charting Controls</a></em> 

<p><strong>Add a chart control to a view:</strong></p>

<p><strong><u>Option A: ASP.NET Control + Code behind</u></strong> 

  <br />If you use this option, you will have to add some code lines in the code behind file of your view. This shouldn&#180;t be a big problem, because the controller is still responsible for the logic. 

  <br />I took the &quot;GettingStarted&quot; Control from the samples:</p>

<p>Index.aspx:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:eaaf1fa2-e982-4a55-8969-1bde197f4576" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;asp:chart id="Chart1" runat="server" Height="296px" Width="412px" Palette="BrightPastel" imagetype="Png" BorderDashStyle="Solid" BackSecondaryColor="White" BackGradientStyle="TopBottom" BorderWidth="2" backcolor="#D3DFF0" BorderColor="26, 59, 105"&gt;
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

<p>I don&#180;t know the exactly meaning of each line (read the documentation to lern more about it), but the important point is that we have a &quot;Serie&quot; with name &quot; &quot;<strong>Column</strong>&quot; - this will represent your data as a bar in your bar chart.</p>

<p>Index.aspx.cs:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c1cdf0c4-925b-440c-9e8b-c4f4681bc299" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public partial class Index : ViewPage
    {
        protected void Page_Load(object sender, System.EventArgs e)
        {
            foreach (int value in (List&lt;int&gt;)this.ViewData["Chart"])
            {
                this.Chart1.Series["Column"].Points.Add(value);
            }
        }
    }</pre></div>

<p></p>

<p></p>

<p>Result:</p>

<p><a href="http://code-inside.de/blog-in/wp-content/uploads/image-thumb41.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="246" alt="image_thumb[4]" src="http://code-inside.de/blog-in/wp-content/uploads/image-thumb4-thumb.png" width="334" border="0" /></a> </p>

<p><strong><u>Option B: Inline ASP.NET Control</u></strong></p>

<p>You could also create the control without a code behind file, just create the control on the fly via inline code:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:978c0f32-5e2a-4d51-9241-4d3827904d13" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        &lt;p&gt;
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

<p>Result:</p>

<p><a href="http://code-inside.de/blog-in/wp-content/uploads/image-thumb62.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="220" alt="image_thumb[6]" src="http://code-inside.de/blog-in/wp-content/uploads/image-thumb6-thumb1.png" width="305" border="0" /></a> </p>

<p><strong>Both controls together:</strong></p>

<p><a href="http://code-inside.de/blog-in/wp-content/uploads/image-thumb81.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="366" alt="image_thumb[8]" src="http://code-inside.de/blog-in/wp-content/uploads/image-thumb8-thumb.png" width="262" border="0" /></a> </p>

<p>I think this is a very nice feature (and play well together with ASP.NET MVC) and you could add nice charts without buy a 3rd party licence.</p>

<p><strong><a href="http://code-inside.de/files/democode/mvccharting/mvccharting.zip">[ Download Source Code ]</a></strong></p>

<script type="text/javascript"><!--
google_ad_client = "ca-pub-9430917753624356";
/* Code-Inside Post Ende */
google_ad_slot = "2672274407";
google_ad_width = 468;
google_ad_height = 60;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
