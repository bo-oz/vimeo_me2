module VimeoMe2
  module UserMethods
    module Likes
      # Get all your likes
      def view_all_likes
        request(uri:"/likes")
      end

      # Check if video is liked
      # @param [String] video_id The ID of the group.
      def check_if_liked video_id
        request(uri:"/likes/#{video_id}")
      end

      # Like a video
      # @param [String] video_id The name of the Group.
      def like_video video_id
        request(method: 'put', uri:"/likes/#{video_id}")
      end

      # Unlike a video
      # @param [String] video_id The ID of the Video.
      def unlinke_video video_id
        request(method:'delete', uri:"/likes/#{video_id}")
      end
    end
  end
end
