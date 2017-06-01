module VimeoMe2
  module UserMethods
    module Followers

      # Get all user followers
      def get_all_followers
        get("/followers")
      end

    end
  end
end
