require 'irb'
module Wukong
  module Deploy
    class Console

      def initialize
      end

      def run!
        ARGV.clear
        IRB.start
      end
    end
  end
end
