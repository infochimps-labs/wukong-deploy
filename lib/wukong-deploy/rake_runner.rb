module Wukong
  module Deploy

    # A Runner class for booting up the environment within a Rake
    # task.
    class RakeRunner < Wukong::Runner

      include Logging

      # Load tasks that come with Wukong-Deploy.
      def load
        super()
        load_rspec_tasks
        load_generic_deploy_pack_tasks
        load_this_deploy_packs_tasks
      end

      # Run the requested action.
      def run
      end

      private

      # :nodoc:
      def load_rspec_tasks
        require 'rspec/core/rake_task'
        RSpec::Core::RakeTask.new(:spec)
      end

      # :nodoc:
      def load_generic_deploy_pack_tasks
        require 'wukong-deploy/tasks'
      end

      # :nodoc:
      def load_this_deploy_packs_tasks
        Wukong::Deploy.require_recursive('lib/tasks')
      end
      
    end
  end
end
