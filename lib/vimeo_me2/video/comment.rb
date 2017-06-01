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
        @client.check_authorization('delete')
        @client.make_http_request('delete', request_uri("/comments/#{comment_id}"))
      end

    end
  end
end
