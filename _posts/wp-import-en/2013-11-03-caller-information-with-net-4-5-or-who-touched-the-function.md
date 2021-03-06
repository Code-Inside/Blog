---
layout: post
title: "Caller Information with .NET 4.5 or „Who touched the function?“"
date: 2013-11-03 21:14
author: CI Team
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
Debugging and Logging Code are usually full of function names and so on just so you are able to find the right place in the code at the end. Of course there are several other reasons to find out who was the last one to open the code. The interface <a href="http://msdn.microsoft.com/en-us/library/system.componentmodel.inotifypropertychanged.aspx">INotifyPropertyChanged</a> is such an example because you need the names of the properties. <p>It’s possible to solve this static – but usually the refactoring doesn’t work out. .NET 4.5 offers a nice solution for this problem. I’m sure most of you have already heard about it but I just found out recently.
<p><b>Caller Information</b> <p>.NET 4.5 offers the option to decode three attribute parameter. These parameter are filled with “invocation” information’s. <p><strong><a href="http://msdn.microsoft.com/en-us/library/system.runtime.compilerservices.callermembernameattribute.aspx">CallerMemberName:</a></strong> shows the name of the chosen method or the property<br><strong><a href="http://msdn.microsoft.com/en-us/library/system.runtime.compilerservices.callerfilepathattribute.aspx">CallerFilePath:</a></strong> shows the complete file path<br><strong><a href="http://msdn.microsoft.com/en-us/library/system.runtime.compilerservices.callerlinenumberattribute.aspx">CallerLineNumber:</a></strong> The line number of the invoke code
<p>The attributes are situated in the <a href="http://msdn.microsoft.com/en-us/library/System.Runtime.CompilerServices.aspx">System.Runtime CompilerServices</a> namespace. <p><b>Example</b></p> <p><b></b> 
 <div id="scid:9D7513F9-C04C-4721-824A-2B34F0212519:56caabd3-d09e-4988-b65b-355323eff09d" class="wlWriterEditableSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre style=" width: 932px; height: 303px;background-color:White;overflow: auto;"><div><!--

Code highlighting produced by Actipro CodeHighlighter (freeware)
http://www.CodeHighlighter.com/

--><span style="color: #800080;">1</span><span style="color: #000000;">: </span><span style="color: #0000FF;">class</span><span style="color: #000000;"> Program
   </span><span style="color: #800080;">2</span><span style="color: #000000;">:     {
   </span><span style="color: #800080;">3</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">static</span><span style="color: #000000;"> </span><span style="color: #0000FF;">void</span><span style="color: #000000;"> Main(</span><span style="color: #0000FF;">string</span><span style="color: #000000;">[] args)
   </span><span style="color: #800080;">4</span><span style="color: #000000;">:         {
   </span><span style="color: #800080;">5</span><span style="color: #000000;">:             Log(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">Hello World...</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
   </span><span style="color: #800080;">6</span><span style="color: #000000;">:             Console.ReadLine();
   </span><span style="color: #800080;">7</span><span style="color: #000000;">:         }
   </span><span style="color: #800080;">8</span><span style="color: #000000;">:  
   </span><span style="color: #800080;">9</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">public</span><span style="color: #000000;"> </span><span style="color: #0000FF;">static</span><span style="color: #000000;"> </span><span style="color: #0000FF;">void</span><span style="color: #000000;"> Log(</span><span style="color: #0000FF;">string</span><span style="color: #000000;"> text, [CallerMemberName] </span><span style="color: #0000FF;">string</span><span style="color: #000000;"> callerMemberName </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;&quot;</span><span style="color: #000000;">,
  </span><span style="color: #800080;">10</span><span style="color: #000000;">:                                             [CallerFilePath] </span><span style="color: #0000FF;">string</span><span style="color: #000000;"> callerPath </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;&quot;</span><span style="color: #000000;">, 
  </span><span style="color: #800080;">11</span><span style="color: #000000;">:                                             [CallerLineNumber] </span><span style="color: #0000FF;">int</span><span style="color: #000000;"> callerLineNumber </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #800080;">0</span><span style="color: #000000;">)
  </span><span style="color: #800080;">12</span><span style="color: #000000;">:         {
  </span><span style="color: #800080;">13</span><span style="color: #000000;">:             Console.WriteLine(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">Invoked with: </span><span style="color: #800000;">&quot;</span><span style="color: #000000;"> </span><span style="color: #000000;">+</span><span style="color: #000000;"> text);
  </span><span style="color: #800080;">14</span><span style="color: #000000;">:             Console.WriteLine(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">Caller {0} from File {1} (Ln: {2})</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">, callerMemberName, callerPath, callerLineNumber);
  </span><span style="color: #800080;">15</span><span style="color: #000000;">:         }
  </span><span style="color: #800080;">16</span><span style="color: #000000;">:     }</span></div></pre><!-- Code inserted with Steve Dunn's Windows Live Writer Code Formatter Plugin.  http://dunnhq.com --></div>
<p>If you take a look on the code with <a href="http://ilspy.net/">ILSpy</a> you are going to find the right information’s:</p>
<div id="scid:9D7513F9-C04C-4721-824A-2B34F0212519:7b2a4ec6-81ed-430b-9999-90c93987e918" class="wlWriterEditableSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre style=" width: 932px; height: 303px;background-color:White;overflow: auto;"><div><!--

Code highlighting produced by Actipro CodeHighlighter (freeware)
http://www.CodeHighlighter.com/

--><span style="color: #000000;"> </span><span style="color: #800080;">1</span><span style="color: #000000;">: </span><span style="color: #0000FF;">internal</span><span style="color: #000000;"> </span><span style="color: #0000FF;">class</span><span style="color: #000000;"> Program
   </span><span style="color: #800080;">2</span><span style="color: #000000;">:     {
   </span><span style="color: #800080;">3</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">private</span><span style="color: #000000;"> </span><span style="color: #0000FF;">static</span><span style="color: #000000;"> </span><span style="color: #0000FF;">void</span><span style="color: #000000;"> Main(</span><span style="color: #0000FF;">string</span><span style="color: #000000;">[] args)
   </span><span style="color: #800080;">4</span><span style="color: #000000;">:         {
   </span><span style="color: #800080;">5</span><span style="color: #000000;">:             Program.Log(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">Hello World...</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">, </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">Main</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">, </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">c:\\Users\\Robert\\Documents\\Visual Studio 2013\\Projects\\CallerInformationDemo\\CallerInformationDemo\\Program.cs</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">, </span><span style="color: #800080;">14</span><span style="color: #000000;">);
   </span><span style="color: #800080;">6</span><span style="color: #000000;">:             Console.ReadLine();
   </span><span style="color: #800080;">7</span><span style="color: #000000;">:         }
   </span><span style="color: #800080;">8</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">public</span><span style="color: #000000;"> </span><span style="color: #0000FF;">static</span><span style="color: #000000;"> </span><span style="color: #0000FF;">void</span><span style="color: #000000;"> Log(</span><span style="color: #0000FF;">string</span><span style="color: #000000;"> text, [CallerMemberName] </span><span style="color: #0000FF;">string</span><span style="color: #000000;"> callerMemberName </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;&quot;</span><span style="color: #000000;">, [CallerFilePath] </span><span style="color: #0000FF;">string</span><span style="color: #000000;"> callerPath </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;&quot;</span><span style="color: #000000;">, [CallerLineNumber] </span><span style="color: #0000FF;">int</span><span style="color: #000000;"> callerLineNumber </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #800080;">0</span><span style="color: #000000;">)
   </span><span style="color: #800080;">9</span><span style="color: #000000;">:         {
  </span><span style="color: #800080;">10</span><span style="color: #000000;">:             Console.WriteLine(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">Invoked with: </span><span style="color: #800000;">&quot;</span><span style="color: #000000;"> </span><span style="color: #000000;">+</span><span style="color: #000000;"> text);
  </span><span style="color: #800080;">11</span><span style="color: #000000;">:             Console.WriteLine(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">Caller {0} from File {1} (Ln: {2})</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">, callerMemberName, callerPath, callerLineNumber);
  </span><span style="color: #800080;">12</span><span style="color: #000000;">:         }
  </span><span style="color: #800080;">13</span><span style="color: #000000;">:     }</span></div></pre><!-- Code inserted with Steve Dunn's Windows Live Writer Code Formatter Plugin.  http://dunnhq.com --></div>
<p><strong>INotifyPropertyChanged</strong></p>
<p>Take a look at the <a href="http://danrigby.com/2012/03/01/inotifypropertychanged-the-net-4-5-way/">implementation</a> of the INotifyPropertyChanged example.
<p>Additional information’s are available in this <a href="http://blogs.msdn.com/b/vijaysk/archive/2012/09/27/net-4-5-information-of-caller-function-caller-attributes-in-net-4-5.aspx">blogpost.</a> 
<p><b>Demo-Code on GitHub</b>
<p>You can find the demo application on <a href="https://github.com/Code-Inside/Samples/tree/master/2013/CallerInformationDemo">GitHub.</a>
