module VimeoMe2
  module UserMethods
    module Category

      # Get all the categories a user follows
      def get_all_user_categories
        @client.check_authorization
        @client.make_http_request('get',request_uri("/categories") )
      end

      # Check for a category
      # @param [String] category The name of the category.
      def check_category category
        @client.check_authorization
        @client.make_http_request('get', request_uri("/categories/#{category}") )
      end

      # Subscribe to a category
      # @param [String] category The name of the category.
      def subscribe_to_category category
        @client.check_authorization('interact')
        @client.make_http_request('put', request_uri("/categories/#{category}") )
      end

      # Unsubscribe for a category
      # @param [String] category The name of the category.
      def unsubscribe_from_category category
        @client.check_authorization('interact')
        @client.make_http_request('delete', request_uri("/categories/#{category}"))
      end
    end
  end
end
