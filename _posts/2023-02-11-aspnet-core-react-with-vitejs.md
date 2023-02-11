---
layout: post
title: "Use ASP.NET Core and React with Vite.js"
description: "Best of both worlds!"
date: 2023-02-11 01:15
author: Robert Muehsig
tags: [ASP.NET Core, React, .NET]
language: en
---

{% include JB/setup %}

# The CRA Problem

In my [previous post](https://blog.codeinside.eu/2023/01/25/aspnet-core-and-react/) I showed a simple setup with ASP.NET Core & React. The React part was created with the "CRA"-Tooling, which is kind of [problematic](https://twitter.com/t3dotgg/status/1616918838830059520). The "new" state of the art React tooling seems to be [vite.js](https://vitejs.dev/) - so let's take a look how to use this.

![x]({{BASE_PATH}}/assets/md-images/2023-02-11/vitejs.png "Vitejs Logo")

# Step for Step 

__Step 1: Create a "normal" ASP.NET Core project__

(I like the ASP.NET Core MVC template, but feel free to use something else - same as in the [other blogpost](https://blog.codeinside.eu/2023/01/25/aspnet-core-and-react/))

![x]({{BASE_PATH}}/assets/md-images/2023-02-11/step1.png "Step 1: Create a normal ASPNET Core project")

__Step 2: Install vite.js and init the template__

Now move to the root directory of your project with a shell and execute this:

```
npm create vite@latest clientapp -- --template react-ts
```

This will install the latest & greatest vitejs based react app in a folder called `clientapp` with the `react-ts` template (React with Typescript). Vite itself isn't focused on React and supports many [different frontend frameworks](https://vitejs.dev/guide/#trying-vite-online).

![x]({{BASE_PATH}}/assets/md-images/2023-02-11/step1.png "Step 2: Init vitejs")


__Step 3: Enable HTTPS in your vite.js__

Just like in the "CRA"-setup we need to make sure, that the environment is served under HTTPS. In the "CRA" world we needed to different files from the original ASP.NET Core & React template, but with vite.js there is a much simpler option available.

Execute the following command in the `clientapp` directory:

```
npm install --save-dev vite-plugin-mkcert
```

Then in your `vite.config.ts` use this config:

```
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import mkcert from 'vite-plugin-mkcert'

// https://vitejs.dev/config/
export default defineConfig({
    base: '/app',
    server: {
        https: true,
        port: 6363
    },
    plugins: [react(), mkcert()],
})
```

Be aware: The `base: '/app'` will be used as a sub-path. 

The important part for the HTTPS setting is that we use the `mkcert()` plugin and configure the server part with a port and set `https` to `true`.

__Step 4: Add the Microsoft.AspNetCore.SpaServices.Extensions NuGet package__

Same as in the other blogpost, we need to add the [Microsoft.AspNetCore.SpaServices.Extensions](https://www.nuget.org/packages/Microsoft.AspNetCore.SpaServices.Extensions) NuGet package to glue the ASP.NET Core development and React world together. If you use .NET 7, then use the version 7.x.x, if you use .NET 6, use the version 6.x.x - etc.

![x]({{BASE_PATH}}/assets/md-images/2023-02-11/step1.png "Step 4: Add NuGet Package")

__Step 5: Enhance your Program.cs__ 

Back to the `Program.cs` - this is more or less the same as with the "CRA" setup:

Add the `SpaStaticFiles` to the services collection like this in your `Program.cs` - be aware, that vite.js builds everything in a folder called `dist`:

```
var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

// ↓ Add the following lines: ↓
builder.Services.AddSpaStaticFiles(configuration => {
    configuration.RootPath = "clientapp/dist";
});
// ↑ these lines ↑

var app = builder.Build();
```

Now we need to use the SpaServices like this:

```
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

// ↓ Add the following lines: ↓
var spaPath = "/app";
if (app.Environment.IsDevelopment())
{
    app.MapWhen(y => y.Request.Path.StartsWithSegments(spaPath), client =>
    {
        client.UseSpa(spa =>
        {
            spa.UseProxyToSpaDevelopmentServer("https://localhost:6363");
        });
    });
}
else
{
    app.Map(new PathString(spaPath), client =>
    {
        client.UseSpaStaticFiles();
        client.UseSpa(spa => {
            spa.Options.SourcePath = "clientapp";

            // adds no-store header to index page to prevent deployment issues (prevent linking to old .js files)
            // .js and other static resources are still cached by the browser
            spa.Options.DefaultPageStaticFileOptions = new StaticFileOptions
            {
                OnPrepareResponse = ctx =>
                {
                    ResponseHeaders headers = ctx.Context.Response.GetTypedHeaders();
                    headers.CacheControl = new CacheControlHeaderValue
                    {
                        NoCache = true,
                        NoStore = true,
                        MustRevalidate = true
                    };
                }
            };
        });
    });
}
// ↑ these lines ↑

app.Run();
```

Just like in the original blogpost. In the development mode we use the `UseProxyToSpaDevelopmentServer`-method to proxy all requests to the vite.js dev server. In the real world, we will use the files from the `dist` folder.

__Step 6: Invoke npm run build during publish__

The last step is to complete the setup. We want to build the ASP.NET Core app __and__ the React app, when we use `dotnet publish`:

Add this to your `.csproj`-file and it should work:

```
	<PropertyGroup>
		<SpaRoot>clientapp\</SpaRoot>
	</PropertyGroup>

	<Target Name="PublishRunWebpack" AfterTargets="ComputeFilesToPublish">
		<!-- As part of publishing, ensure the JS resources are freshly built in production mode -->
		<Exec WorkingDirectory="$(SpaRoot)" Command="npm install" />
		<Exec WorkingDirectory="$(SpaRoot)" Command="npm run build" />

		<!-- Include the newly-built files in the publish output -->
		<ItemGroup>
			<DistFiles Include="$(SpaRoot)dist\**" />  <!-- Changed to dist! -->
			<ResolvedFileToPublish Include="@(DistFiles->'%(FullPath)')" Exclude="@(ResolvedFileToPublish)">
				<RelativePath>%(DistFiles.Identity)</RelativePath> <!-- Changed! -->
				<CopyToPublishDirectory>PreserveNewest</CopyToPublishDirectory>
				<ExcludeFromSingleFile>true</ExcludeFromSingleFile>
			</ResolvedFileToPublish>
		</ItemGroup>
	</Target>
```

# Result 

You should now be able to use Visual Studio Code (or something like this) and start the frontend project with `dev`. If you open a browser and go to `https://127.0.0.1:6363/app` you should see something like this:

![x]({{BASE_PATH}}/assets/md-images/2023-02-11/result-vscode.png "Visual Studio Code Result")

Now start the ASP.NET Core app and go to `/app` and it should look like this:

![x]({{BASE_PATH}}/assets/md-images/2023-02-11/result-vs.png "Visual Studio Result")

Ok - this looks broken, right? Well - this is a more or less a ["known" problem](https://github.com/vitejs/vite/issues/7358), but can be easily avoided. If we import the logo from the assets it works as expected and shouldn't be a general problem:

![x]({{BASE_PATH}}/assets/md-images/2023-02-11/result-fix.png "Fix")

The sample code can be found [here](https://github.com/Code-Inside/Samples/tree/master/2023/reactvideovite/reactvideovite).

Hope this helps! 
