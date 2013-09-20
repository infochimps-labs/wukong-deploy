module Wukong
  module Deploy

    # Makes `UsesLockfile#lockfile_dir` default to the
    # `Wukong::Deploy.tmp_dir`.
    module UsesLockfileOverride

      # Overrides the default value of #lockfile_dir with
      # Wukong::Deploy.tmp_dir.
      #
      # @return [String]
      def lockfile_dir
        Wukong::Deploy.tmp_dir.to_s
      end
    end
  end
end
