require 'pathname'
require 'fileutils'
require 'erubis'

require_relative('repo')

module Wukong
  module Deploy
    class Templater

      attr_accessor :repo
      attr_accessor :options

      include FileUtils::Verbose

      def initialize root, options={}
        self.repo    = Repo.new(root)
        self.options = options
      end

      def create
        create_dirs
        create_templates
        create_gitkeeps
        create_gitignore
      end

      def create_dirs
        repo.dirs_to_create.each { |dir| mkdir_p(dir) }
      end

      def create_templates
        repo.files_to_template.each do |repo_path|
          create_template(templates_dir.join("#{repo_path}.erb"), repo.root.join(repo_path))
        end
      end

      def create_template input_path, output_path, binding={}
        input  = File.read(input_path)
        erb    = Erubis::Eruby.new(input)
        output = erb.result(binding)
        action = File.exist?(output_path) ? 'modify' : 'create'
        puts "#{action} #{output_path}"
        File.open(output_path, 'w') { |f| f.puts(output) }
      end
      
      def create_gitkeeps
        repo.dirs_to_create.each do |dir|
          if Dir[File.join(dir, '*')].empty?
            touch(File.join(dir, '.gitkeep'))
          end
        end
      end

      def create_gitignore
        create_template(templates_dir.join('gitignore'), repo.root.join('.gitignore'))
      end

      def templates_dir
        @templates_dir ||= Pathname.new(File.expand_path('../../../templates', __FILE__))
      end
      
    end
  end
end
