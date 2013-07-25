module Wukong
  module Deploy

    # A class to represent a deploy pack repository as a collection of
    # files on disk.
    class Repo

      # The names of the top level directories in the deploy pack.
      TOP_LEVEL_DIR_NAMES = %w[app config data lib log script spec tmp]

      # The root directory where this deploy pack repo is or will be
      # located.
      attr_reader :root

      # Initialize a new deploy pack repo at the given `root`.
      #
      # @param [String] root
      def initialize root
        @root = Pathname.new(root)
      end

      TOP_LEVEL_DIR_NAMES.each do |name|
        define_method("#{name}_dir") do |*args|
          root.join(name, *args)
        end
      end

      # The directories to create within this repo.
      #
      # @return [Array<String>]
      def dirs_to_create
        [
         root,
         app_dir('models'),
         app_dir('processors'),
         app_dir('flows'),
         app_dir('jobs'),
         
         config_dir('environments'),
         config_dir('initializers'),
         
         data_dir,
         lib_dir,
         log_dir,
         script_dir,
         
         spec_dir('models'),
         spec_dir('processors'),
         spec_dir('flows'),
         spec_dir('jobs'),
         spec_dir('support'),
         
         tmp_dir
        ]
      end

      # The files to template within this repo, relative to the repo's
      # #root.
      #
      # @return [Array<String>]
      def files_to_template
        %w[
         config/boot.rb
         config/application.rb
         config/environment.rb
         config/settings.yml
         config/environments/development.yml
         config/environments/test.yml
         config/environments/production.yml

         config/initializers/event_machine.rb

         Gemfile
         Rakefile
         README.md

         spec/spec_helper.rb
         ]
      end
      
    end
  end
end

