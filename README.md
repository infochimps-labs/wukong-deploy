# Wukong Deploy Pack

The [Infochimps Platform](http://www.infochimps.com) is an end-to-end,
managed solution for building Big Data applications.  It integrates
best-of-breed technologies like [Hadoop](http://hadoop.apache.org/),
[Storm](https://github.com/nathanmarz/storm),
[Kafka](http://incubator.apache.org/kafka/),
[MongoDB](http://www.mongodb.org/),
[ElasticSearch](http://www.elasticsearch.org/),
[HBase](http://hbase.apache.org/), &c. and provides simple interfaces
for accessing these powerful tools.

Computation, analytics, scripting, &c. are all handled by
[Wukong](http://github.com/infochimps-labs/wukong) within the
platform.  Wukong is an abstract framework for defining computations
on data.  Wukong processors and flows can run in many different
execution contexts including:

  * locally on the command-line for testing or development purposes
  * as a Hadoop mapper or reducer for batch analytics or ETL
  * within Storm as part of a real-time data flow

The Infochimps Platform uses the concept of a deploy pack for
developers to develop all their processors, flows, and jobs within.
The deploy pack can be thought of as a container for all the necessary
Wukong code and plugins useful in the context of an Infochimps
Platform application.  It includes the following libraries:

* <a href="http://github.com/infochimps-labs/wukong">wukong</a>: The core framework for writing processors and chaining them together.
* <a href="http://github.com/infochimps-labs/wukong-hadoop">wukong-hadoop</a>: Run Wukong processors as mappers and reducers within the Hadoop framework.  Model Hadoop jobs locally before you run them.
* <a href="http://github.com/infochimps-labs/wonderdog">wonderdog</a>: Connect Wukong processors running within Hadoop to Elasticsearch as either a source or sink for data.

## Installation

The deploy pack is installed as a RubyGem:

```
$ sudo gem install wukong-deploy
```
