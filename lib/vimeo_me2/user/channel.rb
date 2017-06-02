module VimeoMe2
  module UserMethods
    module Channel

      # Get all the channels a user follows
      def view_all_channels
        get("/channels")
      end

      # Check for a Channel
      # @param [String] channel_id The ID of the channel.
      def check_channel channel_id
        get("/channels/#{channel_id}", code:204)
        return true
      rescue VimeoMe2::RequestFailed
        return false
      end

      # Subscribe to a Channel
      # @param [String] channel_id The ID of the channel.
      def subscribe_to_channel channel_id
        put("/channels/#{channel_id}", code:204)
      end

      # Unsubscribe for a Channel
      # @param [String] channel_id The ID of the channel.
      def unsubscribe_from_channel channel_id
        delete("/channels/#{channel_id}", code:204)
      end
    end
  end
end
