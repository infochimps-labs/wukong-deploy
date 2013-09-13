module Wukong
  module Deploy

    # Makes the `MirroredFiles#dir` choose the
    # `Wukong::Deploy.tmp_dir`.
    module UsesLockfileOverride
      def lockfile_dir
        Wukong::Deploy.tmp_dir.to_s
      end
    end
  end
end
