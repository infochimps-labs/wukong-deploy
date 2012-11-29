require_relative('templater')

module Wukong
  module Deploy
    class Driver

      attr_accessor :settings
      attr_accessor :args

      def self.run(settings, *args)
        begin
          new(settings,*args).run!
        rescue Wukong::Error => e
          $stderr.puts(e.message)
          exit(1)
        end
      end

      def run!
      end

      def initialize settings, *args
        self.settings = settings
        self.args     = args
      end
      
    end
  end
end
