module Wukong
  module Deploy

    # Attaches to the hooks provided by the Wukong::Load::Syncer class
    # to write data to Vayacondios.
    module S3SyncerOverride

      # Saves the syncer as a stash in Vayacondios.
      def before_sync
        super()
        Wukong::Deploy.vayacondios_client.set!(vayacondios_topic, 's3', self)
      end

      # Announces a successful sync and updates the last sync state
      # and time.
      def after_sync
        super()
        Wukong::Deploy.vayacondios_client.announce(vayacondios_topic, {
          success: true,
          step:    's3',
          bytes: (bytes || 0),
        }.tap { |e| e[:duration] = duration if duration })
        Wukong::Deploy.vayacondios_client.set!(vayacondios_topic, "s3.last", { state: 1, time: Time.now.utc.to_i })
      end

      # Announces an error during a sync and updates the last sync
      # state and time.
      def on_error error
        super(error)
        Wukong::Deploy.vayacondios_client.announce(vayacondios_topic, {
          success: false,
          step:    's3',
          error:   error.class,
          message: error.message,
        })
        Wukong::Deploy.vayacondios_client.set!(vayacondios_topic, "s3.last", { state: 0, time: Time.now.utc.to_i })
      end
      
      # Returns the Vayacondios topic for this S3Syncer.
      #
      # @return [String] the Vayacondios topic
      def vayacondios_topic
        "listeners.#{name}"
      end

      # Returns a representation of this S3Syncer suitable for a
      # Vayacondios stash.
      #
      # @return [Hash]
      def to_vayacondios
        {
          bucket:    s3_uri,
          region:    settings[:region],
        }
      end
    end
  end
end
