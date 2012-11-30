

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
        case args.first
        when 'new'
          require_relative('templater')
          raise Error.new("Must provide a path to the root of the deploy pack you want to create") if args[1].nil? || args[1].blank?
          Templater.new(File.expand_path(args[1], Dir.pwd)).create
        when 'console'
          require_relative('console')
          Wukong::Deploy::Console.new.run!
        else
          settings.dump_help
          exit(2)
        end
      end

      def initialize settings, *args
        self.settings = settings
        self.args     = args
      end
      
    end
  end
end
