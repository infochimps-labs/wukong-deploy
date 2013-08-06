module Wukong
  module Deploy
    module FTP

      # Provides methods that make it easier to write an FTP source
      # into Vayacondios.
      module VayacondiosMethods
        
        # Returns the Vayacondios topic for this FTP source.
        #
        # @return [String] the Vayacondios topic
        def vayacondios_topic
          "listeners.ftp_listener-#{settings[:name]}"
        end

        # Returns a representation of this FTP source suitable for a
        # Vayacondios stash.
        #
        # @return [Hash]
        def to_vayacondios
          {
            name:     settings[:name],
            protocol: settings[:protocol],
            username: settings[:username],
            password: (settings[:password] ? true : false),
            host:     settings[:host],
            port:     port,
            path:     settings[:path],
            bucket:   settings[:bucket],
          }
        end
      end

      # Provides methods for hooking writes to Vayacondios into the
      # lifecycle of an FTP source in the FTP runner.
      module VayacondiosHooks

        def before_each source
          super(source)
          Wukong::Deploy.vayacondios_client.set(source.vayacondios_topic, nil, source)
        end

        def after_each source, paths_processed
          super(source, paths_processed)
          Wukong::Deploy.vayacondios_client.announce(source.vayacondios_topic, mirrored: true, paths: paths_processed)
        end

        def on_error source, error
          super(source, error)
          Wukong::Deploy.vayacondios_client.announce(vayacondios_topic, mirrored: false, error: error.class, message: error.message)
        end
      end
    end
    
  end
end

