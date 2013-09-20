module Wukong
  module Deploy

    # Attaches to the hooks provided by the Wukong::Load::Syncer class
    # to write data to Vayacondios.
    module FTPSyncerOverride

      # Saves the syncer as a stash in Vayacondios.
      def before_sync
        super()
        Wukong::Deploy.vayacondios_client.set(vayacondios_topic, nil, self)
      end

      # Announces a successful sync and updates the last sync state
      # and time.
      def after_sync
        super()
        Wukong::Deploy.vayacondios_client.announce(vayacondios_topic, {
          success: true,
        }.tap { |e| e[:duration] = duration if duration })
        Wukong::Deploy.vayacondios_client.set!(vayacondios_topic, "last", { state: 1, time: Time.now.utc.to_i })
      end

      # Announces an error during a sync and updates the last sync
      # state and time.
      def on_error error
        super(error)
        Wukong::Deploy.vayacondios_client.announce(vayacondios_topic, success: false, error: error.class, message: error.message)
        Wukong::Deploy.vayacondios_client.set!(vayacondios_topic, "last", { state: 0, time: Time.now.utc.to_i })
      end
      
      # Returns the Vayacondios topic for this FTP syncer.
      #
      # @return [String] the Vayacondios topic
      def vayacondios_topic
        "listeners.sync-ftp-#{name}"
      end

      # Returns a representation of this FTP syncer suitable for a
      # Vayacondios stash.
      #
      # @return [Hash]
      def to_vayacondios
        {
          name:     name,
          protocol: settings[:protocol],
          username: settings[:username],
          password: (settings[:password] ? true : false),
          host:     settings[:host],
          port:     port,
          path:     settings[:path],
        }
      end

    end
  end
end
