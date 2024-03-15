---
layout: post
title: "dotnet dev-certs https - How .NET Issues Your Local Dev HTTPS Certificate"
description: "Discover how Visual Studio and other .NET Core-related tools enable HTTPS on your local development machine."
date: 2024-03-15 23:59
author: Robert Muehsig
tags: [.NET Core, .NET, HTTPS]
language: en
---

{% include JB/setup %}

If you start developing a ASP.NET Core application you will notice that your site is running under "http __s__ ://localhost:1234" and that your browser is happy to accept it - so there are some questions to be asked.

# Why HTTPS on your local dev box?

The first question might be: Why is HTTPS on your local dev box even needed? 

At least two reasons for this (from my perspective):
- Browsers love HTTPS nowadays. There are some features, like websockets, that refuse to work with HTTP. I'm not 100% aware of all the problems, but running a webapp under HTTP in 2024 is painful (and rightfully so!).
- Integration with other services is mostly forbidden. If you rely on a 3rd party authentication system (e.g. Microsoft/Facebook/Google/Apple Login) they might accept "localhost" as a reply address, but might deny HTTP addresses.

I wouldn't count "security" as an issue here, because you are developing on your own system. If there is something on your machine HTTPS won't help you at that point.

# How does ASP.NET Core issues a valid & trusted cert?

I'm not exactly sure when this happens, as it was already installed on my development machine. 

Either when you install the Visual Studio workload for ASP.NET Core or if you create your very first ASP.NET Core application the dev cert for localhost will be issued.

## But how?

The .NET SDK ships with a CLI tool called `dotnet dev-certs https` and this tool issues the certificate.
The output of this command will look like this if a valid and trusted certificate is found::

```
PS C:\Users\muehsig> dotnet dev-certs https
A valid HTTPS certificate is already present.
```

## dev-certs https

There are other options available:

```
PS C:\Users\muehsig> dotnet dev-certs https --help


Usage: dotnet dev-certs https [options]

Options:
  -ep|--export-path  Full path to the exported certificate
  -p|--password      Password to use when exporting the certificate with the private key into a pfx file or to encrypt the Pem exported key
  -np|--no-password  Explicitly request that you don't use a password for the key when exporting a certificate to a PEM format
  -c|--check         Check for the existence of the certificate but do not perform any action
  --clean            Cleans all HTTPS development certificates from the machine.
  -i|--import        Imports the provided HTTPS development certificate into the machine. All other HTTPS developer certificates will be cleared out
  --format           Export the certificate in the given format. Valid values are Pfx and Pem. Pfx is the default.
  -t|--trust         Trust the certificate on the current platform. When combined with the --check option, validates that the certificate is trusted.
  -v|--verbose       Display more debug information.
  -q|--quiet         Display warnings and errors only.
  -h|--help          Show help information
```

# What happens when the cert is no longer valid?

This is an interesting one, because I had this experience just this week (and that's the reason for this blogpost).

A certificate needs to be in the certification store to be considered trusted. That means your "localhost"-dev cert will be stored in your personal certification store (at least on Windows):

![x]({{BASE_PATH}}/assets/md-images/2024-03-15/devcerts.png "Dev Cert in Certification Store")

As you can see, the command `dotnet dev-certs https --check --trust` will return something like this:

```
A trusted certificate was found: E7A2FB302F26BCFFB7C21801C09081CF2FAAAD2C - CN=localhost - Valid from 2024-03-13 11:12:10Z to 2025-03-13 11:12:10Z - IsHttpsDevelopmentCertificate: true - IsExportable: true
```

If the certificate is stale, then your browser won't accept it anymore and your web application will start, but can't be viewed because your browser will refuse it.

# How to repair invalid certificates?

Use the two commands and it should work again:

```
dotnet dev-certs https --clean
```

...which will remove the old certification and...

```
dotnet dev-certs https --trust
```

... to issue a new cert and invoke the trust dialog from Windows.

# If it works...

There are some more options, e.g. to export the certificate, which can be useful in certain scenarios, but if you can use HTTPS on your local development machine and everything works you shouldn't have to bother.
If you want to learn more, checkout the [dotnet dev-certs](https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-dev-certs) documentation. 

Hope this helps!