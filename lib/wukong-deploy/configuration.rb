module Wukong
  module Deploy

    # Pass in +settings+ that need to be modified for deploy-specific
    # settings *before* they are resolved.
    #
    # @param [Configliere::Param] settings
    # @return [Configliere::Param] the newly configured settings
    def self.configure settings
      settings.define(:environment, :description => "The environment to run in", :default => 'development', :flag => 'e', :env_var => 'ICS_PLATFORM_ENV')
      
      case executable
      when 'wu-hadoop'
        Wukong::Elasticsearch.configure(settings) if executable == 'wu-hadoop'
      when 'wu-deploy'
        settings.define(:dry_run, :description => "Don't actually create or modify anything", :type => :boolean, :default => false)
        settings.define(:skip,    :description => "Skip existing files", :type => :boolean, :default => false)
        settings.define(:force,   :description => "Overwrite existing files", :type => :boolean, :default => false)
        def settings.usage
          "usage: wu-deploy ACTION [ --param=val | --param | -p val | -p ] ..."
        end
        settings.use(:commandline)
        settings.description = <<EOF
wu-deploy is a tool for creating and interacting with deploy packs.

You can create a new deploy pack

  $ wu-deploy new my_app

The `--force' and `--skip' options can be used to control how conflict
resolution works when creating files.  The `--dry_run` option can be
used to see what happens without doing it.

If you are within the directory of a deploy pack, you can enter an IRB
console with the deploy pack's environment already loaded:

  $ wu-deploy console
EOF
      end
      settings
    end

    # All configuration for Wukong::Deploy lives in this object.
    Configuration = configure(Configliere::Param.new) unless defined?(Configuration)
  end

end
