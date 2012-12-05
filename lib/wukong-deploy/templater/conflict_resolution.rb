require_relative("differ")

module Wukong
  module Deploy
    module ConflictResolution

      def handle_conflict(new_content, path)
        existing_content = File.read(path)
        case
        when new_content == existing_content
          message_same(path)
        when always_replace?
          message_replace(path)
          write_file(new_content, path)
        when never_replace?
          message_skip(path)
        else
          message_conflict(path)
          diff!(new_content, existing_content, path)
        end
      end

      def always_replace?
        @always_replace || options[:force]
      end

      def always_replace!
        @always_replace = true
      end

      def never_replace?
        @never_replace || options[:skip]
      end

      def never_replace!
        @never_replace = true
      end

      private    

      # :nodoc:
      def diff! new_content, existing_content, path
        differ = Differ.new(new_content, existing_content)
        differ.resolve!
        always_replace! if differ.always_replace?
        never_replace!  if differ.never_replace?
        if differ.replace?
          message_replace(path)
          write_file(new_content, path)
        else
          message_skip(path)
        end
      end

    end
  end
end
