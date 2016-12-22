module VimeoMe2
  module UserMethods
    module Groups
      # Get all the groups a user joined
      def view_all_groups
        check_authorization
        make_http_request('get', request_uri("/groups") )
      end

      # Check for a joined group
      # @param [String] group_id The ID of the group.
      def check_if_user_joined_group group_id
        check_authorization
        make_http_request('get', request_uri("/groups/#{group_id}") )
      end

      # Subscribe to a Group
      # @param [String] group_id The name of the Group.
      def subscribe_to_channel group_id
        check_authorization('interact')
        make_http_request('put', request_uri("/groups/#{group_id}") )
      end

      # Unsubscribe for a Group
      # @param [String] group_id The name of the Group.
      def unsubscribe_from_channel group_id
        check_authorization('interact')
        make_http_request('delete', request_uri("/groups/#{group_id}") )
      end
    end
  end
end
