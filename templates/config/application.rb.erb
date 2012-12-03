# = config/application.rb
#
# Loads the deploy pack application and all supporting libraries
# including Wukong and any of its plugins.
#
# The load order is as follows:
#
# * [Wukong-Deploy](http://github.com/infochimps-labs/wukong-deploy) which loads all Wukong and Wukong plugins.
# * Any code you put in the `config/initializers` directory.  This is a good place to configure additional libraries to support your application.
# * Your application code itself, in the following order
#   * models
#   * processors
#   * flows
#   * jobs
#   * anything else
# 
# You can put code you want available but you don't intend to use in
# your application inside the `lib` directory.

#
# == Deploy Pack Framework
#

# Boot up first
require_relative("boot")

# Require the Wukong-Deploy plugin which will itself require and
# configure core Wukong and other plugins.
require 'wukong-deploy'

# Load initializers containing any requires or configuration code
# needed by the app.
Dir[File.dirname(__FILE__) + '/initializers/**/*.rb'].each { |path| require(path) }

#
# == Model Support
#
# We're going to use Gorillib, Infochimps' own library of useful
# methods and Ruby hacks.
require 'gorillib'
require 'gorillib/model/serialization'
require 'gorillib/object/blank'

#
# But you could use a more Rails-y support stack
# 
# require 'active_support'

#
# Or DataMapper
# 
# require 'dm-core'

#
# == Application Structure
#
#
# By default, we try not to be clever and just load *everything* in
# app/.  If you have a lot of application code, this may be slow on
# startup and you may want to only load common classes or define
# autoloads or whatever you want to do.
Dir[File.expand_path('../../app/models/**/*.rb', __FILE__)].each     { |path| require(path) }
Dir[File.expand_path('../../app/processors/**/*.rb', __FILE__)].each { |path| require(path) }
Dir[File.expand_path('../../app/flows/**/*.rb', __FILE__)].each      { |path| require(path) }
