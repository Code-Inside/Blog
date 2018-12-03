---
layout: post
title: "Make your WCF Service async"
description: "... and even maintain client compatibility!"
date: 2018-12-03 22:00
author: Robert Muehsig
tags: [WCF, async]
language: en
---
{% include JB/setup %}

# Oh my: WCF???

This might be the elephant in the room: I wouldn't use WCF for new stuff anymore, but to keep some "legacy" stuff working it might be a good idea to modernize those services as well.

# WCF Service/Client compatibility

WCF services had always close relationships with their clients and so it is no suprise, that most guides show how to implement async operations on the [server and client side](https://docs.microsoft.com/en-us/dotnet/framework/wcf/how-to-implement-an-asynchronous-service-operation).

In our product we needed to ensure backwards compatibility with __older__ clients and to my suprise: __Making the operations async don't break the WCF contract!__.

So - a short example:

## Sync Sample

The sample code is more or less the default implementation for WCF services when you use Visual Studio:

    [ServiceContract]
    public interface IService1
    {
        [OperationContract]
        string GetData(int value);

        [OperationContract]
        CompositeType GetDataUsingDataContract(CompositeType composite);

        // TODO: Add your service operations here
    }

    [DataContract]
    public class CompositeType
    {
        bool boolValue = true;
        string stringValue = "Hello ";

        [DataMember]
        public bool BoolValue
        {
            get { return boolValue; }
            set { boolValue = value; }
        }

        [DataMember]
        public string StringValue
        {
            get { return stringValue; }
            set { stringValue = value; }
        }
    }
	
	public class Service1 : IService1
    {
        public string GetData(int value)
        {
            return string.Format("You entered: {0}", value);
        }

        public CompositeType GetDataUsingDataContract(CompositeType composite)
        {
            if (composite == null)
            {
                throw new ArgumentNullException("composite");
            }
            if (composite.BoolValue)
            {
                composite.StringValue += "Suffix";
            }
            return composite;
        }
    }
	
The code is pretty straight forward: The typical interface with two methods, which are decorated with OperationContract and a default implementation.

When we know run this example and check the generated WSDL we will get something like this:

    <wsdl:definitions xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:wsx="http://schemas.xmlsoap.org/ws/2004/09/mex" xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd" xmlns:wsa10="http://www.w3.org/2005/08/addressing" xmlns:wsp="http://schemas.xmlsoap.org/ws/2004/09/policy" xmlns:wsap="http://schemas.xmlsoap.org/ws/2004/08/addressing/policy" xmlns:msc="http://schemas.microsoft.com/ws/2005/12/wsdl/contract" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:wsa="http://schemas.xmlsoap.org/ws/2004/08/addressing" xmlns:wsam="http://www.w3.org/2007/05/addressing/metadata" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:tns="http://tempuri.org/" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:wsaw="http://www.w3.org/2006/05/addressing/wsdl" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" name="Service1" targetNamespace="http://tempuri.org/">
    	<wsdl:types>
    		<xsd:schema targetNamespace="http://tempuri.org/Imports">
    			<xsd:import schemaLocation="http://localhost:8733/Design_Time_Addresses/SyncWcf/Service1/?xsd=xsd0" namespace="http://tempuri.org/"/>
    			<xsd:import schemaLocation="http://localhost:8733/Design_Time_Addresses/SyncWcf/Service1/?xsd=xsd1" namespace="http://schemas.microsoft.com/2003/10/Serialization/"/>
    			<xsd:import schemaLocation="http://localhost:8733/Design_Time_Addresses/SyncWcf/Service1/?xsd=xsd2" namespace="http://schemas.datacontract.org/2004/07/SyncWcf"/>
    		</xsd:schema>
    	</wsdl:types>
    	<wsdl:message name="IService1_GetData_InputMessage">
    		<wsdl:part name="parameters" element="tns:GetData"/>
    	</wsdl:message>
    	<wsdl:message name="IService1_GetData_OutputMessage">
    		<wsdl:part name="parameters" element="tns:GetDataResponse"/>
    	</wsdl:message>
    	<wsdl:message name="IService1_GetDataUsingDataContract_InputMessage">
    		<wsdl:part name="parameters" element="tns:GetDataUsingDataContract"/>
    	</wsdl:message>
    	<wsdl:message name="IService1_GetDataUsingDataContract_OutputMessage">
    		<wsdl:part name="parameters" element="tns:GetDataUsingDataContractResponse"/>
    	</wsdl:message>
    	<wsdl:portType name="IService1">
    		<wsdl:operation name="GetData">
    			<wsdl:input wsaw:Action="http://tempuri.org/IService1/GetData" message="tns:IService1_GetData_InputMessage"/>
    			<wsdl:output wsaw:Action="http://tempuri.org/IService1/GetDataResponse" message="tns:IService1_GetData_OutputMessage"/>
    		</wsdl:operation>
    		<wsdl:operation name="GetDataUsingDataContract">
    			<wsdl:input wsaw:Action="http://tempuri.org/IService1/GetDataUsingDataContract" message="tns:IService1_GetDataUsingDataContract_InputMessage"/>
    			<wsdl:output wsaw:Action="http://tempuri.org/IService1/GetDataUsingDataContractResponse" message="tns:IService1_GetDataUsingDataContract_OutputMessage"/>
    		</wsdl:operation>
    	</wsdl:portType>
    	<wsdl:binding name="BasicHttpBinding_IService1" type="tns:IService1">
    		<soap:binding transport="http://schemas.xmlsoap.org/soap/http"/>
    		<wsdl:operation name="GetData">
    			<soap:operation soapAction="http://tempuri.org/IService1/GetData" style="document"/>
    			<wsdl:input>
    				<soap:body use="literal"/>
    			</wsdl:input>
    			<wsdl:output>
    				<soap:body use="literal"/>
    			</wsdl:output>
    		</wsdl:operation>
    		<wsdl:operation name="GetDataUsingDataContract">
    			<soap:operation soapAction="http://tempuri.org/IService1/GetDataUsingDataContract" style="document"/>
    			<wsdl:input>
    				<soap:body use="literal"/>
    			</wsdl:input>
    			<wsdl:output>
    				<soap:body use="literal"/>
    			</wsdl:output>
    		</wsdl:operation>
    	</wsdl:binding>
    	<wsdl:service name="Service1">
    		<wsdl:port name="BasicHttpBinding_IService1" binding="tns:BasicHttpBinding_IService1">
    			<soap:address location="http://localhost:8733/Design_Time_Addresses/SyncWcf/Service1/"/>
    		</wsdl:port>
    	</wsdl:service>
    </wsdl:definitions>

## Convert to async

To make the service async we only need change the method signature and returing Tasks:

    [ServiceContract]
    public interface IService1
    {
        [OperationContract]
        Task<string> GetData(int value);

        [OperationContract]
        Task<CompositeType> GetDataUsingDataContract(CompositeType composite);

        // TODO: Add your service operations here
    }
	
	...
	
	public class Service1 : IService1
    {
        public async Task<string> GetData(int value)
        {
            return await Task.FromResult(string.Format("You entered: {0}", value));
        }

        public async Task<CompositeType> GetDataUsingDataContract(CompositeType composite)
        {
            if (composite == null)
            {
                throw new ArgumentNullException("composite");
            }
            if (composite.BoolValue)
            {
                composite.StringValue += "Suffix";
            }

            return await Task.FromResult(composite);
        }
    }
	
When we run this example and check the WSDL we will see that it is (besides some naming that I changed based on my samples) identical:

    <wsdl:definitions xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:wsx="http://schemas.xmlsoap.org/ws/2004/09/mex" xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd" xmlns:wsa10="http://www.w3.org/2005/08/addressing" xmlns:wsp="http://schemas.xmlsoap.org/ws/2004/09/policy" xmlns:wsap="http://schemas.xmlsoap.org/ws/2004/08/addressing/policy" xmlns:msc="http://schemas.microsoft.com/ws/2005/12/wsdl/contract" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:wsa="http://schemas.xmlsoap.org/ws/2004/08/addressing" xmlns:wsam="http://www.w3.org/2007/05/addressing/metadata" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:tns="http://tempuri.org/" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:wsaw="http://www.w3.org/2006/05/addressing/wsdl" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" name="Service1" targetNamespace="http://tempuri.org/">
    	<wsdl:types>
    		<xsd:schema targetNamespace="http://tempuri.org/Imports">
    			<xsd:import schemaLocation="http://localhost:8733/Design_Time_Addresses/AsyncWcf/Service1/?xsd=xsd0" namespace="http://tempuri.org/"/>
    			<xsd:import schemaLocation="http://localhost:8733/Design_Time_Addresses/AsyncWcf/Service1/?xsd=xsd1" namespace="http://schemas.microsoft.com/2003/10/Serialization/"/>
    			<xsd:import schemaLocation="http://localhost:8733/Design_Time_Addresses/AsyncWcf/Service1/?xsd=xsd2" namespace="http://schemas.datacontract.org/2004/07/AsyncWcf"/>
    		</xsd:schema>
    	</wsdl:types>
    	<wsdl:message name="IService1_GetData_InputMessage">
    		<wsdl:part name="parameters" element="tns:GetData"/>
    	</wsdl:message>
    	<wsdl:message name="IService1_GetData_OutputMessage">
    		<wsdl:part name="parameters" element="tns:GetDataResponse"/>
    	</wsdl:message>
    	<wsdl:message name="IService1_GetDataUsingDataContract_InputMessage">
    		<wsdl:part name="parameters" element="tns:GetDataUsingDataContract"/>
    	</wsdl:message>
    	<wsdl:message name="IService1_GetDataUsingDataContract_OutputMessage">
    		<wsdl:part name="parameters" element="tns:GetDataUsingDataContractResponse"/>
    	</wsdl:message>
    	<wsdl:portType name="IService1">
    		<wsdl:operation name="GetData">
    			<wsdl:input wsaw:Action="http://tempuri.org/IService1/GetData" message="tns:IService1_GetData_InputMessage"/>
    			<wsdl:output wsaw:Action="http://tempuri.org/IService1/GetDataResponse" message="tns:IService1_GetData_OutputMessage"/>
    		</wsdl:operation>
    		<wsdl:operation name="GetDataUsingDataContract">
    			<wsdl:input wsaw:Action="http://tempuri.org/IService1/GetDataUsingDataContract" message="tns:IService1_GetDataUsingDataContract_InputMessage"/>
    			<wsdl:output wsaw:Action="http://tempuri.org/IService1/GetDataUsingDataContractResponse" message="tns:IService1_GetDataUsingDataContract_OutputMessage"/>
    		</wsdl:operation>
    	</wsdl:portType>
    	<wsdl:binding name="BasicHttpBinding_IService1" type="tns:IService1">
    		<soap:binding transport="http://schemas.xmlsoap.org/soap/http"/>
    		<wsdl:operation name="GetData">
    			<soap:operation soapAction="http://tempuri.org/IService1/GetData" style="document"/>
    			<wsdl:input>
    				<soap:body use="literal"/>
    			</wsdl:input>
    			<wsdl:output>
    				<soap:body use="literal"/>
    			</wsdl:output>
    		</wsdl:operation>
    		<wsdl:operation name="GetDataUsingDataContract">
    			<soap:operation soapAction="http://tempuri.org/IService1/GetDataUsingDataContract" style="document"/>
    			<wsdl:input>
    				<soap:body use="literal"/>
    			</wsdl:input>
    			<wsdl:output>
    				<soap:body use="literal"/>
    			</wsdl:output>
    		</wsdl:operation>
    	</wsdl:binding>
    	<wsdl:service name="Service1">
    		<wsdl:port name="BasicHttpBinding_IService1" binding="tns:BasicHttpBinding_IService1">
    			<soap:address location="http://localhost:8733/Design_Time_Addresses/AsyncWcf/Service1/"/>
    		</wsdl:port>
    	</wsdl:service>
    </wsdl:definitions>

## Clients

The contract itself is still __the same__. You can still use the sync-methods on the client side, because WCF doesn't care (at least with the SOAP binding stuff). It would be clever to also update your client code, but you don't have to, that was the most important point for us.

## Async & OperationContext access

If you are accessing the OperationContext on the server side and using async methods you might stumble on an odd behaviour:

After the first access to [OperationContext.Current](https://docs.microsoft.com/en-us/dotnet/api/system.servicemodel.operationcontext.current?view=netframework-4.7.2) the value will disappear and OperationContext.Current will be null. This [Stackoverflow.com question](https://stackoverflow.com/questions/12797091/operationcontext-current-is-null-after-first-await-when-using-async-await-in-wcf) shows this "bug".

__The reason for this:__ There are some [edge cases](https://github.com/Microsoft/dotnet/issues/403), but if you are not using "Reentrant services" the behaviour can be changed with this setting:

    <appSettings>
      <add key="wcf:disableOperationContextAsyncFlow" value="false" />
    </appSettings>

With this setting if should work like before in the "sync"-world.
	
# Summery

"Async all the things" - even legacy WCF services can be turned into async task based APIs without breaking any clients. Checkout the sample code on [GitHub](https://github.com/Code-Inside/Samples/tree/master/2018/AsyncWcf).


Hope this helps!
