module Wukong
  module Deploy

    # Makes `UsesFileState#file_state_dir` default to the
    # `Wukong::Deploy.tmp_dir`.
    module UsesFileStateOverride

      # Overrides the default value of #file_state_dir with
      # Wukong::Deploy.tmp_dir.
      #
      # @return [String]
      def file_state_dir
        Wukong::Deploy.tmp_dir.to_s
      end
    end
  end
end
