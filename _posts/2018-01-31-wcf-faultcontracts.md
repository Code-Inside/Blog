---
layout: post
title: "WCF Global Fault Contracts"
description: "This post shows a short summary how you can throw your own Fault-Contract in WCF on all Operations. (yeah... WCF in 2018 is still crazy)"
date: 2018-01-31 23:35
author: Robert Muehsig
tags: [wcf]
language: en
---
{% include JB/setup %}

If you are still using WCF you might have stumbled upon this problem: WCF allows you to throw certain Faults in your operation, but unfortunatly it is a bit awkward to configure if you want "Global Fault Contracts". With this solution here it should be pretty easy to get "Global Faults":

# Define the Fault on the Server Side:

Let's say we want to throw the following fault in all our operations:

    [DataContract]
    public class FoobarFault
    {

    }

# Register the Fault
	
The tricky part in WCF is to "configure" WCF that it will populate the fault. You can do this manually via the [FaultContract-Attribute] on each operation, but if you are looking for a __global WCF fault__ configuration, you need to apply it as a contract behavior like this:

```csharp
[AttributeUsage(AttributeTargets.Interface, AllowMultiple = false, Inherited = true)]
public class GlobalFaultsAttribute : Attribute, IContractBehavior
{
    // this is a list of our global fault detail classes.
    static Type[] Faults = new Type[]
    {
        typeof(FoobarFault),
    };

    public void AddBindingParameters(
        ContractDescription contractDescription,
        ServiceEndpoint endpoint,
        BindingParameterCollection bindingParameters)
    {
    }

    public void ApplyClientBehavior(
        ContractDescription contractDescription,
        ServiceEndpoint endpoint,
        ClientRuntime clientRuntime)
    {
    }

    public void ApplyDispatchBehavior(
        ContractDescription contractDescription,
        ServiceEndpoint endpoint,
        DispatchRuntime dispatchRuntime)
    {
    }

    public void Validate(
        ContractDescription contractDescription,
        ServiceEndpoint endpoint)
    {
        foreach (OperationDescription op in contractDescription.Operations)
        {
            foreach (Type fault in Faults)
            {
                op.Faults.Add(MakeFault(fault));
            }
        }
    }

    private FaultDescription MakeFault(Type detailType)
    {
        string action = detailType.Name;
        DescriptionAttribute description = (DescriptionAttribute)
            Attribute.GetCustomAttribute(detailType, typeof(DescriptionAttribute));
        if (description != null)
            action = description.Description;
        FaultDescription fd = new FaultDescription(action);
        fd.DetailType = detailType;
        fd.Name = detailType.Name;
        return fd;
    }
}	
```	

Now we can apply this ContractBehavior in the Service just like this:

    [ServiceBehavior(...), GlobalFaults]
    public class FoobarService
    ...
	
To use our Fault, just throw it as a FaultException:

    throw new FaultException<FoobarFault>(new FoobarFault(), "Foobar happend!");

# Client Side
	
On the client side you should now be able to catch this exception just like this:

```csharp
    try
	{
		...
	}
	catch (Exception ex)
	{
		if (ex is FaultException faultException)
		{
			if (faultException.Action == nameof(FoobarFault))
			{
			...
			}
		}
	}
```	

Hope this helps!

(This old topic was still on my "To-blog" list, even if WCF is quite old, maybe someone is looking for something like this)

## Further Links:

* [WCF: Contract-level FaultContract](http://dkturner.blogspot.ch/2007/11/wcf-contract-level-faultcontract.html) The code above was more or less adopted from his great blogpost!
