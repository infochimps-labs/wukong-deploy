module Wukong
  module Deploy
    module Messaging
      
      def message action, *objects
        puts [action.rjust(25), '  ', objects.map { |path| Pathname.new(path).relative_path_from(repo.root).to_s }.join(' ')].join
      end

      def message_create *objects
        message "\e[32m\e[1mcreate\e[0m", *objects
      end

      def message_conflict *objects
        message "\e[31m\e[1mconflict\e[0m", *objects
      end
      
      def message_replace *objects
        message "\e[31m\e[1mreplace\e[0m", *objects
      end

      def message_same *objects
        message "\e[34m\e[1msame\e[0m", *objects
      end
      
      def message_skip *objects
        message "\e[35m\e[1mskip\e[0m", *objects
      end
    end
  end
end

      
