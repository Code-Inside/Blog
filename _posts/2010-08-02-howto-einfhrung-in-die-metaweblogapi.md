---
layout: post
title: "HowTo: Einführung in die MetaWebLogAPI"
date: 2010-08-02 23:41
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, MetaWeblog]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image1015.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb199.png" width="132" height="130" /></a>Dieser Blogpost basiert auf <a href="http://www.hanselman.com/blog/TheWeeklySourceCode55NotABlogALocalXMLRPCMetaWebLogEndpointThatLiesToWindowsLiveWriter.aspx">Scott Hanselmans "WeeklySourceCode”</a>, wo diese Woche das Thema MetaWebLogAPI dran kam. In dem Blogpost berichtet er, dass MS auch intern zum Verwalten ihrer Seiten den Windows Live Writer nutzen. Das Tool ist absolut praktisch und ist "<a href="http://www.xmlrpc.com/metaWeblogApi">MetaWebLogAPI</a>” kompatibel. Durch diese API ist es z.B. möglich mit Standard Tools (Word oder den Windows Live Writer) "CMS” Content zu erzeugen. </p>  <p></p> <!--more-->  <p><strong>Was nützt mir das?</strong></p>  <p>Der normale Endanwender mag ein einfachen WYSIWYG Editor haben. Es gibt einige nette Editoren, wie z.B. <a href="http://tinymce.moxiecode.com/">tinyMCE</a>. Das größte Problem was ich bislang mit solchen Web-basierten Lösungen habe ist, dass der Umgang mit Bildern meistens Arg abenteuerlich gestaltet ist. Der normale User mag es, einfach die Bilder per Copy and Paste ins Word zu verschieben und dort noch ein paar Effekte anzustellen. Wenn man nun selber Webseitenbetreiber ist und seinen Kunden ein "einfaches” Frontend zur Verfügung stellen möchte, der kann die MetaWebLog API implementieren.</p>  <p><strong>Standard Tools</strong></p>  <p>Der große Vorteil ergibt sich durch die netten Clients. Auf der einen Seite gibt es z.B. den Windows Live Writer:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1016.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb200.png" width="244" height="212" /></a> </p>  <p>Aber auch Word ab der Version 2007:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1017.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb201.png" width="360" height="241" /></a> </p>  <p>In diesen Tools kann man einfach aus der Zwischenablage Bilder etc. einfügen und entsprechend editieren. Erst beim "Veröffentlichen” werden die Daten zum Server übertragen. </p>  <p><strong>Technischer Hintergrund: XmlRPC</strong></p>  <p>Die MetaWebLog API basiert nicht auf SOAP, sondern auf <a href="http://en.wikipedia.org/wiki/XML-RPC">XML Remote Process Call (RPC)</a>. Im Grunde wird dort auch nur XML übertragen. Ein Beispiel von Wikipedia:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5ed26b03-4106-4330-afe6-721a70136cbc" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;?xml version="1.0"?&gt;
&lt;methodCall&gt;
  &lt;methodName&gt;examples.getStateName&lt;/methodName&gt;
  &lt;params&gt;
    &lt;param&gt;
        &lt;value&gt;&lt;i4&gt;40&lt;/i4&gt;&lt;/value&gt;
    &lt;/param&gt;
  &lt;/params&gt;
&lt;/methodCall&gt;</pre></div>

<p>Dafür gibt es auch einen <a href="http://xml-rpc.net/">.NET Wrapper</a>.</p>

<p>Die MetaWebLog API hat ein festes Set an Methoden. Dafür wurde bereits im Jahre 2008 von <a href="http://nayyeri.net/">Keyvan Nayyeri</a> eine Schnittstelle für <a href="http://nayyeri.net/implement-metaweblog-api-in-asp-net">ASP.NET</a>.</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:2a86c7ce-20ba-4243-a566-a83a4dd0c7c5" class="wlWriterEditableSmartContent"><pre name="code" class="c#">namespace NotABlog
{
    public interface IMetaWeblog
    {
        #region MetaWeblog API
 
        [XmlRpcMethod("metaWeblog.newPost")]
        string AddPost(string blogid, string username, string password, Post post, bool publish);
 
        [XmlRpcMethod("metaWeblog.editPost")]
        bool UpdatePost(string postid, string username, string password, Post post, bool publish);
 
        [XmlRpcMethod("metaWeblog.getPost")]
        Post GetPost(string postid, string username, string password);
 
        [XmlRpcMethod("metaWeblog.getCategories")]
        CategoryInfo[] GetCategories(string blogid, string username, string password);
 
        [XmlRpcMethod("metaWeblog.getRecentPosts")]
        Post[] GetRecentPosts(string blogid, string username, string password, int numberOfPosts);
 
        [XmlRpcMethod("metaWeblog.newMediaObject")]
        MediaObjectInfo NewMediaObject(string blogid, string username, string password, MediaObject mediaObject);
 
        #endregion
 
        #region Blogger API
 
        [XmlRpcMethod("blogger.deletePost")]
        [return: XmlRpcReturnValue(Description = "Returns true.")]
        bool DeletePost(string key, string postid, string username, string password, bool publish);
 
        [XmlRpcMethod("blogger.getUsersBlogs")]
        BlogInfo[] GetUsersBlogs(string key, string username, string password);
 
        [XmlRpcMethod("blogger.getUserInfo")]
        UserInfo GetUserInfo(string key, string username, string password);
 
        #endregion
    }
}</pre></div>

<p></p>

<p></p>

<p></p>

<p>Diese Schnittstelle hat ScottHa in seinem Demoprojekt implementiert, so z.B. :</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d0a5bddf-d26c-45fe-bfb0-0c2c1a5d0e26" class="wlWriterEditableSmartContent"><pre name="code" class="c#">string IMetaWeblog.AddPost(string blogid, string username, string password,
    Post post, bool publish)
{
    if (ValidateUser(username, password))
    {
        string id = string.Empty;
        string postFileName;
        if (String.IsNullOrEmpty(post.title))
            postFileName = Guid.NewGuid() + ".html";
        else
            postFileName = post.title + ".html";
 
        File.WriteAllText(Path.Combine(LocalPublishPath, postFileName), post.description);
         
        return postFileName;
    }
    throw new XmlRpcFaultException(0, "User is not valid!");
}</pre></div>

<p>Da ich mich fragte, was mit Bildern geschieht: Diese kommen in der Methode "NewMediaObject” an und können dort als byte Array verarbeitet werden.</p>

<p><strong>Demoprojekt gibts bei ScottHa</strong></p>

<p>Wie bereits gesagt, basiert dieser Post auf dem <a href="http://www.hanselman.com/blog/TheWeeklySourceCode55NotABlogALocalXMLRPCMetaWebLogEndpointThatLiesToWindowsLiveWriter.aspx">Post von Scott</a>. Er hat auch sein Demoprojekt veröffentlicht und Daten die ich vom Windows Live Writer oder Word abschicke kommen auch bei den entsprechenden Methoden an.</p>
