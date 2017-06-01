module VimeoMe2
  module UserMethods
    module Groups
      # Get all the groups a user joined
      def view_all_groups
        request(uri:"/groups")
      end

      # Check for a joined group
      # @param [String] group_id The ID of the group.
      def check_if_user_joined_group group_id
        request(uri:"/groups/#{group_id}")
      end

      # Subscribe to a Group
      # @param [String] group_id The name of the Group.
      def subscribe_to_channel group_id
        request(method:'put', uri:"/groups/#{group_id}")
      end

      # Unsubscribe for a Group
      # @param [String] group_id The name of the Group.
      def unsubscribe_from_channel group_id
        request(method:'delete', uri:"/groups/#{group_id}")
      end
    end
  end
end
