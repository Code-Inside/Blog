---
layout: post
title: "How to run share an Azure subscription in a team"
description: "Let's use Azure, but somebody needs to pay the bills!"
date: 2020-09-29 23:45
author: Robert Muehsig
tags: [Azure, Subscription]
language: en
---

{% include JB/setup %}

We at __[Sevitec](https://sevitec.ch/en/)__ are moving more and more workloads for us or our customers to Azure. 

So the basic question needs an answer:

How can a team share an Azure subscription? 

*Be aware: This approach works for us. There might be better options. If we do something stupid, just tell me in the comments or via email - help is appreciated.*

# Step 1: Create a directory

We have a "company directory" with a fully configured Azure Active Directory (incl. User sync between our OnPrem system, Office 365 licenses etc.).

Our rule of thumb is: We create for each product team a individual directory and all team members are invited in the new directory.

Keep in mind: A directory itself costs you nothing but might help you to keep things manageable.

![Create a new tenant directory]({{BASE_PATH}}/assets/md-images/2020-09-29/step1.png "Create a new tenant directory")

# Step 2: Create a group

This step might be optional, but all team members - except the "Administrator" - have the same rights and permissions in our company. To keep things simple, we created a group with all team members.

![Put all invited users in a group]({{BASE_PATH}}/assets/md-images/2020-09-29/step2.png "Put all invited users in a group")

# Step 3: Create a subscription 

Now create a subscription. The typical "Pay-as-you-go" offer will work. Be aware that the user who creates the subscription is initially setup as the __Administrator__.

![Create a subscription]({{BASE_PATH}}/assets/md-images/2020-09-29/step3.png "Create a subscription")


# Step 4: "Share" the subscription

This is the most important step: 

You need to grant the individual  users or the group (from step 2) the __"Contributor"__ role for this subscription via the "Access control (IAM)".
The hard part is to understand how those "Role assignment" affect the subscription. I'm not even sure if the "Contributor" is the best fit, but it works for us.

![Pick the correct role assignment]({{BASE_PATH}}/assets/md-images/2020-09-29/step4.png "Pick the correct role assignment")

# Summary

I'm not really sure why such a basic concept is labeled so poorly but you really need to pick the correct role assignment and the other person should be able to use the subscription.

Hope this helps!