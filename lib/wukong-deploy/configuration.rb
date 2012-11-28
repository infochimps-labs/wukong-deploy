module Wukong
  module Deploy

    # Pass in +settings+ that need to be modified for deploy-specific
    # settings *before* they are resolved.
    #
    # @param [Configliere::Param] settings
    def self.pre_resolve settings
      settings.define(:environment, :description => "The environment to run in", :default => 'development', :flag => 'e', :env_var => 'ICS_PLATFORM_ENV')
    end
    
  end

end
