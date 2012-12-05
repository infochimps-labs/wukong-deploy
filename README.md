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

## Usage

Wukong-Deploy provides a command-line tool `wu-deploy` which can be
used to create or interact with deploy packs.

### Creating a New Deploy Pack

Create a new deploy pack:

```
$ wu-deploy new my_app
Within /home/user/my_app:
      create  .
      create  app/models
      create  app/processors
	  ...
```

This will create a directory `my_app` in the current directory.
Passing the `dry_run` option will print what should happen without
actually doing anything:

```
$ wu-deploy new my_app --dry_run
Within /home/user/my_app:
      create  .
      create  app/models
      create  app/processors
	  ...
```

You'll be prompted if there is a conflict.  You can pass the `force`
option to always overwrite files and the `skip` option to never
overwrite files.

### Working with an Existing Deploy Pack

If your current directory is within an existing deploy pack you can
start up an IRB console with the deploy pack's environment already
loaded:

```
$ wu-deploy console
irb(main):001:0> 
```


## File Structure

A deploy pack is a repository with the following
[Rails](http://rubyonrails.org/)-like file structure:

```
├──   app
│   ├──   models
│   ├──   processors
│   ├──   flows
│   └──   jobs
├──   config
│   ├──   environment.rb
│   ├──   application.rb
│   ├──   initializers
│   ├──   settings.yml
│   └──   environments
│       ├──   development.yml
│       ├──   production.yml
│       └──   test.yml
├──   data
├──   Gemfile
├──   Gemfile.lock
├──   lib
├──   log
├──   Rakefile
├──   spec
│   ├──   spec_helper.rb
│   └──   support
└──   tmp
```

Let's look at it piece by piece:

* <b>app</b>: The directory with all the action.  It's where you define:
  * <b>models</b>: Your domain models or "nouns", which define and wrap the different kinds of data elements in your application.  They are built using whatever framework you like (defaults to [Gorillib](http://github.com/infochimps-labs/gorillib))
  * <b>processors</b>: Your fundamental operations or "verbs", which are passed records and parse, filter, augment, normalize, or split them.
  * <b>flows</b>: Chain together processors into streaming flows for ingestion, real-time processing, or [complex event processing](http://en.wikipedia.org/wiki/Complex_event_processing) (CEP)
  * <b>jobs</b>: Pair processors together to create batch jobs to run in Hadoop
* <b>config</b>: Where you place all application configuration for all environments
  * <b>environment.rb</b>: Defines the runtime environment for all code, requiring and configuring all Wukong framework code.  You shouldn't have to edit this file directly.
  * <b>application.rb</b>: Require and configure libraries specific to your application.  Choose a model framework, pick what application code gets loaded by default (vs. auto-loaded).
  * <b>initializers</b>: Holds any files you need to load before <b>application.rb</b> here.  Useful for requiring and configuring external libraries.
  * <b>settings.yml</b>: Defines application-wide settings.
  * <b>environments</b>: Defines environment-specific settings in YAML files named after the environment.  Overrides <b>config/settings.yml</b>.
* <b>data</b>: Holds sample data in flat files.  You'll develop and test your application using this data.
* <b>Gemfile</b> and <b>Gemfile.lock</b>: Defines how libraries are resolved with [Bundler](http://gembundler.com/).
* <b>lib</b>: Holds any code you want to use in your application but that isn't "part of" your application (like vendored libraries, Rake tasks, &c.).
* <b>log</b>: A good place to stash logs.
* <b>Rakefile</b>: Defines [Rake](http://rake.rubyforge.org/) tasks for the development, test, and deploy of your application.
* <b>spec</b>: Holds all your [RSpec](http://rspec.info/) unit tests.
  * <b>spec_helper.rb</b>: Loads libraries you'll use during testing, includes spec helper libraries from Wukong.
  * <b>support</b>: Holds support code for your tests.
* <b>tmp</b>: A good place to stash temporary files.
