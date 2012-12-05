require 'diffy'

module Wukong
  module Deploy
    class Differ

      attr_accessor :new_content
      attr_accessor :existing_content

      def initialize new_content, existing_content
        self.new_content      = new_content
        self.existing_content = existing_content
      end
      
      def replace?
        @replace
      end

      def always_replace?
        @always_replace
      end

      def never_replace?
        @never_replace
      end

      def resolve!
        response = get_response
        case response
        when /^y/
          @replace        = true
        when /^Y/
          @replace        = true
          @always_replace = true
        when /^n/
          @replace        = false
        when /^N/
          @replace        = false
          @never_replace  = true
        end
      end

      def diff
        @diff = Diffy::Diff.new(new_content, existing_content, :allow_empty_diff => true, :diff => "-U 5", :include_diff_info => true)
      end

      def show_diff
        puts ''
        diff.each do |line|
          puts "    #{line}"
        end
        puts ''
      end

      def show_help
        puts "    Y - yes, overwrite this file and all other conflicts"
        puts "    y - yes, overwrite this file"
        puts "    N - no, skip this file and all other conflicts"
        puts "    n - no, skip this file"
        puts "    d - diff, show the differences between the existing file and the new file"
        puts "    q - quit, abort"
        puts "    h - help, show this help"
      end
      
      def get_response
        STDOUT.write '  Overwrite? (enter "h" for help) [YNynqdh]: '
        begin
          response = STDIN.readline.chomp.strip
        rescue EOFError, Interrupt => e
          exit(1)
        end
        case
        when response =~ /^(y|n|Y|N)/
          response
        when response =~ /^q/i
          exit(1)
        when response =~ /^d/i
          show_diff
          get_response
        when response =~ /^h/i
          show_help
          get_response
        else
          get_response
        end
      end
      
    end
  end
end
