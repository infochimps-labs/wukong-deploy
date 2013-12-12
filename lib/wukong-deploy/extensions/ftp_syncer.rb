module Wukong
  module Deploy

    # Attaches to the hooks provided by the Wukong::Load::Syncer class
    # to write data to Vayacondios.
    module FTPSyncerOverride

      # Saves the syncer as a stash in Vayacondios.
      def before_sync
        super()
        Wukong::Deploy.vayacondios_client.set!(vayacondios_topic, 'ftp', self)
      end

      # Announces a successful sync and updates the last sync state
      # and time.
      def after_sync
        super()
        Wukong::Deploy.vayacondios_client.announce(vayacondios_topic, {
          success: true,
          step:    'ftp',
          files:   self.files,
        }.tap { |e| e[:duration] = duration if duration })
        Wukong::Deploy.vayacondios_client.set!(vayacondios_topic, "ftp.last", { state: 1, time: Time.now.utc.to_i })
      end

      # Announces an error during a sync and updates the last sync
      # state and time.
      def on_error error
        super(error)
        Wukong::Deploy.vayacondios_client.announce(vayacondios_topic, {
          success: false,
          step:    'ftp',
          error:   error.class,
          message: error.message,
          files:   self.files,
        })
        Wukong::Deploy.vayacondios_client.set!(vayacondios_topic, "ftp.last", { state: 0, time: Time.now.utc.to_i })
      end
      
      # Returns the Vayacondios topic for this FTP syncer.
      #
      # @return [String] the Vayacondios topic
      def vayacondios_topic
        "listeners.#{name}"
      end

      # Returns a representation of this FTP syncer suitable for a
      # Vayacondios stash.
      #
      # @return [Hash]
      def to_vayacondios
        {
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
