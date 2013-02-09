# Welcome to the Infochimps Platform!

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

* <a href="http://github.com/infochimps-labs/wukong/tree/3.0.0">wukong</a>: The core framework for writing processors and chaining them together.
* <a href="http://github.com/infochimps-labs/wukong-hadoop">wukong-hadoop</a>: Run Wukong processors as mappers and reducers within the Hadoop framework.  Model Hadoop jobs locally before you run them.
* <a href="http://github.com/infochimps-labs/wonderdog">wonderdog</a>: Connect Wukong processors running within Hadoop to Elasticsearch as either a source or sink for data.
* <a href="http://github.com/infochimps-labs/wukong-deploy">wukong-deploy</a>: Code for coordinating Wukong and its plugins in a deploy pack.

**This is your deploy pack!** You will build your data processing
pipelines and Hadoop jobs within this repo.

## Setup

### Dependencies

In order to install and run a deploy pack you need the following
dependencies:

#### Ruby 1.9.x

Wukong and the deploy pack framework will only run on Ruby 1.9.  There
are a lot of [online
instructions](http://www.ruby-lang.org/en/downloads/) you can use to
get Ruby 1.9 (and RubyGems) installed and configured on your local
system.

If you use [rvm](https://rvm.io/) or
[rbenv](https://github.com/sstephenson/rbenv) to manage your Ruby
installations, make sure you install all gems appropriately and invoke
bundler appropriately in what follows.

#### Git

You'll need [Git](http://git-scm.com/) to push/pull your deploy pack
code to/from the Infochimps Platform.

### Creating/Cloning the Deploy Pack

The first thing you need to do to get started is get a local copy of
this deploy on your computer.  If you have already been giving a
deploy pack by Infochimps then you'll want to clone it:

```
$ git clone <your-deploy-pack-git-url>
```

If you are creating a deploy pack from scratch you'll want to use the
`wu-deploy` tool to create the scaffold of your deploy pack for you:

```
$ sudo gem install wukong-deploy
$ wu-deploy new <my-app-name>
```

Once you have the deploy pack on disk, you can install the
dependencies and

### Installation

From within the root of your deploy pack run the following commands

```
$ sudo gem install bundler
$ bundle install
```

If you're using [rbenv](https://github.com/sstephenson/rbenv) you may
want to run `rbenv exec bundle install`.

### Configuration

Your deploy pack doesn't need any configuration out of the box.  As
you begin to extend it you may add functionality which benefits from
the ability to be configured.

Put any configuration you want shared across all environments into the
file `config/settings.yml`.  Override this with environment-specific
configuration in the appropriate file within `config/environments`.

As an example, you may write a processor like this:

```ruby
Wukong.procesor(:configurable_decorator) do
  field :suffix, String, :default => '.'
  def process record
    yield [record, suffix].join
  end
end
```

This processor's `suffix` property can be set on the command-line:

```
$ cat input
1
2
3
$ cat input | wu-local configurable_decorator
1.
2.
3.
$ cat input | wu-local configurable_decorator --suffix=','
1,
2,
3,

You can also set the same property in a configuration file, scoped by
the name of the processor:

```yaml
# in config/settings.yml
---

configurable_decorator:
  suffix: ,
```

which lets you the `--suffix` flag on the command-line while still
overriding the default setting.  You can also put such settings in
environment specific files within `config/environments`.

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

## Writing your first models, processors, flows, and jobs

Before you start developing, it might be helpful to read up on some of
the underlying documentation for Wukong and its plugins, specifically:

* on [Wukong](http://github.com/infochimps-labs/wukong/tree/3.0.0) so you understand the basic idea of a processor and how to glue processors together
* on [Wukong-Hadoop](http://github.com/infochimps-labs/wukong-hadoop) so you understand how to move between local and Hadoop modes for batch analytics
