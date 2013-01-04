require 'pathname'
require 'fileutils'
require 'erubis'

require_relative('repo')
require_relative('templater/messaging')
require_relative('templater/conflict_resolution')

module Wukong
  module Deploy

    # Templates out a deploy pack repo in a given directory.
    class Templater

      # The Wukong::Deploy::Repo being templated.
      attr_accessor :repo

      # The Configliere::Param settings.
      attr_accessor :options

      include FileUtils
      include Messaging
      include ConflictResolution

      # Initialize a new Templater creating a deploy pack repository
      # at the given `root` using the given `options`.
      #
      # @param [String] root
      # @param [Hash] options
      def initialize root, options={}
        self.repo    = Repo.new(root)
        self.options = options
      end

      # Is this a dry run in which no files are actually created or
      # modified on disk?
      #
      # @return [true, nil]
      def dry_run?
        options[:dry_run]
      end

      # Run this templater.
      def run!
        if dry_run?
          puts "Would perform the following actions in #{repo.root}"
        else
          puts "Within #{repo.root}:"
        end
        create_dirs
        create_templates
        create_gitkeeps
        create_gitignore
      end

      # The directory containing templates used to generate the
      # corresponding files in the new deploy pack repository.
      #
      # @return [Pathname]
      def templates_dir
        @templates_dir ||= Pathname.new(File.expand_path('../../../templates', __FILE__))
      end
      
      private

      # :nodoc:
      def create_dirs
        repo.dirs_to_create.each do |dir|
          create_directory(dir)
        end
      end

      # :nodoc:
      def create_templates
        repo.files_to_template.each do |repo_path|
          create_template(templates_dir.join("#{repo_path}.erb"), repo.root.join(repo_path))
        end
      end

      # :nodoc:
      def create_template input_path, output_path, binding={}
        input   = File.read(input_path)
        erb     = Erubis::Eruby.new(input)
        content = erb.result(binding)
        create_file(content, output_path)
      end

      # :nodoc:
      def create_gitkeeps
        repo.dirs_to_create.each do |dir|
          if Dir[File.join(dir, '*')].empty?
            create_file(empty_file, File.join(dir, '.gitkeep'))
          end
        end
      end

      # :nodoc:
      def create_gitignore
        create_template(templates_dir.join('gitignore'), repo.root.join('.gitignore'))
      end

      # :nodoc:
      def empty_file
        ""
      end

      # :nodoc:
      def create_file content, path
        if File.exist?(path)
          handle_conflict(content, path)
        else
          message_create(path)
          write_file(content, path)
        end
      end

      # :nodoc:
      def create_directory(dir)
        message_create(dir)
        return if dry_run?
        mkdir_p(dir)
      end

      # :nodoc:
      def write_file content, path
        return if dry_run?
        File.open(path, 'w') { |f| f.write(content) }
      end

    end
  end
end
