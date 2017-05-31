module VimeoMe2
  module UserMethods
    module Followers

      # Get all user followers
      def get_all_followers
        @client.check_authorization
        @client.make_http_request('get', request_uri("/followers") )
      end

    end
  end
end
