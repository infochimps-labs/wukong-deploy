require 'irb'
module Wukong
  module Deploy

    # A class to wrap a basic IRB session.
    class Console

      # Initialize this Console.
      def initialize
      end

      # Start this Console.
      def run!
        ARGV.clear
        IRB.start
      end
    end
  end
end
