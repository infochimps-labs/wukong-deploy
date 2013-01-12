module Wukong
  module Deploy

    # A Runner class that implements wu-deploy.
    class DeployRunner < Wukong::Runner

      include Logging

      usage 'ACTION'

      description <<-EOF.gsub(/^ {8}/,'')
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

      # The action, or first argument given.
      #
      # @return [String]
      def action
        args.first
      end

      # The directory, or second argument given.
      #
      # @return [String]
      def directory
        args[1]
      end

      # Validate that the requested action is known and that its
      # arguments are valid.
      #
      # @return [true]
      # @raise [Wukong::Error] if the action or its arguments are invalid
      def validate
        case action
        when 'new'
          raise Error.new("Must provide a path to the root of the deploy pack you want to create") if directory.nil? || directory.blank?
        when 'console'
        else
          raise Error.new("Invalid action: <#{action}>.")
        end
        true
      end

      # Run the requested action.
      def run
        case action
        when 'new'
          require_relative('templater')
          Templater.new(File.expand_path(directory, Dir.pwd), settings).run!
        when 'console'
          require_relative('console')
          Wukong::Deploy::Console.new.run!
        end
      end
      
    end
  end
end
