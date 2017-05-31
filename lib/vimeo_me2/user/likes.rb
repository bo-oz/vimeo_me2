module VimeoMe2
  module UserMethods
    module Likes
      # Get all your likes
      def view_all_likes
        @client.check_authorization
        @client.make_http_request('get', request_uri("/likes") )
      end

      # Check if video is liked
      # @param [String] video_id The ID of the group.
      def check_if_liked video_id
        @client.check_authorization
        @client.make_http_request('get', request_uri("/likes/#{video_id}") )
      end

      # Like a video
      # @param [String] video_id The name of the Group.
      def like_video video_id
        @client.check_authorization('interact')
        @client.make_http_request('put', request_uri("/likes/#{video_id}") )
      end

      # Unlike a video
      # @param [String] video_id The ID of the Video.
      def unlinke_video video_id
        @client.check_authorization('interact')
        @client.make_http_request('delete', request_uri("/likes/#{video_id}") )
      end
    end
  end
end
