module VimeoMe2
  module UserMethods
    module Likes
      # Get all your likes
      def view_all_likes
        get("/likes")
      end

      # Check if video is liked
      # @param [String] video_id The ID of the group.
      def check_if_liked video_id
        get("/likes/#{video_id}", code:204)
        return true
      rescue VimeoMe2::RequestFailed
        return false
      end

      # Like a video
      # @param [String] video_id The name of the Group.
      def like_video video_id
        put("/likes/#{video_id}", code: 204)
      end

      # Unlike a video
      # @param [String] video_id The ID of the Video.
      def unlike_video video_id
        delete("/likes/#{video_id}", code: 204)
      end
    end
  end
end
