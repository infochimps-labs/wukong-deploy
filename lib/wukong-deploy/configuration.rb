module Wukong
  module Deploy

    # Pass in +settings+ that need to be modified for deploy-specific
    # settings *before* they are resolved.
    #
    # @param [Configliere::Param] settings
    def self.configure settings
      settings.define(:environment, :description => "The environment to run in", :default => 'development', :flag => 'e', :env_var => 'ICS_PLATFORM_ENV')
      
      case executable
      when 'wu-hadoop'
        Wukong::Elasticsearch.configure(settings) if executable == 'wu-hadoop'
      end
    end
    
  end

end
