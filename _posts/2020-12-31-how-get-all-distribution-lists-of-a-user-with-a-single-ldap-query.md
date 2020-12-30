---
layout: post
title: "How to get all distribution lists of a user with a single LDAP query"
description: "Discover the magic of '1.2.840.113556.1.4.1941'"
date: 2020-12-31 00:30
author: Robert Muehsig
tags: [LDAP, Distribution Lists, Active Directory, Exchange]
language: en
---

{% include JB/setup %}

In 2007 I wrote a blogpost how easy it is to get all "groups" of a given user via the [tokenGroup attribute](https://blog.codeinside.eu/2017/03/02/howto-get-user-information-and-groups-from-ad/).

Last month I had the task to check why "distribution list memberships" are not part of the result. 

__The reason is simple:__

A pure distribution list (__not security enabled__) is not a security group and only security groups are part of the "tokenGroup" attribute.

After some thoughts and discussions we agreed, that it would be good if we could enhance our function and treat distribution lists like security groups.

# How to get all distribution lists of a user?

The get all groups of a given user might be seen as trivial, but the problem is, that groups can contain other groups. 
As always, there are a couple of ways to get a "full flat" list of all group memberships. 

A *stupid* way would be to load all groups in a recrusive function - this might work, but will result in a flood of requests.

A *clever* way would be to write a good LDAP query and let the Active Directory do the heavy lifting for us, right?

# 1.2.840.113556.1.4.1941

I found some sample code online with a very strange LDAP query and it turns out:
There is a "magic" ldap query called "LDAP_MATCHING_RULE_IN_CHAIN" and it does everything we are looking for:

```
var getGroupsFilterForDn = $"(&(objectClass=group)(member:1.2.840.113556.1.4.1941:= {distinguishedName}))";
                using (var dirSearch = CreateDirectorySearcher(getGroupsFilterForDn))
                {
                    using (var results = dirSearch.FindAll())
                    {
                        foreach (SearchResult result in results)
                        {
                            if (result.Properties.Contains("name") && result.Properties.Contains("objectSid") && result.Properties.Contains("groupType"))
                                groups.Add(new GroupResult() { Name = (string)result.Properties["name"][0], GroupType = (int)result.Properties["groupType"][0], ObjectSid = new SecurityIdentifier((byte[])result.Properties["objectSid"][0], 0).ToString() });
                        }
                    }
                }
```

With a given distinguishedName of the target user, we can load all distribution and security groups (see below...) transitive!

# Combine tokenGroups and this

During our testing we found some minor differences between the LDAP_MATCHING_RULE_IN_CHAIN and the tokenGroups approach. Some "system-level" security groups were missing with the LDAP_MATCHING_RULE_IN_CHAIN way. In our production code we use a combination of those two approaches and it seems to work.

A full demo code how to get all distribution lists for a user can be found on [GitHub](https://github.com/Code-Inside/Samples/tree/master/2020/Distributionlists).

Hope this helps!