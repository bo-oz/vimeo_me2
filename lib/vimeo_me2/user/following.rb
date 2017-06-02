module VimeoMe2
  module UserMethods
    module Following

      # View followed users
      def view_followed_users
        get('/following')
      end

      # Add a list of users to follow
      #
      # @param [String] users String of user URIs to follow
      # @param [Array] users Array of user URIs to follow
      def follow_users users
        body = {}
        body[:users] = users.is_a?(Array) ? users.join(',') : users
        post("/following", body:body)
      end

      # Check if user is following a specific user
      #
      # @param [String] user_id String of user ID
      def check_if_following_user user_id
        get("/following/#{user_id}", code:204)
        return true
      rescue VimeoMe2::RequestFailed
        return false
      end

      # Follow a specific user
      #
      # @param [String] user_id String of user ID
      def follow_user user_id
        put("/following/#{user_id}", code:204)
      end

      # Unfollow a specific user
      #
      # @param [String] user_id String of user ID
      def unfollow_user user_id
        delete("/following/#{user_id}", code:204)
      end

    end
  end
end
