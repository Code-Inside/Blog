---
layout: post
title: "Using Basic Authentication in ASP.NET WebAPI"
description: "Back to the roots: How to use Basic Authentication to protect your ASP.NET WebAPI"
date: 2015-04-17 23:30
author: Robert Muehsig
tags: [Basic Auth, WebAPI, ASP.NET]
language: en
---
{% include JB/setup %}


## Basic Authentication? Are you kidding?

This was my first thought when I was thinking about a simple approach to protect Web APIs, but then I found this nicely written blogpost: [Why I love Basic Auth](http://www.rdegges.com/why-i-love-basic-auth/)

The topic is still very controversial, but if it done right and you are using SSL: Why not give it a try. There are other well-known examples, like the [GitHub API](https://developer.github.com/v3/auth/) which can be used with Basic Auth.

## Short introduction to Basic Authentication

We can all agree that Basic Authentication is dead simple for HTTP Servers and Clients. The Client just needs to send the given Username and Password Base64 encoded in the "Authorization" HTTP header like this:

    Authorization: Basic dXNlcm5hbWU6cGFzc3dvcmQ=

The "dXN" is just "username:password" encoded in Base64.

Now the Server just needs to decode the Username and Password and get the actual user lookup started. The Server can also inform Clients that the authentication is need via this HTTP Response Header:

    WWW-Authenticate: Basic realm="RealmName"
	
All typical Clients and Servers can handle this "basic" stuff very well.

## Basic Auth with ASP.NET WebAPI

The following code is based on this excellent tutorial [Authentication Filters in ASP.NET Web API 2
](http://www.asp.net/web-api/overview/security/authentication-filters), but I'm leaving out the ASP.NET Identity stuff.

The sample code from Microsoft contains an abstract base filter, which will check the request for the authentication header and will extract username and password.

    public abstract class BasicAuthenticationAttribute : Attribute, IAuthenticationFilter
    {
        public string Realm { get; set; }

        public async Task AuthenticateAsync(HttpAuthenticationContext context, CancellationToken cancellationToken)
        {
            HttpRequestMessage request = context.Request;
            AuthenticationHeaderValue authorization = request.Headers.Authorization;

            if (authorization == null)
            {
                // No authentication was attempted (for this authentication method).
                // Do not set either Principal (which would indicate success) or ErrorResult (indicating an error).
                return;
            }

            if (authorization.Scheme != "Basic")
            {
                // No authentication was attempted (for this authentication method).
                // Do not set either Principal (which would indicate success) or ErrorResult (indicating an error).
                return;
            }

            if (String.IsNullOrEmpty(authorization.Parameter))
            {
                // Authentication was attempted but failed. Set ErrorResult to indicate an error.
                context.ErrorResult = new AuthenticationFailureResult("Missing credentials", request);
                return;
            }

            Tuple<string, string> userNameAndPasword = ExtractUserNameAndPassword(authorization.Parameter);

            if (userNameAndPasword == null)
            {
                // Authentication was attempted but failed. Set ErrorResult to indicate an error.
                context.ErrorResult = new AuthenticationFailureResult("Invalid credentials", request);
                return;
            }

            string userName = userNameAndPasword.Item1;
            string password = userNameAndPasword.Item2;

            IPrincipal principal = await AuthenticateAsync(userName, password, cancellationToken);

            if (principal == null)
            {
                // Authentication was attempted but failed. Set ErrorResult to indicate an error.
                context.ErrorResult = new AuthenticationFailureResult("Invalid username or password", request);
            }
            else
            {
                // Authentication was attempted and succeeded. Set Principal to the authenticated user.
                context.Principal = principal;
            }
        }

        protected abstract Task<IPrincipal> AuthenticateAsync(string userName, string password,
            CancellationToken cancellationToken);

        private static Tuple<string, string> ExtractUserNameAndPassword(string authorizationParameter)
        {
            byte[] credentialBytes;

            try
            {
                credentialBytes = Convert.FromBase64String(authorizationParameter);
            }
            catch (FormatException)
            {
                return null;
            }

            // The currently approved HTTP 1.1 specification says characters here are ISO-8859-1.
            // However, the current draft updated specification for HTTP 1.1 indicates this encoding is infrequently
            // used in practice and defines behavior only for ASCII.
            Encoding encoding = Encoding.ASCII;
            // Make a writable copy of the encoding to enable setting a decoder fallback.
            encoding = (Encoding)encoding.Clone();
            // Fail on invalid bytes rather than silently replacing and continuing.
            encoding.DecoderFallback = DecoderFallback.ExceptionFallback;
            string decodedCredentials;

            try
            {
                decodedCredentials = encoding.GetString(credentialBytes);
            }
            catch (DecoderFallbackException)
            {
                return null;
            }

            if (String.IsNullOrEmpty(decodedCredentials))
            {
                return null;
            }

            int colonIndex = decodedCredentials.IndexOf(':');

            if (colonIndex == -1)
            {
                return null;
            }

            string userName = decodedCredentials.Substring(0, colonIndex);
            string password = decodedCredentials.Substring(colonIndex + 1);
            return new Tuple<string, string>(userName, password);
        }

        public Task ChallengeAsync(HttpAuthenticationChallengeContext context, CancellationToken cancellationToken)
        {
            Challenge(context);
            return Task.FromResult(0);
        }

        private void Challenge(HttpAuthenticationChallengeContext context)
        {
            string parameter;

            if (String.IsNullOrEmpty(Realm))
            {
                parameter = null;
            }
            else
            {
                // A correct implementation should verify that Realm does not contain a quote character unless properly
                // escaped (precededed by a backslash that is not itself escaped).
                parameter = "realm=\"" + Realm + "\"";
            }

            context.ChallengeWith("Basic", parameter);
        }

        public virtual bool AllowMultiple
        {
            get { return false; }
        }
    }
	
There is a small helper class, which will issue an "UnAuthorized"-Response, with the challenge note:

    public static class HttpAuthenticationChallengeContextExtensions
    {
        public static void ChallengeWith(this HttpAuthenticationChallengeContext context, string scheme)
        {
            ChallengeWith(context, new AuthenticationHeaderValue(scheme));
        }

        public static void ChallengeWith(this HttpAuthenticationChallengeContext context, string scheme, string parameter)
        {
            ChallengeWith(context, new AuthenticationHeaderValue(scheme, parameter));
        }

        public static void ChallengeWith(this HttpAuthenticationChallengeContext context, AuthenticationHeaderValue challenge)
        {
            if (context == null)
            {
                throw new ArgumentNullException("context");
            }

            context.Result = new AddChallengeOnUnauthorizedResult(challenge, context.Result);
        }
    }
	
The real work is now done in this filter:

    public class IdentityBasicAuthenticationAttribute : BasicAuthenticationAttribute
    {
        protected override async Task<IPrincipal> AuthenticateAsync(string userName, string password, CancellationToken cancellationToken)
        {
            cancellationToken.ThrowIfCancellationRequested(); 

            if (userName != "testuser" || password != "Pass1word")
            {
                // No user with userName/password exists.
                return null;
            }

            // Create a ClaimsIdentity with all the claims for this user.
            Claim nameClaim = new Claim(ClaimTypes.Name, userName);
            List<Claim> claims = new List<Claim> { nameClaim };

            // important to set the identity this way, otherwise IsAuthenticated will be false
            // see: http://leastprivilege.com/2012/09/24/claimsidentity-isauthenticated-and-authenticationtype-in-net-4-5/
            ClaimsIdentity identity = new ClaimsIdentity(claims, AuthenticationTypes.Basic);

            var principal = new ClaimsPrincipal(identity);
            return principal;
        }

    }
	
The [Microsoft Sample](http://aspnet.codeplex.com/sourcecontrol/latest#Samples/WebApi/BasicAuthentication/ReadMe.txt) uses the ASP.NET Identity Stack  - for this demo I just hardcoded my expected username and password. If the request contains these credentials the filter will create a new ClaimsPrincipal.

## Usage

Using this filter now is pretty simple:

    [IdentityBasicAuthentication]
    [Authorize]
    public class ValuesController : ApiController
    {
        ...
    }

The "IdentityBasicAuthentication" filter will try to authenticate the user and after that the default "Authorize" filter will kick in.

## Error-Results for different scenarios

This question came up in the comments: What are the results for the different "unauthenticated"-scenarios?

Of course, if the Authorization-Header is valid and has the correct username and password the result is __HTTP 200__ with the desired result. If the authentication fails the "AuthenticationFailureResult" will set the HTTP Status Code to 401. There are some slightly different results based on the input:

__Without any Authorization-Header: "HTTP 401 Unauthroized"__

![x]({{BASE_PATH}}/assets/md-images/2015-04-17/noauth.png "No Authentication-Header given")

__With an invalid Authorization-Header: "HTTP 401 Invalid credentials"__

![x]({{BASE_PATH}}/assets/md-images/2015-04-17/invalidcredentials.png "Invalid credentials")

__With an valid Authorization-Header, but "wrong" or unkown username or password: "HTTP 401 Invalid username or password"__

![x]({{BASE_PATH}}/assets/md-images/2015-04-17/usernameorpasswordunkown.png "Unkown credentials")

For security reasons the service should not return further information, e.g. username found, but password wrong. I hope my sample is correct, if not: Leave a comment.
For more information is [OWASP.org](https://www.owasp.org/index.php/Authentication_Cheat_Sheet#Authentication_Responses) a good place. 

_Thanks John Kors for the question!_

Pretty simple, right?

The full source code can be found on [GitHub](https://github.com/Code-Inside/Samples/tree/master/2015/WebApiBasicAuth).

Happy coding!
