module VimeoMe2
  module VideoMethods
    module Comment

      def comments
        get('/comments')
      end

      def add_comment text
        body['text'] = text
        post('/comments', body:body)
      end

      def view_comment comment_id
        get("/comments/#{comment_id}")
      end

      def edit_comment comment_id, text
        body['text'] = text
        patch("/comments/#{comment_id}", body:body)
      end

      def delete_comment comment_id
        delete("/comments/#{comment_id}")
      end

    end
  end
end
