module VimeoMe2
  module UserMethods
    module Feed
      # Get all the channels a user follows
      def view_all_videos_in_feed
        get("/feed")
      end
    end
  end
end
