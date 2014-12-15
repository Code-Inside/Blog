---
layout: post
title: "NoSQL for Windows Server, Azure & SQL Server with Apache Hadoop"
date: 2011-11-19 21:30
author: CI Team
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
&nbsp;

Microsoft promoted the Roadmap about the subject “<a href="http://www.microsoft.com/bigdata">Big Data</a>” lately at the <a href="http://www.sqlpass.org/">SQLPass</a>. <a href="http://hadoop.apache.org/">The Apache Projekt Hadoop</a> will be a main part of this program.

<strong>Hadoop? Mhh….?</strong>

Hadoop is a Framework or a System which includes different components. The aim is to conduct and analyze huge (and also unsorted) files.

The project includes these subprojects:

· <a href="http://hadoop.apache.org/common/"><strong>Hadoop Common</strong></a>: The common utilities that support the other Hadoop subprojects.

· <a href="http://hadoop.apache.org/hdfs/"><strong>Hadoop Distributed File System (HDFS™)</strong></a>: A distributed file system that provides high-throughput access to application data.

· <a href="http://hadoop.apache.org/mapreduce/"><strong>Hadoop MapReduce</strong></a>: A software framework for distributed processing of large data sets on compute clusters.

Other Hadoop-related projects at Apache include:

· <a href="http://avro.apache.org/"><strong>Avro™</strong></a>: A data serialization system.

· <a href="http://cassandra.apache.org/"><strong>Cassandra™</strong></a>: A scalable multi-master database with no single points of failure.

· <a href="http://incubator.apache.org/chukwa/"><strong>Chukwa™</strong></a>: A data collection system for managing large distributed systems.

· <a href="http://hbase.apache.org/"><strong>HBase™</strong></a>: A scalable, distributed database that supports structured data storage for large tables.

· <a href="http://hive.apache.org/"><strong>Hive™</strong></a>: A data warehouse infrastructure that provides data summarization and ad hoc querying.

· <a href="http://mahout.apache.org/"><strong>Mahout™</strong></a>: A Scalable machine learning and data mining library.

· <a href="http://pig.apache.org/"><strong>Pig™</strong></a>: A high-level data-flow language and execution framework for parallel computation.

· <a href="http://zookeeper.apache.org/"><strong>ZooKeeper™</strong></a>: A high-performance coordination service for distributed applications.

Hadoop is developed with Java and his home is the world of Linux because of this I was surprised to hear this announcement.



<strong>Hadoop &amp; Windows Azure/Server </strong>



According to the announcement Hadoop should be able to run on a Windows Server and it should be integrated into Windows Azure. The first Beta is planned to be published at the <a href="http://blogs.msdn.com/b/windowsazure/archive/2011/10/12/cross-post-microsoft-announces-big-data-roadmap-adopts-apache-hadoop-on-windows-azure.aspx">end of the year</a>. Afterwards follows the going live in the next year.



<strong>What means huge files? Who use this? </strong>



Probably Facebook has the main Hadoop Cluster – in <a href="http://www.dbms2.com/2009/05/11/facebook-hadoop-and-hive/">this Blogpost</a> you will found some numbers and facts. Impressive.

<strong>Javascript is everywhere! </strong>



A little thing that makes me, as a developer, laugh (and which maybe drives a lot of DBA’s crazy):

For developers, we will enable integration with Microsoft developer tools as well as invest in making Javascript a first class language for Big Data. We will do this by making it possible to write high performance Map/Reduce jobs using Javascript. Yes, Javascript Map/Reduce, you read it right.

Ha!

<strong>Tool support </strong>

There should be connectors for the SQL server which are meant to manage the communication between the worlds of NoSQL and SQL. Even Excel and Co. should be able to use the new opportunities. More technical details you will find <a href="http://blogs.technet.com/b/port25/archive/2011/10/12/microsoft-hadoop-and-big-data.aspx">here</a>.

Even if I’m not really affected by this news I think it is smart from Microsoft to look beyond their own nose. At least it has been the right decision in the past.
