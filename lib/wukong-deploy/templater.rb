require_relative('repo')

module Wukong
  module Deploy
    class Templater

      attr_accessor :repo
      attr_accessor :options

      include FileUtils

      def initialize root, options={}
        self.repo    = Repo.new(root)
        self.options = options
      end

      def dirs_to_create
        
      end

      def create!
        mkdir_p repo.root
        
        mkdir_p repo.app_dir
        mkdir_p repo.app_dir
      end
      
    end
  end
end
