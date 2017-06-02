module VimeoMe2
  module UserMethods
    module Category

      # Get all the categories a user follows
      def get_all_user_categories
        get("/categories")
      end

      # Check for a category
      # @param [String] category The name of the category.
      def check_category category
        get("/categories/#{category}", code:204)
        return true
      rescue VimeoMe2::RequestFailed
        return false
      end

      # Subscribe to a category
      # @param [String] category The name of the category.
      def subscribe_to_category category
        put("/categories/#{category}", code: 204)
      end

      # Unsubscribe for a category
      # @param [String] category The name of the category.
      def unsubscribe_from_category category
        delete("/categories/#{category}", code: 204)
      end
    end
  end
end
