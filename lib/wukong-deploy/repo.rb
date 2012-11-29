module Wukong
  module Deploy
    class Repo

      attr_reader :root

      def initialize root
        @root = Pathname.new(root)
      end

      def app_dir *args
        root.join('app', *args)
      end

      def config_dir *args
        root.join('config', *args)
      end

      def data_dir *args
        root.join('data', *args)
      end
      
      def lib_dir *args
        root.join('lib', *args)
      end

      def log_dir *args
        root.join('log', *args)
      end

      def spec_dir *args
        root.join('spec', *args)
      end

      def tmp_dir *args
        root.join('tmp', *args)
      end
      
    end
  end
end

