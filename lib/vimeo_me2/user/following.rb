module VimeoMe2
  module UserMethods
    module Following

      # View followed users
      def view_followed_users
        @client.check_authorization
        @client.make_http_request('get','/me/following')
      end

      # Add a list of users to follow
      #
      # @param [String] users String of user URIs to follow
      # @param [Array] users Array of user URIs to follow
      def follow_users users
        @client.check_authorization('interact')
        @client.body['users'] = users if users.is_a? String
        @client.body['users'] = user.join(',') if users.is_a? Array
        @client.make_http_request('post', request_uri("/following") )
      end

      # Check if user is following a specific user
      #
      # @param [String] user_id String of user ID
      def check_if_following_user user_id
        @client.check_authorization
        @client.make_http_request('get', request_uri("/following/#{user_id}") )
      end

      # Follow a specific user
      #
      # @param [String] user_id String of user ID
      def follow_user user_id
        @client.check_authorization
        @client.make_http_request('post', request_uri("/following/#{user_id}") )
      end

      # Unfollow a specific user
      #
      # @param [String] user_id String of user ID
      def unfollow_user user_id
        @client.check_authorization
        @client.make_http_request('delete', request_uri("/following/#{user_id}") )
      end

    end
  end
end
