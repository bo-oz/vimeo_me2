module VimeoMe2
  module VideoMethods
    module Comment

      def comments
        @client.make_http_request('get', request_uri('/comments'))
      end

      def add_comment text
        @client.check_authorization('interact')
        @client.body['text'] = text
        @client.make_http_request('post', request_uri('/comments'))
      end

      def view_comment comment_id
        @client.make_http_request('get', request_uri("/comments/#{comment_id}"))
      end

      def edit_comment comment_id, text
        @client.check_authorization('edit')
        @client.body['text'] = text
        @client.make_http_request('patch', request_uri("/comments/#{comment_id}"))
      end

      def delete_comment comment_id
        @client.check_authorization('delete')
        @client.make_http_request('delete', request_uri("/comments/#{comment_id}"))
      end

    end
  end
end
