module Wukong
  module Deploy

    # Attaches to the hooks provided by the Wukong::Load::Syncer class
    # to write data to Vayacondios.
    module PrepareSyncerOverride

      # Saves the syncer as a stash in Vayacondios.
      def before_sync
        super()
        Wukong::Deploy.vayacondios_client.set!(vayacondios_topic, 'prepare', self)
      end

      # Announces a successful sync and updates the last sync state
      # and time.
      def after_sync
        super()
        Wukong::Deploy.vayacondios_client.announce(vayacondios_topic, {
          success: success?,
          step:    'prepare',
          counts:   counts,
          files:    files,
        }.tap { |e| e[:duration] = duration if duration })
        Wukong::Deploy.vayacondios_client.set!(vayacondios_topic, "prepare.last", { state: (success? ? 1 : 0), time: Time.now.utc.to_i })
      end

      # Announces an error during a sync and updates the last sync
      # state and time.
      def on_error error
        super(error)
        Wukong::Deploy.vayacondios_client.announce(vayacondios_topic, {
          success: false,
          step:    'prepare',
          error:   error.class,
          message: error.message,
          counts:   counts,
          files:    files,
        })
        Wukong::Deploy.vayacondios_client.set!(vayacondios_topic, "prepare.last", { state: 0, time: Time.now.utc.to_i })
      end
      
      # Returns the Vayacondios topic for this PrepareSyncer.
      #
      # @return [String] the Vayacondios topic
      def vayacondios_topic
        "listeners.#{name}"
      end

      # Returns a representation of this PrepareSyncer suitable for a
      # Vayacondios stash.
      #
      # @return [Hash]
      def to_vayacondios
        {
          split:     settings[:split],
          lines:     settings[:lines],
          bytes:     settings[:bytes],
          ordered:   settings[:ordered],
          metadata:  settings[:metadata],
        }
      end

      module HandlerOverride

        # The topic for this Handler.
        #
        # Delegates to PrepareSyncer#vayacondios_topic.
        #
        # @return [String]
        def vayacondios_topic
          syncer.vayacondios_topic
        end

        # Announce the file was processed.
        #
        # @param [Pathname] original
        def after_process original
          super(original)
          Wukong::Deploy.vayacondios_client.announce(vayacondios_topic, {
            success: true,
            step:    'prepare',
            path:    fragment_for(original),
            size:    File.size(original),
          })
        end

        # Announce an error in processing a file.
        #
        # @param [Pathname] original
        # @param [Error] error
        def on_error original, error
          super(original, error)
          Wukong::Deploy.vayacondios_client.announce(vayacondios_topic, {
            success: false,
            step:    'prepare',
            path:    fragment_for(original),
            error:   error.class,
            message: error.message
          })
        end
        
      end
    end
  end
end
