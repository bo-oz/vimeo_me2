module VimeoMe2
  module UserMethods
    module Channel

      # Get all the channels a user follows
      def view_all_channels
        @client.check_authorization
        @client.make_http_request('get', request_uri("/channels") )
      end

      # Check for a Channel
      # @param [String] channel_id The ID of the channel.
      def check_channel channel_id
        @client.check_authorization
        @client.make_http_request('get', request_uri("/channels/#{channel_id}") )
      end

      # Subscribe to a Channel
      # @param [String] channel_id The ID of the channel.
      def subscribe_to_channel channel_id
        @client.check_authorization('interact')
        @client.make_http_request('put', request_uri("/channels/#{channel_id}") )
      end

      # Unsubscribe for a Channel
      # @param [String] channel_id The ID of the channel.
      def unsubscribe_from_channel channel_id
        @client.check_authorization('interact')
        @client.make_http_request('delete', request_uri("/channels/#{channel_id}") )
      end
    end
  end
end
