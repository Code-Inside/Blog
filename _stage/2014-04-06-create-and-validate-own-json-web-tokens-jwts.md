---
layout: post
title: "Create and validate own Json-Web-Tokens (JWTs)"
date: 2014-04-06 08:08
author: antje.kilian
comments: true
categories: [HowTo]
tags: [Auth, JSON]
---
{% include JB/setup %}
<p>If you are interested in web authentication you probably have heard about <a href="http://self-issued.info/docs/draft-ietf-oauth-json-web-token.html">JSON Web tokens (JWT).</a></p> <b>What is a JWT?</b> <p>Maybe I’m not using the correct security termination but however: JWTs are used to exchange claims between two systems. For example: You want to log on to a service (like Facebook, Twitter, etc.) and want to have a look on your informations. As an answer you receive a JWT including the authenticated and authorized user. Basically a claim is a Key/Value pair which you can fill with whatever you want.  <p>The full specification includes <a href="http://self-issued.info/docs/draft-ietf-oauth-json-web-token.html">more information</a>. <p><b>Why JWTs?</b></p> <p>If you are running your own authentication system and want to offer an OAuth interface (for Apps) you have to think about how your clients could log themselves onto the system. The JWT might be a good transportation medium. <p><b>Create and validate own JWTs</b></p> <p>With the .NET Framework 4.5 and <a href="https://www.nuget.org/packages/System.IdentityModel.Tokens.Jwt/">JSON Web Token Handler</a> NuGet Package it is possible to validate tokens from other services or create your own. 99% of the code are from <a href="http://pfelix.wordpress.com/2012/11/27/json-web-tokens-and-the-new-jwtsecuritytokenhandler-class/">this blog</a> which offers other helpful information about security and HTTP. <p>&nbsp; <p> <div id="scid:9D7513F9-C04C-4721-824A-2B34F0212519:c390b28c-224c-4545-a928-773e26e667e2" class="wlWriterEditableSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre style=" width: 560px; height: 404px;background-color:White;overflow: auto;"><div><!--

Code highlighting produced by Actipro CodeHighlighter (freeware)
http://www.CodeHighlighter.com/

--><span style="color: #800080;">1</span><span style="color: #000000;">: </span><span style="color: #008000;">//</span><span style="color: #008000;"> Code source is from this awesome blog: </span><span style="color: #008000;">
</span><span style="color: #000000;">   </span><span style="color: #800080;">2</span><span style="color: #000000;">: </span><span style="color: #008000;">//</span><span style="color: #008000;"> </span><span style="color: #008000; text-decoration: underline;">http://pfelix.wordpress.com/2012/11/27/json-web-tokens-and-the-new-jwtsecuritytokenhandler-class/</span><span style="color: #008000;">
</span><span style="color: #000000;">   </span><span style="color: #800080;">3</span><span style="color: #000000;">: </span><span style="color: #0000FF;">class</span><span style="color: #000000;"> Program
   </span><span style="color: #800080;">4</span><span style="color: #000000;">: {
   </span><span style="color: #800080;">5</span><span style="color: #000000;">:     </span><span style="color: #0000FF;">static</span><span style="color: #000000;"> </span><span style="color: #0000FF;">void</span><span style="color: #000000;"> Main(</span><span style="color: #0000FF;">string</span><span style="color: #000000;">[] args)
   </span><span style="color: #800080;">6</span><span style="color: #000000;">:     {
   </span><span style="color: #800080;">7</span><span style="color: #000000;">:         var securityKey </span><span style="color: #000000;">=</span><span style="color: #000000;"> GetBytes(</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">ThisIsAnImportantStringAndIHaveNoIdeaIfThisIsVerySecureOrNot!</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">);
   </span><span style="color: #800080;">8</span><span style="color: #000000;">:  
   </span><span style="color: #800080;">9</span><span style="color: #000000;">:         var tokenHandler </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #0000FF;">new</span><span style="color: #000000;"> JwtSecurityTokenHandler();
  </span><span style="color: #800080;">10</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">11</span><span style="color: #000000;">:         </span><span style="color: #008000;">//</span><span style="color: #008000;"> Token Creation</span><span style="color: #008000;">
</span><span style="color: #000000;">  </span><span style="color: #800080;">12</span><span style="color: #000000;">:         var now </span><span style="color: #000000;">=</span><span style="color: #000000;"> DateTime.UtcNow;
  </span><span style="color: #800080;">13</span><span style="color: #000000;">:         var tokenDescriptor </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #0000FF;">new</span><span style="color: #000000;"> SecurityTokenDescriptor
  </span><span style="color: #800080;">14</span><span style="color: #000000;">:         {
  </span><span style="color: #800080;">15</span><span style="color: #000000;">:             Subject </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #0000FF;">new</span><span style="color: #000000;"> ClaimsIdentity(</span><span style="color: #0000FF;">new</span><span style="color: #000000;"> Claim[]
  </span><span style="color: #800080;">16</span><span style="color: #000000;">:                     {
  </span><span style="color: #800080;">17</span><span style="color: #000000;">:                         </span><span style="color: #0000FF;">new</span><span style="color: #000000;"> Claim(ClaimTypes.Name, </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">Pedro</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">),
  </span><span style="color: #800080;">18</span><span style="color: #000000;">:                         </span><span style="color: #0000FF;">new</span><span style="color: #000000;"> Claim(ClaimTypes.Role, </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">Author</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">), 
  </span><span style="color: #800080;">19</span><span style="color: #000000;">:                     }),
  </span><span style="color: #800080;">20</span><span style="color: #000000;">:             TokenIssuerName </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">self</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">,
  </span><span style="color: #800080;">21</span><span style="color: #000000;">:             AppliesToAddress </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">http://www.example.com</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">,
  </span><span style="color: #800080;">22</span><span style="color: #000000;">:             Lifetime </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #0000FF;">new</span><span style="color: #000000;"> Lifetime(now, now.AddMinutes(</span><span style="color: #800080;">2</span><span style="color: #000000;">)),
  </span><span style="color: #800080;">23</span><span style="color: #000000;">:             SigningCredentials </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #0000FF;">new</span><span style="color: #000000;"> SigningCredentials(
  </span><span style="color: #800080;">24</span><span style="color: #000000;">:                 </span><span style="color: #0000FF;">new</span><span style="color: #000000;"> InMemorySymmetricSecurityKey(securityKey),
  </span><span style="color: #800080;">25</span><span style="color: #000000;">:                 </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">http://www.w3.org/2001/04/xmldsig-more#hmac-sha256</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">,
  </span><span style="color: #800080;">26</span><span style="color: #000000;">:                 </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">http://www.w3.org/2001/04/xmlenc#sha256</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">),
  </span><span style="color: #800080;">27</span><span style="color: #000000;">:         };
  </span><span style="color: #800080;">28</span><span style="color: #000000;">:         var token </span><span style="color: #000000;">=</span><span style="color: #000000;"> tokenHandler.CreateToken(tokenDescriptor);
  </span><span style="color: #800080;">29</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">30</span><span style="color: #000000;">:         </span><span style="color: #008000;">//</span><span style="color: #008000;"> Generate Token and return string</span><span style="color: #008000;">
</span><span style="color: #000000;">  </span><span style="color: #800080;">31</span><span style="color: #000000;">:         var tokenString </span><span style="color: #000000;">=</span><span style="color: #000000;"> tokenHandler.WriteToken(token);
  </span><span style="color: #800080;">32</span><span style="color: #000000;">:         Console.WriteLine(tokenString);
  </span><span style="color: #800080;">33</span><span style="color: #000000;">:         
  </span><span style="color: #800080;">34</span><span style="color: #000000;">:         </span><span style="color: #008000;">//</span><span style="color: #008000;"> Token Validation</span><span style="color: #008000;">
</span><span style="color: #000000;">  </span><span style="color: #800080;">35</span><span style="color: #000000;">:         var validationParameters </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #0000FF;">new</span><span style="color: #000000;"> TokenValidationParameters()
  </span><span style="color: #800080;">36</span><span style="color: #000000;">:         {
  </span><span style="color: #800080;">37</span><span style="color: #000000;">:             AllowedAudience </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">http://www.example.com</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">,
  </span><span style="color: #800080;">38</span><span style="color: #000000;">:             SigningToken </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #0000FF;">new</span><span style="color: #000000;"> BinarySecretSecurityToken(securityKey),
  </span><span style="color: #800080;">39</span><span style="color: #000000;">:             ValidIssuer </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">self</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">
  </span><span style="color: #800080;">40</span><span style="color: #000000;">:         };
  </span><span style="color: #800080;">41</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">42</span><span style="color: #000000;">:         </span><span style="color: #008000;">//</span><span style="color: #008000;"> from Token to ClaimsPrincipal - easy!</span><span style="color: #008000;">
</span><span style="color: #000000;">  </span><span style="color: #800080;">43</span><span style="color: #000000;">:         var principal </span><span style="color: #000000;">=</span><span style="color: #000000;"> tokenHandler.ValidateToken(tokenString, validationParameters);
  </span><span style="color: #800080;">44</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">45</span><span style="color: #000000;">:         Console.WriteLine(principal.Claims.Single(x </span><span style="color: #000000;">=&gt;</span><span style="color: #000000;"> x.Type </span><span style="color: #000000;">==</span><span style="color: #000000;"> ClaimTypes.Name).Value);
  </span><span style="color: #800080;">46</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">47</span><span style="color: #000000;">:         Console.ReadLine();
  </span><span style="color: #800080;">48</span><span style="color: #000000;">:     }
  </span><span style="color: #800080;">49</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">50</span><span style="color: #000000;">:     </span><span style="color: #0000FF;">static</span><span style="color: #000000;"> </span><span style="color: #0000FF;">byte</span><span style="color: #000000;">[] GetBytes(</span><span style="color: #0000FF;">string</span><span style="color: #000000;"> str)
  </span><span style="color: #800080;">51</span><span style="color: #000000;">:     {
  </span><span style="color: #800080;">52</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">byte</span><span style="color: #000000;">[] bytes </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #0000FF;">new</span><span style="color: #000000;"> </span><span style="color: #0000FF;">byte</span><span style="color: #000000;">[str.Length </span><span style="color: #000000;">*</span><span style="color: #000000;"> </span><span style="color: #0000FF;">sizeof</span><span style="color: #000000;">(</span><span style="color: #0000FF;">char</span><span style="color: #000000;">)];
  </span><span style="color: #800080;">53</span><span style="color: #000000;">:         System.Buffer.BlockCopy(str.ToCharArray(), </span><span style="color: #800080;">0</span><span style="color: #000000;">, bytes, </span><span style="color: #800080;">0</span><span style="color: #000000;">, bytes.Length);
  </span><span style="color: #800080;">54</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">return</span><span style="color: #000000;"> bytes;
  </span><span style="color: #800080;">55</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">56</span><span style="color: #000000;">:     }
  </span><span style="color: #800080;">57</span><span style="color: #000000;">: }</span></div></pre><!-- Code inserted with Steve Dunn's Windows Live Writer Code Formatter Plugin.  http://dunnhq.com --></div><strong></strong>
<b>Explanation</b>
<p>The first step is the creation of a SecurityKey which is necessary for the TokenHandler. In this case it is a symmetric key which means both parties need the whole key. The JWT can be saved with different methods (like certificates). 
<p>Enter a ClaimsPrincipal with the Token Handler – we want to read this Claims later. 
<p>The token is created with all parameters and with the same parameters and the key we will make the token readable again. 
<p>It is also possible to exchange this token between server applications or app and service. 
<p>The picture shows the output of the program: the token and at the end the “name”-Claim.
<p>&nbsp; <p><img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; padding-right: 0px" border="0" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb1066.png" width="575" height="132">
<p>This code is of course also available on <a href="https://github.com/Code-Inside/Samples/tree/master/2013/JwtSampleApp">GitHub</a>.
