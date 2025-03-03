---
layout: post
title: "Handling Multiple ASP.NET Core Policies with Manual Authorization Checks"
description: "When implementing authorization in ASP.NET Core, Microsoft provides several ways to check multiple policies. While using multiple Authorize-attributes works in some or most cases, there are scenarios where a more flexible approach is needed."
date: 2025-02-25 00:30
author: Robert Muehsig
tags: [ASP.NET Core]
language: en
---

{% include JB/setup %}

# ASP.NET Core Policies

[ASP.NET Core policies](https://learn.microsoft.com/en-us/aspnet/core/security/authorization/policies) provide a structured and reusable way to enforce authorization rules across your application.
The built-in features are very flexible, but we had trouble with one scenario - but depending how you write your "Requirements" this might even be possible with the built-in features. 
Our approach was to use the authorization service to check certain policies manually - which works quite good!

# The Challenge: Combining Policies with OR Logic

In one of our API use cases, we needed to allow access **either** for certain clients (e.g., specific admininstrative applications) **or** for certain users in the database. The two approaches differ:

- **Client Authorization**: This is relatively straightforward and can be handled using the built-in `RequireClaim` approach.
- **User Authorization**: This required checking database permissions, meaning a **custom authorization requirement** was necessary.

Since both authorization paths are valid, they need to be evaluated using **OR logic**: if **either** condition is met, access should be granted.

# Solution: Using the Authorization Service for Manual Policy Checks
Instead of relying solely on `[Authorize]` attributes, we can leverage the **`IAuthorizationService`** to manually check policies in our code.

## Step 1: Define the Authorization Policies
In `Program.cs`, we define multiple policies:

```csharp
builder.Services.AddAuthorization(options =>
{
    options.AddPolicy(KnownApiPolicies.AdminApiPolicyForServiceAccount, policy =>
    {
        policy.RequireClaim("scope", "admin-client");
    });
    options.AddPolicy(KnownApiPolicies.AdminApiPolicyForLoggedInUserAdministrator, policy =>
    {
        policy.Requirements.Add(new DbRoleRequirement(Custom.UserAdminInDatabase));
    });
});
```

## Step 2: Manually Validate User Authorization
Using `IAuthorizationService`, we can manually check if the user meets **either** of the defined policies.

```csharp
private async Task<AuthorizationResultType> ValidateUserAuthorization()
{
    var user = User;

    var serviceAccountAuth = await _authorizationService.AuthorizeAsync(user, KnownApiPolicies.AdminApiPolicyForServiceAccount);
    if (serviceAccountAuth.Succeeded)
    {
        return AuthorizationResultType.ServiceAccount;
    }

    var userAuth = await _authorizationService.AuthorizeAsync(user, KnownApiPolicies.AdminApiPolicyForLoggedInUserAdministrator);
    if (userAuth.Succeeded)
    {
        return AuthorizationResultType.LoggedInUser;
    }

    return AuthorizationResultType.None;
}
```

## Step 3: Apply the Authorization Logic in the Controller

```csharp
[HttpGet]
public async Task<ActionResult<...>> GetAsync()
{
    var authResult = await ValidateUserAuthorization();
    
    if (authResult == AuthorizationResultType.None)
    {
        return Forbid(); // Return 403 if unauthorized
    }
    
    using var contextScope = authResult switch
    {
        AuthorizationResultType.ServiceAccount => // ... do something with the result,
        AuthorizationResultType.LoggedInUser => // ...,
        _ => throw new UnauthorizedAccessException()
    };
    
    return Ok(_userService.GetUsers(...));
}
```

# Recap

We use the `IAuthorizationService.AuthorizeAsync` method to check multiple policies and depending on the outcome, we can handle it depending on our needs.
This approach retains the same overall structure as the "default" policy-based authorization in ASP.NET Core but provides more flexibility by allowing policies to be evaluated dynamically via the service.

Keep in mind (as mentioned at the beginning): This is just one way of handling authorization. As far as we know, it works well without drawbacks while offering the flexibility we need.
