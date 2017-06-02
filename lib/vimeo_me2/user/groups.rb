module VimeoMe2
  module UserMethods
    module Groups
      # Get all the groups a user joined
      def view_all_groups
        get("/groups")
      end

      # Check for a joined group
      # @param [String] group_id The ID of the group.
      def check_if_user_joined_group group_id
        get("/groups/#{group_id}", code:204)
        return true
      rescue VimeoMe2::RequestFailed
        return false
      end

      # Subscribe to a Group
      # @param [String] group_id The name of the Group.
      def subscribe_to_group group_id
        put("/groups/#{group_id}", code:204)
      end

      # Unsubscribe for a Group
      # @param [String] group_id The name of the Group.
      def unsubscribe_from_group group_id
        delete("/groups/#{group_id}",  code:204)
      end
    end
  end
end
