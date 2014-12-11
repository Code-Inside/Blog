---
layout: post
title: "Windows Azure Active Directory – CRUD for users and groups"
date: 2014-01-01 16:57
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
<p>&nbsp; <p><img title="image.png" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; padding-right: 0px" border="0" alt="image.png" src="{{BASE_PATH}}/assets/wp-images-de/image1967-570x194.png" width="570" height="194"> <p><b>Windows Azure Active Directory?</b> <p>If you are not informed about the subject I recommend you to have a look on <a href="http://www.windowsazure.com/en-us/documentation/services/active-directory/">this Azure Info site.</a>  <p><b>Which resources are there?</b> <p>The Azure AD contains the following entities: <p>- Users <p>- Groups <p>- Contacts <p>- Roles <p><b>Access to the directory or on the “directory graph”</b> <p><b></b> <p>Although the name contains “active directory” and the entities are known this Azure service hasn’t a lot in common with a usual active directory. Probably the biggest difference: there is no LDAP access – it’s a <a href="http://msdn.microsoft.com/en-us/library/windowsazure/hh974478.aspx">REST API</a>. The informations are situated in the so called <a href="http://msdn.microsoft.com/en-us/library/windowsazure/hh974476.aspx">Windows Azure Active Directory Graph</a>. Applications that are currently working with an Active Directory have to be rewritten for Windows Azure AD. <p><b>REST… or also OData</b> <p><b></b> <p>The endpoint is a REST or a <a href="http://www.odata.org/">OData API</a>. If OData is the classiest way is controversial but at least the team is constantly working on <a href="http://blogs.msdn.com/b/aadgraphteam/archive/2013/09/18/enhancing-graph-api-queries-with-additional-odata-supported-queries.aspx">supporting more OData features.</a> <p>Basically there are two types of queries: <p>“<a href="http://msdn.microsoft.com/en-us/library/windowsazure/jj126255.aspx">Common Queries</a>”: an easy API that helps you to get all the information out of the AD. <p>“<a href="http://msdn.microsoft.com/en-us/library/windowsazure/jj836245.aspx">Differential Queries</a>”: This API is interesting if you have to synchronize huge amounts of information between your own application and the Azure AD. With this API you are able to find out the changes on the resource between two requests. <p><b>News: no nice NuGet package</b> <p>Away from theory and into the practical part. Currently there is no NuGet Package or anything else that makes the work with the Graph API an easy job. There is an <a href="http://www.nuget.org/packages/Auth10.WindowsAzureActiveDirectory/">old NuGet package</a> but it contains sample code only and the API is quite old and doesn’t support all functions that are available in the newest versions (for example group management). <p>&nbsp; <p><a href="{{BASE_PATH}}/assets/wp-images-en/image_thumb1104.png"><img title="image_thumb1104" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image_thumb1104" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb1104_thumb.png" width="580" height="641"></a> <p><b>Alternative: handmade request</b> <p>Since it is a REST API all you need is a HttpClient and you can develop against it. The <a href="http://msdn.microsoft.com/en-us/library/windowsazure/dn151678.aspx">MSDN</a> offers some examples for that:</p> <div id="scid:9D7513F9-C04C-4721-824A-2B34F0212519:8fd7dee5-d362-4628-92a5-32b92a2c56e4" class="wlWriterEditableSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre style=" width: 915px; height: 113px;background-color:White;overflow: auto;"><div><!--

Code highlighting produced by Actipro CodeHighlighter (freeware)
http://www.CodeHighlighter.com/

--><span style="color: #000000;">GET https:</span><span style="color: #008000;">//</span><span style="color: #008000;">graph.windows.net/contoso.onmicrosoft.com/users/Alex@contoso.onmicrosoft.com?api-version=2013-04-05 HTTP/1.1</span><span style="color: #008000;">
</span><span style="color: #000000;">Authorization: Bearer eyJ0eX ... FWSXfwtQ
Content</span><span style="color: #000000;">-</span><span style="color: #000000;">Type: application</span><span style="color: #000000;">/</span><span style="color: #000000;">json
Host: graph.windows.net</span></div></pre><!-- Code inserted with Steve Dunn's Windows Live Writer Code Formatter Plugin.  http://dunnhq.com --></div>
<p>Since the API makes a quick progress and I don’t want to develop the “OData”-like queries by myself there is one other way. It seems like this is the recommended way anyway.
<p><b>The Code: we are going to use sample code – hmmm…</b>
<p><b></b>
<p>The Azure graph team has published several examples, including a “Graph API Helper Library”, on <a href="http://msdn.microsoft.com/en-us/library/windowsazure/hh974459.aspx">this MSDN site</a>. The library is also used in <a href="http://code.msdn.microsoft.com/Write-Sample-App-for-79e55502">the .NET sample</a>. 
<p>&nbsp; <p><img title="image" style="margin: 0px 10px 0px 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1105.png" width="245" align="left" height="425">The sample is an MVC application that projects a CRUD on users and groups. The GraphHelper includes the generated “DataServices” from the <a href="https://graph.windows.net/contoso.com/$metadata?api-version=2013-04-05">OData-endpoint</a> and some utilities around it. With that you can authenticate yourself quite easy against the Grap API and send a request.
<p>The sample includes default settings but the app has only “reading” rights on the AD.
<p><b></b>&nbsp; <p><b></b>&nbsp; <p><b></b>&nbsp; <p><b></b>&nbsp; <p><b></b>&nbsp; <p><b></b>&nbsp; <p><b></b>&nbsp; <p><b></b>&nbsp; <p><b></b>&nbsp; <p><b></b>&nbsp; <p><b></b>&nbsp; <p><b>Some screenshots from the application:</b>
<p><strong></strong>&nbsp; <p><img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; padding-right: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1106.png" width="576" height="544"><strong></strong>
<p><strong></strong>&nbsp; <p><img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; padding-right: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1107.png" width="555" height="716"><b></b>
<p><b></b>&nbsp; <p><img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; padding-right: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1108.png" width="548" height="787"><b></b>
<p><b></b>&nbsp; <p><b>Generated code … uh …</b>
<p>The “generated” code is from the <a href="https://graph.windows.net/contoso.com/$metadata?api-version=2013-04-05">OData-endpoint</a> and anything but “pretty”. There is also a “partial” class because the generated class doesn’t know the entity.
<p>The main code is not very complex but the syntax is kind of unsexy. 
<p>For example that is how to call all groups:</p>
<div id="scid:9D7513F9-C04C-4721-824A-2B34F0212519:8e5fd446-9b78-47f7-8921-7a4d0e58516d" class="wlWriterEditableSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre style=" width: 927px; height: 404px;background-color:White;overflow: auto;"><div><!--

Code highlighting produced by Actipro CodeHighlighter (freeware)
http://www.CodeHighlighter.com/

--><span style="color: #008000;">//</span><span style="color: #008000;">
        </span><span style="color: #008000;">//</span><span style="color: #008000;"> GET: /Group/
        </span><span style="color: #008000;">//</span><span style="color: #008000;"> Get: /Group?$skiptoken=xxx
        </span><span style="color: #008000;">//</span><span style="color: #008000;"> Get: /Group?$filter=DisplayName eq 'xxxx'</span><span style="color: #008000;">
</span><span style="color: #000000;">        </span><span style="color: #0000FF;">public</span><span style="color: #000000;"> ActionResult Index(</span><span style="color: #0000FF;">string</span><span style="color: #000000;"> displayName, </span><span style="color: #0000FF;">string</span><span style="color: #000000;"> skipToken)
        {
            QueryOperationResponse response;
            var groups </span><span style="color: #000000;">=</span><span style="color: #000000;"> DirectoryService.groups;
            </span><span style="color: #008000;">//</span><span style="color: #008000;"> If a filter query for displayName  is submitted, we throw away previous results we were paging.</span><span style="color: #008000;">
</span><span style="color: #000000;">            </span><span style="color: #0000FF;">if</span><span style="color: #000000;"> (displayName </span><span style="color: #000000;">!=</span><span style="color: #000000;"> </span><span style="color: #0000FF;">null</span><span style="color: #000000;">)
            {
                ViewBag.CurrentFilter </span><span style="color: #000000;">=</span><span style="color: #000000;"> displayName;
                </span><span style="color: #008000;">//</span><span style="color: #008000;"> Linq query for filter for DisplayName property.</span><span style="color: #008000;">
</span><span style="color: #000000;">                groups </span><span style="color: #000000;">=</span><span style="color: #000000;"> (DataServiceQuery)(groups.Where(group </span><span style="color: #000000;">=&gt;</span><span style="color: #000000;"> group.displayName.Equals(displayName)));
                response </span><span style="color: #000000;">=</span><span style="color: #000000;"> groups.Execute() </span><span style="color: #0000FF;">as</span><span style="color: #000000;"> QueryOperationResponse;
            }
            </span><span style="color: #0000FF;">else</span><span style="color: #000000;">
            {
                </span><span style="color: #008000;">//</span><span style="color: #008000;"> Handle the case for first request vs paged request.</span><span style="color: #008000;">
</span><span style="color: #000000;">                </span><span style="color: #0000FF;">if</span><span style="color: #000000;"> (skipToken </span><span style="color: #000000;">==</span><span style="color: #000000;"> </span><span style="color: #0000FF;">null</span><span style="color: #000000;">)
                {
                    response </span><span style="color: #000000;">=</span><span style="color: #000000;"> groups.Execute() </span><span style="color: #0000FF;">as</span><span style="color: #000000;"> QueryOperationResponse;
                }
                </span><span style="color: #0000FF;">else</span><span style="color: #000000;">
                {
                    response </span><span style="color: #000000;">=</span><span style="color: #000000;"> DirectoryService.Execute(</span><span style="color: #0000FF;">new</span><span style="color: #000000;"> Uri(skipToken)) </span><span style="color: #0000FF;">as</span><span style="color: #000000;"> QueryOperationResponse;
                }
            }
            List groupList </span><span style="color: #000000;">=</span><span style="color: #000000;"> response.ToList();
            </span><span style="color: #008000;">//</span><span style="color: #008000;"> Handle the SkipToken if present in the response.</span><span style="color: #008000;">
</span><span style="color: #000000;">            </span><span style="color: #0000FF;">if</span><span style="color: #000000;"> (response.GetContinuation() </span><span style="color: #000000;">!=</span><span style="color: #000000;"> </span><span style="color: #0000FF;">null</span><span style="color: #000000;">)
            {
                ViewBag.ContinuationToken </span><span style="color: #000000;">=</span><span style="color: #000000;"> response.GetContinuation().NextLinkUri;
            }
            </span><span style="color: #0000FF;">return</span><span style="color: #000000;"> View(groupList);
        }</span></div></pre><!-- Code inserted with Steve Dunn's Windows Live Writer Code Formatter Plugin.  http://dunnhq.com --></div>
<p>&nbsp; <p><b>Recommendation: Take a look at the sample and don’t link to the generated classes</b>
<p>The sample contains “Common Queries” plus CRUD-operations and offers an easy entry. I wouldn’t recommend using the entities directly because the generated classes contain some “imperfections” like small property-names.
<p>More information in the <a href="http://msdn.microsoft.com/en-us/library/windowsazure/hh974476.aspx">MSDN on the Graph API site.</a>
