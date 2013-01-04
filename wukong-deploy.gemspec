# -*- encoding: utf-8 -*-
require File.expand_path('../lib/wukong-deploy/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'wukong-deploy'
  gem.homepage    = 'https://github.com/infochimps-labs/wukong-deploy'
  gem.licenses    = ["Apache 2.0"]
  gem.email       = 'coders@infochimps.com'
  gem.authors     = ['Infochimps', 'Dhruv Bansal', 'Travis Dempsey']
  gem.version     = Wukong::Deploy::VERSION

  gem.summary     = 'Defines the deploy pack framework used by the Infochimps Platform'
  gem.description = <<-EOF
  The Infochimps Platform is an end-to-end, managed solution for
  building Big Data applications.  It integrates best-of-breed
  technologies like Hadoop, Storm, Kafka, MongoDB, ElasticSearch,
  HBase, &c. and provides simple interfaces for accessing these
  powerful tools.

  Computation, analytics, scripting, &c. are all handled by Wukong
  within the platform.  Wukong is an abstract framework for defining
  computations on data.  Wukong processors and flows can run in many
  different execution contexts including:

    * locally on the command-line for testing or development purposes
    * as a Hadoop mapper or reducer for batch analytics or ETL
    * within Storm as part of a real-time data flow

  The Infochimps Platform uses the concept of a deploy pack for
  developers to develop all their processors, flows, and jobs within.
  EOF

  gem.files         = `git ls-files`.split("\n")
  gem.executables   = ['wu-deploy']
  gem.test_files    = gem.files.grep(/^spec/)
  gem.require_paths = ['lib']

  gem.add_dependency('wukong',        '3.0.0.pre3')
  gem.add_dependency('erubis')
  gem.add_dependency('diffy')
  gem.add_dependency('rake',     '~> 0.9')
end

