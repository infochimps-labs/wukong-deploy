module Wukong
  module Deploy
    class Repo

      TOP_LEVEL_DIR_NAMES = %w[app config data lib log script spec tmp]
      
      attr_reader :root

      def initialize root
        @root = Pathname.new(root)
      end

      TOP_LEVEL_DIR_NAMES.each do |name|
        define_method("#{name}_dir") do |*args|
          root.join(name, *args)
        end
      end

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

      def files_to_template
        %w[
         config/boot.rb
         config/application.rb
         config/environment.rb
         config/settings.yml
         config/environments/development.yml
         config/environments/test.yml
         config/environments/production.yml

         Gemfile
         Rakefile
         README.md

         spec/spec_helper.rb
         ]
      end
      
    end
  end
end

