module VimeoMe2
  module UserMethods
    module Feed
      # Get all the channels a user follows
      def view_all_videos_in_feed
        @client.check_authorization('private')
        @client.make_http_request('get', request_uri("/feed") )
      end
    end
  end
end
