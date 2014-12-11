---
layout: post
title: "Introduction into SignalR 2.0 & Azure Website Websockets"
date: 2013-12-22 11:36
author: CI Team
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
<p>&nbsp; <p><img title="image.png" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; padding-right: 0px" border="0" alt="image.png" src="{{BASE_PATH}}/assets/wp-images-de/image1962-570x188.png" width="570" height="188"> <p>SignalR is an Open Source Framework for Real Time WebApps. The main problem with Real-Time in the web is the canal between Browser and Server. If you never had to deal with SignalR and this problem before here is a brief introduction: <p><b></b>&nbsp; <p><b>The problem</b> <p>Traditionally the browser initiates the request to the server and the server reacts with an answer. If the server tries to send some information in return the options are limited.  <p><b></b>&nbsp; <p><b>The “solution”</b> <p>The oldest way is via “<a href="{{BASE_PATH}}/2009/10/21/howtocode-reverse-ajax-http-push-comet-kann-der-server-clients-aktiv-infomieren/">Comet</a>” which is a collection of tricks. That means the client initiates a request and it won’t close until informations from the server are transmitted. Principally the connection is open all the time. Well this isn’t the classiest option. <p>&nbsp; <p>Another way is to use the so called “<a href="http://en.wikipedia.org/wiki/Server-sent_events">Server Sent Events</a>” which are supported by almost every browser – besides IE. Older IEs have to use the “Comet” way. <p>&nbsp; <p>The latest alternatives are so called WebSockets. A TCP connection between server and client is build and at the same time a bidirectional in the opposite direction. <p><b></b>&nbsp; <p><b>The problem with WebSockets</b> <p><b></b>WebSockets have to be supported by not only the browser but also by the server. In IIS they are official supported since IIS 8.0. That means only with Windows Server 2012 and above. Before that there is no way to activate them in the IIS pipeline. <p>&nbsp; <p>The browser supports WebSockets since IE 10. Chrome and Firefox offer the support also in earlier versions and the feature is implemented in all modern browsers. <p><b></b>&nbsp; <p><b>SignalR – real time for everyone</b> <p>Since there are several ways of “protocol-types” that depend on support from both the client and the server it is not inappropriate to build and App. That’s where SignalR gets into the game. SignalR builds the best possible connection automatically and also it has a very impressive program model. SignalR is open source and the code is available on GitHub. Still you will get support from Microsoft (if needed).  <p><b></b>&nbsp; <p><b>SignalR DemoHub</b> <p>That’s an example from the <a href="https://github.com/SignalR/Samples/tree/master/Samples_2.1.0/WebApplication/Features/Hub">GitHub account</a>: <p>&nbsp;</p> <div id="scid:9D7513F9-C04C-4721-824A-2B34F0212519:2020ec71-aaa4-469c-8b63-31be99bfdbcf" class="wlWriterEditableSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre style=" width: 932px; height: 303px;background-color:White;overflow: auto;"><div><!--

Code highlighting produced by Actipro CodeHighlighter (freeware)
http://www.CodeHighlighter.com/

--><span style="color: #0000FF;">public</span><span style="color: #000000;"> </span><span style="color: #0000FF;">class</span><span style="color: #000000;"> DemoHub : Hub
   </span><span style="color: #800080;">2</span><span style="color: #000000;">:     {
   </span><span style="color: #800080;">3</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">public</span><span style="color: #000000;"> </span><span style="color: #0000FF;">override</span><span style="color: #000000;"> Task OnConnected()
   </span><span style="color: #800080;">4</span><span style="color: #000000;">:         {
   </span><span style="color: #800080;">5</span><span style="color: #000000;">:             </span><span style="color: #0000FF;">return</span><span style="color: #000000;"> Clients.All.hubMessage(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">OnConnected </span><span style="color: #800000;">&quot;</span><span style="color: #000000;"> </span><span style="color: #000000;">+</span><span style="color: #000000;"> Context.ConnectionId);
   </span><span style="color: #800080;">6</span><span style="color: #000000;">:         }
   </span><span style="color: #800080;">7</span><span style="color: #000000;">:  
   </span><span style="color: #800080;">8</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">public</span><span style="color: #000000;"> </span><span style="color: #0000FF;">override</span><span style="color: #000000;"> Task OnDisconnected()
   </span><span style="color: #800080;">9</span><span style="color: #000000;">:         {
  </span><span style="color: #800080;">10</span><span style="color: #000000;">:             </span><span style="color: #0000FF;">return</span><span style="color: #000000;"> Clients.All.hubMessage(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">OnDisconnected </span><span style="color: #800000;">&quot;</span><span style="color: #000000;"> </span><span style="color: #000000;">+</span><span style="color: #000000;"> Context.ConnectionId);
  </span><span style="color: #800080;">11</span><span style="color: #000000;">:         }
  </span><span style="color: #800080;">12</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">13</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">public</span><span style="color: #000000;"> </span><span style="color: #0000FF;">override</span><span style="color: #000000;"> Task OnReconnected()
  </span><span style="color: #800080;">14</span><span style="color: #000000;">:         {
  </span><span style="color: #800080;">15</span><span style="color: #000000;">:             </span><span style="color: #0000FF;">return</span><span style="color: #000000;"> Clients.Caller.hubMessage(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">OnReconnected</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
  </span><span style="color: #800080;">16</span><span style="color: #000000;">:         }
  </span><span style="color: #800080;">17</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">18</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">public</span><span style="color: #000000;"> </span><span style="color: #0000FF;">void</span><span style="color: #000000;"> SendToMe(</span><span style="color: #0000FF;">string</span><span style="color: #000000;"> value)
  </span><span style="color: #800080;">19</span><span style="color: #000000;">:         {
  </span><span style="color: #800080;">20</span><span style="color: #000000;">:             Clients.Caller.hubMessage(value);
  </span><span style="color: #800080;">21</span><span style="color: #000000;">:         }
  </span><span style="color: #800080;">22</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">23</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">public</span><span style="color: #000000;"> </span><span style="color: #0000FF;">void</span><span style="color: #000000;"> SendToConnectionId(</span><span style="color: #0000FF;">string</span><span style="color: #000000;"> connectionId, </span><span style="color: #0000FF;">string</span><span style="color: #000000;"> value)
  </span><span style="color: #800080;">24</span><span style="color: #000000;">:         {
  </span><span style="color: #800080;">25</span><span style="color: #000000;">:             Clients.Client(connectionId).hubMessage(value);
  </span><span style="color: #800080;">26</span><span style="color: #000000;">:         }
  </span><span style="color: #800080;">27</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">28</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">public</span><span style="color: #000000;"> </span><span style="color: #0000FF;">void</span><span style="color: #000000;"> SendToAll(</span><span style="color: #0000FF;">string</span><span style="color: #000000;"> value)
  </span><span style="color: #800080;">29</span><span style="color: #000000;">:         {
  </span><span style="color: #800080;">30</span><span style="color: #000000;">:             Clients.All.hubMessage(value);
  </span><span style="color: #800080;">31</span><span style="color: #000000;">:         }
  </span><span style="color: #800080;">32</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">33</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">public</span><span style="color: #000000;"> </span><span style="color: #0000FF;">void</span><span style="color: #000000;"> SendToGroup(</span><span style="color: #0000FF;">string</span><span style="color: #000000;"> groupName, </span><span style="color: #0000FF;">string</span><span style="color: #000000;"> value)
  </span><span style="color: #800080;">34</span><span style="color: #000000;">:         {
  </span><span style="color: #800080;">35</span><span style="color: #000000;">:             Clients.Group(groupName).hubMessage(value);
  </span><span style="color: #800080;">36</span><span style="color: #000000;">:         }
  </span><span style="color: #800080;">37</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">38</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">public</span><span style="color: #000000;"> </span><span style="color: #0000FF;">void</span><span style="color: #000000;"> JoinGroup(</span><span style="color: #0000FF;">string</span><span style="color: #000000;"> groupName, </span><span style="color: #0000FF;">string</span><span style="color: #000000;"> connectionId)
  </span><span style="color: #800080;">39</span><span style="color: #000000;">:         {
  </span><span style="color: #800080;">40</span><span style="color: #000000;">:             </span><span style="color: #0000FF;">if</span><span style="color: #000000;"> (</span><span style="color: #0000FF;">string</span><span style="color: #000000;">.IsNullOrEmpty(connectionId))
  </span><span style="color: #800080;">41</span><span style="color: #000000;">:             {
  </span><span style="color: #800080;">42</span><span style="color: #000000;">:                 connectionId </span><span style="color: #000000;">=</span><span style="color: #000000;"> Context.ConnectionId;    
  </span><span style="color: #800080;">43</span><span style="color: #000000;">:             }
  </span><span style="color: #800080;">44</span><span style="color: #000000;">:             
  </span><span style="color: #800080;">45</span><span style="color: #000000;">:             Groups.Add(connectionId, groupName);
  </span><span style="color: #800080;">46</span><span style="color: #000000;">:             Clients.All.hubMessage(connectionId </span><span style="color: #000000;">+</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;</span><span style="color: #800000;"> joined group </span><span style="color: #800000;">&quot;</span><span style="color: #000000;"> </span><span style="color: #000000;">+</span><span style="color: #000000;"> groupName);
  </span><span style="color: #800080;">47</span><span style="color: #000000;">:         }
  </span><span style="color: #800080;">48</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">49</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">public</span><span style="color: #000000;"> </span><span style="color: #0000FF;">void</span><span style="color: #000000;"> LeaveGroup(</span><span style="color: #0000FF;">string</span><span style="color: #000000;"> groupName, </span><span style="color: #0000FF;">string</span><span style="color: #000000;"> connectionId)
  </span><span style="color: #800080;">50</span><span style="color: #000000;">:         {
  </span><span style="color: #800080;">51</span><span style="color: #000000;">:             </span><span style="color: #0000FF;">if</span><span style="color: #000000;"> (</span><span style="color: #0000FF;">string</span><span style="color: #000000;">.IsNullOrEmpty(connectionId))
  </span><span style="color: #800080;">52</span><span style="color: #000000;">:             {
  </span><span style="color: #800080;">53</span><span style="color: #000000;">:                 connectionId </span><span style="color: #000000;">=</span><span style="color: #000000;"> Context.ConnectionId;
  </span><span style="color: #800080;">54</span><span style="color: #000000;">:             }
  </span><span style="color: #800080;">55</span><span style="color: #000000;">:             
  </span><span style="color: #800080;">56</span><span style="color: #000000;">:             Groups.Remove(connectionId, groupName);
  </span><span style="color: #800080;">57</span><span style="color: #000000;">:             Clients.All.hubMessage(connectionId </span><span style="color: #000000;">+</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;</span><span style="color: #800000;"> left group </span><span style="color: #800000;">&quot;</span><span style="color: #000000;"> </span><span style="color: #000000;">+</span><span style="color: #000000;"> groupName);
  </span><span style="color: #800080;">58</span><span style="color: #000000;">:         }
  </span><span style="color: #800080;">59</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">60</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">public</span><span style="color: #000000;"> </span><span style="color: #0000FF;">void</span><span style="color: #000000;"> IncrementClientVariable()
  </span><span style="color: #800080;">61</span><span style="color: #000000;">:         {
  </span><span style="color: #800080;">62</span><span style="color: #000000;">:             Clients.Caller.counter </span><span style="color: #000000;">=</span><span style="color: #000000;"> Clients.Caller.counter </span><span style="color: #000000;">+</span><span style="color: #000000;"> </span><span style="color: #800080;">1</span><span style="color: #000000;">;
  </span><span style="color: #800080;">63</span><span style="color: #000000;">:             Clients.Caller.hubMessage(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">Incremented counter to </span><span style="color: #800000;">&quot;</span><span style="color: #000000;"> </span><span style="color: #000000;">+</span><span style="color: #000000;"> Clients.Caller.counter);
  </span><span style="color: #800080;">64</span><span style="color: #000000;">:         }
  </span><span style="color: #800080;">65</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">66</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">public</span><span style="color: #000000;"> </span><span style="color: #0000FF;">void</span><span style="color: #000000;"> ThrowOnVoidMethod()
  </span><span style="color: #800080;">67</span><span style="color: #000000;">:         {
  </span><span style="color: #800080;">68</span><span style="color: #000000;">:             </span><span style="color: #0000FF;">throw</span><span style="color: #000000;"> </span><span style="color: #0000FF;">new</span><span style="color: #000000;"> InvalidOperationException(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">ThrowOnVoidMethod</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
  </span><span style="color: #800080;">69</span><span style="color: #000000;">:         }
  </span><span style="color: #800080;">70</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">71</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">public</span><span style="color: #000000;"> async Task ThrowOnTaskMethod()
  </span><span style="color: #800080;">72</span><span style="color: #000000;">:         {
  </span><span style="color: #800080;">73</span><span style="color: #000000;">:             await Task.Delay(TimeSpan.FromSeconds(</span><span style="color: #800080;">1</span><span style="color: #000000;">));
  </span><span style="color: #800080;">74</span><span style="color: #000000;">:             </span><span style="color: #0000FF;">throw</span><span style="color: #000000;"> </span><span style="color: #0000FF;">new</span><span style="color: #000000;"> InvalidOperationException(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">ThrowOnTaskMethod</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
  </span><span style="color: #800080;">75</span><span style="color: #000000;">:         }
  </span><span style="color: #800080;">76</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">77</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">public</span><span style="color: #000000;"> </span><span style="color: #0000FF;">void</span><span style="color: #000000;"> ThrowHubException()
  </span><span style="color: #800080;">78</span><span style="color: #000000;">:         {
  </span><span style="color: #800080;">79</span><span style="color: #000000;">:             </span><span style="color: #0000FF;">throw</span><span style="color: #000000;"> </span><span style="color: #0000FF;">new</span><span style="color: #000000;"> HubException(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">ThrowHubException</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">, </span><span style="color: #0000FF;">new</span><span style="color: #000000;"> { Detail </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">I can provide additional error information here!</span><span style="color: #800000;">&quot;</span><span style="color: #000000;"> });
  </span><span style="color: #800080;">80</span><span style="color: #000000;">:         }
  </span><span style="color: #800080;">81</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">82</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">public</span><span style="color: #000000;"> </span><span style="color: #0000FF;">void</span><span style="color: #000000;"> StartBackgroundThread()
  </span><span style="color: #800080;">83</span><span style="color: #000000;">:         {
  </span><span style="color: #800080;">84</span><span style="color: #000000;">:             BackgroundThread.Enabled </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #0000FF;">true</span><span style="color: #000000;">;
  </span><span style="color: #800080;">85</span><span style="color: #000000;">:             BackgroundThread.SendOnPersistentConnection();
  </span><span style="color: #800080;">86</span><span style="color: #000000;">:             BackgroundThread.SendOnHub();
  </span><span style="color: #800080;">87</span><span style="color: #000000;">:         }
  </span><span style="color: #800080;">88</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">89</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">public</span><span style="color: #000000;"> </span><span style="color: #0000FF;">void</span><span style="color: #000000;"> StopBackgroundThread()
  </span><span style="color: #800080;">90</span><span style="color: #000000;">:         {
  </span><span style="color: #800080;">91</span><span style="color: #000000;">:             BackgroundThread.Enabled </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #0000FF;">false</span><span style="color: #000000;">;            
  </span><span style="color: #800080;">92</span><span style="color: #000000;">:         }
  </span><span style="color: #800080;">93</span><span style="color: #000000;">:     }</span></div></pre><!-- Code inserted with Steve Dunn's Windows Live Writer Code Formatter Plugin.  http://dunnhq.com --></div>
<p>The server defines a hub and it calls “client-functions” with the API like for example “hubMessage”. 
<p>The method is defined in Javascript and SignalR caters for the call:
<p>&nbsp;</p>
<div id="scid:9D7513F9-C04C-4721-824A-2B34F0212519:e108f28c-1838-4199-9ff8-3c89f969b86f" class="wlWriterEditableSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre style=" width: 932px; height: 303px;background-color:White;overflow: auto;"><div><!--

Code highlighting produced by Actipro CodeHighlighter (freeware)
http://www.CodeHighlighter.com/

--><span style="color: #000000;">   </span><span style="color: #800080;">1</span><span style="color: #000000;">: function writeError(line) {
   </span><span style="color: #800080;">2</span><span style="color: #000000;">:     var messages </span><span style="color: #000000;">=</span><span style="color: #000000;"> $(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#messages</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
   </span><span style="color: #800080;">3</span><span style="color: #000000;">:     messages.append(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">&lt;li style='color:red;'&gt;</span><span style="color: #800000;">&quot;</span><span style="color: #000000;"> </span><span style="color: #000000;">+</span><span style="color: #000000;"> getTimeString() </span><span style="color: #000000;">+</span><span style="color: #000000;"> </span><span style="color: #800000;">'</span><span style="color: #800000;"> </span><span style="color: #800000;">'</span><span style="color: #000000;"> </span><span style="color: #000000;">+</span><span style="color: #000000;"> line </span><span style="color: #000000;">+</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">&lt;/li&gt;</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
   </span><span style="color: #800080;">4</span><span style="color: #000000;">: }
   </span><span style="color: #800080;">5</span><span style="color: #000000;">:  
   </span><span style="color: #800080;">6</span><span style="color: #000000;">: function writeEvent(line) {
   </span><span style="color: #800080;">7</span><span style="color: #000000;">:     var messages </span><span style="color: #000000;">=</span><span style="color: #000000;"> $(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#messages</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
   </span><span style="color: #800080;">8</span><span style="color: #000000;">:     messages.append(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">&lt;li style='color:blue;'&gt;</span><span style="color: #800000;">&quot;</span><span style="color: #000000;"> </span><span style="color: #000000;">+</span><span style="color: #000000;"> getTimeString() </span><span style="color: #000000;">+</span><span style="color: #000000;"> </span><span style="color: #800000;">'</span><span style="color: #800000;"> </span><span style="color: #800000;">'</span><span style="color: #000000;"> </span><span style="color: #000000;">+</span><span style="color: #000000;"> line </span><span style="color: #000000;">+</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">&lt;/li&gt;</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
   </span><span style="color: #800080;">9</span><span style="color: #000000;">: }
  </span><span style="color: #800080;">10</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">11</span><span style="color: #000000;">: function writeLine(line) {
  </span><span style="color: #800080;">12</span><span style="color: #000000;">:     var messages </span><span style="color: #000000;">=</span><span style="color: #000000;"> $(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#messages</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
  </span><span style="color: #800080;">13</span><span style="color: #000000;">:     messages.append(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">&lt;li style='color:black;'&gt;</span><span style="color: #800000;">&quot;</span><span style="color: #000000;"> </span><span style="color: #000000;">+</span><span style="color: #000000;"> getTimeString() </span><span style="color: #000000;">+</span><span style="color: #000000;"> </span><span style="color: #800000;">'</span><span style="color: #800000;"> </span><span style="color: #800000;">'</span><span style="color: #000000;"> </span><span style="color: #000000;">+</span><span style="color: #000000;"> line </span><span style="color: #000000;">+</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">&lt;/li&gt;</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
  </span><span style="color: #800080;">14</span><span style="color: #000000;">: }
  </span><span style="color: #800080;">15</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">16</span><span style="color: #000000;">: function getTimeString() {
  </span><span style="color: #800080;">17</span><span style="color: #000000;">:     var currentTime </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #0000FF;">new</span><span style="color: #000000;"> Date();
  </span><span style="color: #800080;">18</span><span style="color: #000000;">:     </span><span style="color: #0000FF;">return</span><span style="color: #000000;"> currentTime.toTimeString();
  </span><span style="color: #800080;">19</span><span style="color: #000000;">: }
  </span><span style="color: #800080;">20</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">21</span><span style="color: #000000;">: function printState(state) {
  </span><span style="color: #800080;">22</span><span style="color: #000000;">:     var messages </span><span style="color: #000000;">=</span><span style="color: #000000;"> $(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#Messages</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
  </span><span style="color: #800080;">23</span><span style="color: #000000;">:     </span><span style="color: #0000FF;">return</span><span style="color: #000000;"> [</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">connecting</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">, </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">connected</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">, </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">reconnecting</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">, state, </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">disconnected</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">][state];
  </span><span style="color: #800080;">24</span><span style="color: #000000;">: }
  </span><span style="color: #800080;">25</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">26</span><span style="color: #000000;">: function getQueryVariable(variable) {
  </span><span style="color: #800080;">27</span><span style="color: #000000;">:     var query </span><span style="color: #000000;">=</span><span style="color: #000000;"> window.location.search.substring(</span><span style="color: #800080;">1</span><span style="color: #000000;">),
  </span><span style="color: #800080;">28</span><span style="color: #000000;">:         vars </span><span style="color: #000000;">=</span><span style="color: #000000;"> query.split(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">&amp;</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">),
  </span><span style="color: #800080;">29</span><span style="color: #000000;">:         pair;
  </span><span style="color: #800080;">30</span><span style="color: #000000;">:     </span><span style="color: #0000FF;">for</span><span style="color: #000000;"> (var i </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #800080;">0</span><span style="color: #000000;">; i </span><span style="color: #000000;">&lt;</span><span style="color: #000000;"> vars.length; i</span><span style="color: #000000;">++</span><span style="color: #000000;">) {
  </span><span style="color: #800080;">31</span><span style="color: #000000;">:         pair </span><span style="color: #000000;">=</span><span style="color: #000000;"> vars[i].split(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">=</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
  </span><span style="color: #800080;">32</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">if</span><span style="color: #000000;"> (pair[</span><span style="color: #800080;">0</span><span style="color: #000000;">] </span><span style="color: #000000;">==</span><span style="color: #000000;"> variable) {
  </span><span style="color: #800080;">33</span><span style="color: #000000;">:             </span><span style="color: #0000FF;">return</span><span style="color: #000000;"> unescape(pair[</span><span style="color: #800080;">1</span><span style="color: #000000;">]);
  </span><span style="color: #800080;">34</span><span style="color: #000000;">:         }
  </span><span style="color: #800080;">35</span><span style="color: #000000;">:     }
  </span><span style="color: #800080;">36</span><span style="color: #000000;">: }
  </span><span style="color: #800080;">37</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">38</span><span style="color: #000000;">: $(function () {
  </span><span style="color: #800080;">39</span><span style="color: #000000;">:     var connection </span><span style="color: #000000;">=</span><span style="color: #000000;"> $.connection.hub,
  </span><span style="color: #800080;">40</span><span style="color: #000000;">:         hub </span><span style="color: #000000;">=</span><span style="color: #000000;"> $.connection.demoHub;
  </span><span style="color: #800080;">41</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">42</span><span style="color: #000000;">:     connection.logging </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #0000FF;">true</span><span style="color: #000000;">;
  </span><span style="color: #800080;">43</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">44</span><span style="color: #000000;">:     connection.connectionSlow(function () {
  </span><span style="color: #800080;">45</span><span style="color: #000000;">:         writeEvent(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">connectionSlow</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
  </span><span style="color: #800080;">46</span><span style="color: #000000;">:     });
  </span><span style="color: #800080;">47</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">48</span><span style="color: #000000;">:     connection.disconnected(function () {
  </span><span style="color: #800080;">49</span><span style="color: #000000;">:         writeEvent(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">disconnected</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
  </span><span style="color: #800080;">50</span><span style="color: #000000;">:     });
  </span><span style="color: #800080;">51</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">52</span><span style="color: #000000;">:     connection.error(function (error) {
  </span><span style="color: #800080;">53</span><span style="color: #000000;">:         writeError(error);
  </span><span style="color: #800080;">54</span><span style="color: #000000;">:     });
  </span><span style="color: #800080;">55</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">56</span><span style="color: #000000;">:     connection.reconnected(function () {
  </span><span style="color: #800080;">57</span><span style="color: #000000;">:         writeEvent(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">reconnected</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
  </span><span style="color: #800080;">58</span><span style="color: #000000;">:     });
  </span><span style="color: #800080;">59</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">60</span><span style="color: #000000;">:     connection.reconnecting(function () {
  </span><span style="color: #800080;">61</span><span style="color: #000000;">:         writeEvent(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">reconnecting</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
  </span><span style="color: #800080;">62</span><span style="color: #000000;">:     });
  </span><span style="color: #800080;">63</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">64</span><span style="color: #000000;">:     connection.starting(function () {
  </span><span style="color: #800080;">65</span><span style="color: #000000;">:         writeEvent(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">starting</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
  </span><span style="color: #800080;">66</span><span style="color: #000000;">:     });
  </span><span style="color: #800080;">67</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">68</span><span style="color: #000000;">:     connection.stateChanged(function (state) {
  </span><span style="color: #800080;">69</span><span style="color: #000000;">:         writeEvent(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">stateChanged </span><span style="color: #800000;">&quot;</span><span style="color: #000000;"> </span><span style="color: #000000;">+</span><span style="color: #000000;"> printState(state.oldState) </span><span style="color: #000000;">+</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;</span><span style="color: #800000;"> =&gt; </span><span style="color: #800000;">&quot;</span><span style="color: #000000;"> </span><span style="color: #000000;">+</span><span style="color: #000000;"> printState(state.newState));
  </span><span style="color: #800080;">70</span><span style="color: #000000;">:         var buttonIcon </span><span style="color: #000000;">=</span><span style="color: #000000;"> $(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#startStopIcon</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
  </span><span style="color: #800080;">71</span><span style="color: #000000;">:         var buttonText </span><span style="color: #000000;">=</span><span style="color: #000000;"> $(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#startStopText</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
  </span><span style="color: #800080;">72</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">if</span><span style="color: #000000;"> (printState(state.newState) </span><span style="color: #000000;">==</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">connected</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">) {
  </span><span style="color: #800080;">73</span><span style="color: #000000;">:             buttonIcon.removeClass(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">glyphicon glyphicon-play</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
  </span><span style="color: #800080;">74</span><span style="color: #000000;">:             buttonIcon.addClass(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">glyphicon glyphicon-stop</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
  </span><span style="color: #800080;">75</span><span style="color: #000000;">:             buttonText.text(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">Stop Connection</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
  </span><span style="color: #800080;">76</span><span style="color: #000000;">:         } </span><span style="color: #0000FF;">else</span><span style="color: #000000;"> </span><span style="color: #0000FF;">if</span><span style="color: #000000;"> (printState(state.newState) </span><span style="color: #000000;">==</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">disconnected</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">) {
  </span><span style="color: #800080;">77</span><span style="color: #000000;">:             buttonIcon.removeClass(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">glyphicon glyphicon-stop</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
  </span><span style="color: #800080;">78</span><span style="color: #000000;">:             buttonIcon.addClass(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">glyphicon glyphicon-play</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
  </span><span style="color: #800080;">79</span><span style="color: #000000;">:             buttonText.text(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">Start Connection</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
  </span><span style="color: #800080;">80</span><span style="color: #000000;">:         }
  </span><span style="color: #800080;">81</span><span style="color: #000000;">:     });
  </span><span style="color: #800080;">82</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">83</span><span style="color: #000000;">:     hub.client.hubMessage </span><span style="color: #000000;">=</span><span style="color: #000000;"> function (data) {
  </span><span style="color: #800080;">84</span><span style="color: #000000;">:         writeLine(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">hubMessage: </span><span style="color: #800000;">&quot;</span><span style="color: #000000;"> </span><span style="color: #000000;">+</span><span style="color: #000000;"> data);
  </span><span style="color: #800080;">85</span><span style="color: #000000;">:     }
  </span><span style="color: #800080;">86</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">87</span><span style="color: #000000;">:     $(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#startStop</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">).click(function () {
  </span><span style="color: #800080;">88</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">if</span><span style="color: #000000;"> (printState(connection.state) </span><span style="color: #000000;">==</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">connected</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">) {
  </span><span style="color: #800080;">89</span><span style="color: #000000;">:             connection.stop();
  </span><span style="color: #800080;">90</span><span style="color: #000000;">:         } </span><span style="color: #0000FF;">else</span><span style="color: #000000;"> </span><span style="color: #0000FF;">if</span><span style="color: #000000;"> (printState(connection.state) </span><span style="color: #000000;">==</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">disconnected</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">) {
  </span><span style="color: #800080;">91</span><span style="color: #000000;">:             var activeTransport </span><span style="color: #000000;">=</span><span style="color: #000000;"> getQueryVariable(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">transport</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">) </span><span style="color: #000000;">||</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">auto</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">;
  </span><span style="color: #800080;">92</span><span style="color: #000000;">:             connection.start({ transport: activeTransport })
  </span><span style="color: #800080;">93</span><span style="color: #000000;">:             .done(function () {
  </span><span style="color: #800080;">94</span><span style="color: #000000;">:                 writeLine(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">connection started. Id=</span><span style="color: #800000;">&quot;</span><span style="color: #000000;"> </span><span style="color: #000000;">+</span><span style="color: #000000;"> connection.id </span><span style="color: #000000;">+</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">. Transport=</span><span style="color: #800000;">&quot;</span><span style="color: #000000;"> </span><span style="color: #000000;">+</span><span style="color: #000000;"> connection.transport.name);
  </span><span style="color: #800080;">95</span><span style="color: #000000;">:             })
  </span><span style="color: #800080;">96</span><span style="color: #000000;">:             .fail(function (error) {
  </span><span style="color: #800080;">97</span><span style="color: #000000;">:                 writeError(error);
  </span><span style="color: #800080;">98</span><span style="color: #000000;">:             });
  </span><span style="color: #800080;">99</span><span style="color: #000000;">:         }
 </span><span style="color: #800080;">100</span><span style="color: #000000;">:     });
 </span><span style="color: #800080;">101</span><span style="color: #000000;">:  
 </span><span style="color: #800080;">102</span><span style="color: #000000;">:     $(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#sendToMe</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">).click(function () {
 </span><span style="color: #800080;">103</span><span style="color: #000000;">:         hub.server.sendToMe($(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#message</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">).val());
 </span><span style="color: #800080;">104</span><span style="color: #000000;">:     });
 </span><span style="color: #800080;">105</span><span style="color: #000000;">:  
 </span><span style="color: #800080;">106</span><span style="color: #000000;">:     $(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#sendToConnectionId</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">).click(function () {
 </span><span style="color: #800080;">107</span><span style="color: #000000;">:         hub.server.sendToConnectionId($(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#connectionId</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">).val(), $(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#message</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">).val());
 </span><span style="color: #800080;">108</span><span style="color: #000000;">:     });
 </span><span style="color: #800080;">109</span><span style="color: #000000;">:  
 </span><span style="color: #800080;">110</span><span style="color: #000000;">:     $(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#sendBroadcast</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">).click(function () {
 </span><span style="color: #800080;">111</span><span style="color: #000000;">:         hub.server.sendToAll($(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#message</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">).val());
 </span><span style="color: #800080;">112</span><span style="color: #000000;">:     });
 </span><span style="color: #800080;">113</span><span style="color: #000000;">:  
 </span><span style="color: #800080;">114</span><span style="color: #000000;">:     $(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#sendToGroup</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">).click(function () {
 </span><span style="color: #800080;">115</span><span style="color: #000000;">:         hub.server.sendToGroup($(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#groupName</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">).val(), $(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#message</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">).val());
 </span><span style="color: #800080;">116</span><span style="color: #000000;">:     });
 </span><span style="color: #800080;">117</span><span style="color: #000000;">:  
 </span><span style="color: #800080;">118</span><span style="color: #000000;">:     $(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#joinGroup</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">).click(function () {
 </span><span style="color: #800080;">119</span><span style="color: #000000;">:         hub.server.joinGroup($(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#groupName</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">).val(), $(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#connectionId</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">).val());
 </span><span style="color: #800080;">120</span><span style="color: #000000;">:     });
 </span><span style="color: #800080;">121</span><span style="color: #000000;">:  
 </span><span style="color: #800080;">122</span><span style="color: #000000;">:     $(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#leaveGroup</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">).click(function () {
 </span><span style="color: #800080;">123</span><span style="color: #000000;">:         hub.server.leaveGroup($(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#groupName</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">).val(), $(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#connectionId</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">).val());
 </span><span style="color: #800080;">124</span><span style="color: #000000;">:     });
 </span><span style="color: #800080;">125</span><span style="color: #000000;">:  
 </span><span style="color: #800080;">126</span><span style="color: #000000;">:     $(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#clientVariable</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">).click(function () {
 </span><span style="color: #800080;">127</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">if</span><span style="color: #000000;"> (</span><span style="color: #000000;">!</span><span style="color: #000000;">hub.state.counter) {
 </span><span style="color: #800080;">128</span><span style="color: #000000;">:             hub.state.counter </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #800080;">0</span><span style="color: #000000;">;
 </span><span style="color: #800080;">129</span><span style="color: #000000;">:         }
 </span><span style="color: #800080;">130</span><span style="color: #000000;">:         hub.server.incrementClientVariable();
 </span><span style="color: #800080;">131</span><span style="color: #000000;">:     });
 </span><span style="color: #800080;">132</span><span style="color: #000000;">:  
 </span><span style="color: #800080;">133</span><span style="color: #000000;">:     $(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#throwOnVoidMethod</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">).click(function () {
 </span><span style="color: #800080;">134</span><span style="color: #000000;">:         hub.server.throwOnVoidMethod()
 </span><span style="color: #800080;">135</span><span style="color: #000000;">:         .done(function (value) {
 </span><span style="color: #800080;">136</span><span style="color: #000000;">:             writeLine(result);
 </span><span style="color: #800080;">137</span><span style="color: #000000;">:         })
 </span><span style="color: #800080;">138</span><span style="color: #000000;">:         .fail(function (error) {
 </span><span style="color: #800080;">139</span><span style="color: #000000;">:             writeError(error);
 </span><span style="color: #800080;">140</span><span style="color: #000000;">:         });
 </span><span style="color: #800080;">141</span><span style="color: #000000;">:     });
 </span><span style="color: #800080;">142</span><span style="color: #000000;">:  
 </span><span style="color: #800080;">143</span><span style="color: #000000;">:     $(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#throwOnTaskMethod</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">).click(function () {
 </span><span style="color: #800080;">144</span><span style="color: #000000;">:         hub.server.throwOnTaskMethod()
 </span><span style="color: #800080;">145</span><span style="color: #000000;">:         .done(function (value) {
 </span><span style="color: #800080;">146</span><span style="color: #000000;">:             writeLine(result);
 </span><span style="color: #800080;">147</span><span style="color: #000000;">:         })
 </span><span style="color: #800080;">148</span><span style="color: #000000;">:         .fail(function (error) {
 </span><span style="color: #800080;">149</span><span style="color: #000000;">:             writeError(error);
 </span><span style="color: #800080;">150</span><span style="color: #000000;">:         });
 </span><span style="color: #800080;">151</span><span style="color: #000000;">:     });
 </span><span style="color: #800080;">152</span><span style="color: #000000;">:  
 </span><span style="color: #800080;">153</span><span style="color: #000000;">:     $(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">#throwHubException</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">).click(function () {
 </span><span style="color: #800080;">154</span><span style="color: #000000;">:         hub.server.throwHubException()
 </span><span style="color: #800080;">155</span><span style="color: #000000;">:         .done(function (value) {
 </span><span style="color: #800080;">156</span><span style="color: #000000;">:             writeLine(result);
 </span><span style="color: #800080;">157</span><span style="color: #000000;">:         })
 </span><span style="color: #800080;">158</span><span style="color: #000000;">:         .fail(function (error) {
 </span><span style="color: #800080;">159</span><span style="color: #000000;">:             writeError(error.message </span><span style="color: #000000;">+</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">&lt;pre&gt;</span><span style="color: #800000;">&quot;</span><span style="color: #000000;"> </span><span style="color: #000000;">+</span><span style="color: #000000;"> connection.json.stringify(error.data) </span><span style="color: #000000;">+</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">&lt;/pre&gt;</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
 </span><span style="color: #800080;">160</span><span style="color: #000000;">:         });
 </span><span style="color: #800080;">161</span><span style="color: #000000;">:     });
 </span><span style="color: #800080;">162</span><span style="color: #000000;">: });</span></div></pre><!-- Code inserted with Steve Dunn's Windows Live Writer Code Formatter Plugin.  http://dunnhq.com --></div>
<p>&nbsp; <p><b></b>
<p><b>What’s new in SignalR 2.0?</b>
<p>Damian Edwards created a <a href="https://github.com/DamianEdwards/SignalR-2.x-demo">nice demo project on his GitHub account</a>:
<p><img title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image1963.png" width="589" height="405">
<p><b></b>&nbsp; <p><b>Azure Websites &amp; Websockets</b>
<p>Since about a month <a href="http://blogs.msdn.com/b/windowsazure/archive/2013/11/14/introduction-to-websockets-on-windows-azure-web-sites.aspx">Azue Websites support Websockets</a> as well. In default mode the websocket support is deactivated. You can change the settings in the Azure management portal:
<p>&nbsp; <p><img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; padding-right: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1100.png" width="436" height="236">
<p>If you run the SignalR demo application without the websocket support that’s what the traffic looks like:
<p>&nbsp; <p><img title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1101.png" width="567" height="118">
<p>&nbsp; <p>And with the support:
<p><img title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1102.png" width="588" height="172">
<p>What’s great on SignalR: the “transportation way” is unappealing because SignalR takes care of this for you so you can concentrate on the main functionalities. 
<p><b></b>&nbsp; <p><b>SignalR Resources</b>
<p>For more informations follow these links:
<p>- <a href="http://www.asp.net/signalr/overview/signalr-20">ASP.NET SignalR Tutorial</a>
<p>- <a href="https://jabbr.net/#/rooms/signalr">SignalR “JabbR” room</a> . Chat (build with SignalR) where the developers often hang out
<p>- <a href="https://github.com/SignalR/">SignalR Account on GitHub</a>
<p>This <a href="http://vimeo.com/68383353">video</a> by two of the main developers of SignalR is very impressive:
