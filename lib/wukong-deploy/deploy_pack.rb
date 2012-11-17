module Wukong
  module Deploy

    def self.environment
      Local::Configuration[:environment]
    end

    def self.root= path
      @root = Pathname.new(path)
    end
    
    def self.root
      @root ||= Pathname.new(File.expand_path("../..", __FILE__))
    end

    def self.data_dir
      root.join('data')
    end

    def self.config_dir
      root.join('config')
    end

    def self.tmp_dir
      root.join('tmp')
    end

    def self.log_dir
      root.join('log')
    end

    def self.app_dir
      root.join('app')
    end
    
    def self.boot! path=nil
      self.root = path if path
      capture_original_settings
      load_base_settings
      load_env_specific_settings
    end

    def self.capture_original_settings
      @original_settings = Wukong::Local::Configuration.dup
    end

    def self.original_settings
      @original_settings
    end

    def self.logger
      return @logger if @logger
      # FIXME -- want to use the Wukong logger here...
      require 'logger'
      @logger ||= defined?(Log) ? Log : Logger.new
    end

    private

    def self.load_base_settings
      load_settings_from_file(config_dir.join("settings.yml"))
    end

    def self.load_env_specific_settings
      load_settings_from_file(config_dir.join("environments", "#{environment}.yml"))
    end

    def self.load_settings_from_file path
      if File.exist?(path) && File.readable?(path) && File.file?(path)
        [:Local, :Hadoop, :Elasticsearch].each do |mod|
          Wukong.const_get(mod).const_get(:Configuration).read(path)
        end
      else
        logger.warn("Cannot read YAML file at #{path}.")
      end
    end

    def self.load_remote_settings
      # FIXME -- what is the procedure here?
    end
  end
end
