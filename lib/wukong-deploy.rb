# Require Wukong so we can write processors & dataflows and use
# build-in widgets.
require 'wukong'

require_relative 'wukong-deploy/deploy_pack'
require_relative 'wukong-deploy/deploy_runner'
require_relative 'wukong-deploy/rake_runner'

module Wukong
  # Provides some helper methods for loading the assets within a
  # deploy pack at runtime and for Wukong plugins to ask questions
  # about the deploy pack they're running in.
  module Deploy
    include Plugin

    # Configure the given settings object for use with Wukong::Deploy
    #
    # @param [Configliere::Param] settings the settings to configure
    # @param [String] program the name of the currently executing program
    def self.configure settings, program
      settings.define(:environment, :description => "The environment to run in", :default => 'development', :flag => 'e', :env_var => 'ICS_PLATFORM_ENV')

      case program
      when 'wu-deploy'
        settings.define(:dry_run, :description => "Don't actually create or modify anything", :type => :boolean, :default => false)
        settings.define(:skip,    :description => "Skip existing files", :type => :boolean, :default => false)
        settings.define(:force,   :description => "Overwrite existing files", :type => :boolean, :default => false)
      when 'wu-hadoop'
        require_relative('wukong-deploy/hadoop_extensions')
        settings[:command_prefix] = 'bundle exec'
      when 'wu-storm'
        require_relative('wukong-deploy/storm_extensions')
        settings[:command_prefix] = 'bundle exec'
      when 'wu-dump'
        require_relative('wukong-deploy/dump_extensions')
      when 'wu-sync', 'wu-sync-all'
        require_relative('wukong-deploy/sync_extensions')
      end
    end

    # Boot the deploy pack, reading all available +settings+ and
    # rooting it at the given +path+.
    #
    # @param [Configliere::Param] settings
    # @param [String] path
    def self.boot settings, path
# # Require just enough of wukong-hadoop to give us changes at the
# # processor level.  The rest is only required when running the
# # 'wu-hadoop' program.  Also grab configuration since we'll need it.
# require 'wukong-hadoop/extensions'

# # Grab configuration from Wonderdog.
# require 'wonderdog'

      
      @pre_deploy_settings = settings.dup
      @settings            = settings
      @root                = Pathname.new(path)
      read_common_settings
      read_environment_settings
      read_deploy_settings
      read_remote_settings
      @booted = true
    end

  end
end
