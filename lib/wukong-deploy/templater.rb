require 'pathname'
require 'fileutils'
require 'erubis'

require_relative('repo')
require_relative('templater/messaging')
require_relative('templater/conflict_resolution')

module Wukong
  module Deploy
    class Templater

      attr_accessor :repo
      attr_accessor :options

      include FileUtils
      include Messaging
      include ConflictResolution

      def initialize root, options={}
        self.repo    = Repo.new(root)
        self.options = options
      end

      def dry_run?
        @options[:dry_run]
      end

      def run!
        create_dirs
        create_templates
        create_gitkeeps
        create_gitignore
      end
      
      def create_dirs
        repo.dirs_to_create.each do |dir|
          create_directory(dir)
        end
      end

      def create_templates
        repo.files_to_template.each do |repo_path|
          create_template(templates_dir.join("#{repo_path}.erb"), repo.root.join(repo_path))
        end
      end

      def create_template input_path, output_path, binding={}
        input   = File.read(input_path)
        erb     = Erubis::Eruby.new(input)
        content = erb.result(binding)
        create_file(content, output_path)
      end
      
      def create_gitkeeps
        repo.dirs_to_create.each do |dir|
          if Dir[File.join(dir, '*')].empty?
            create_file(empty_file, File.join(dir, '.gitkeep'))
          end
        end
      end

      def create_gitignore
        create_template(templates_dir.join('gitignore'), repo.root.join('.gitignore'))
      end

      def templates_dir
        @templates_dir ||= Pathname.new(File.expand_path('../../../templates', __FILE__))
      end

      private

      def empty_file
        ""
      end
      
      def create_file content, path
        if File.exist?(path)
          handle_conflict(content, path)
        else
          message_create(path)
          write_file(content, path)
        end
      end

      def create_directory(dir)
        message_create(dir)
        return if dry_run?
        mkdir_p(dir)
      end

      def write_file content, path
        return if dry_run?
        File.open(path, 'w') { |f| f.write(content) }
      end

    end
  end
end
