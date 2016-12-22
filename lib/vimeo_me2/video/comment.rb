module VimeoMe2
  module VideoMethods
    module Comment

      def comments
        make_http_request('get', request_uri('/comments'))
      end

      def add_comment text
        check_authorization('interact')
        @body['text'] = text
        make_http_request('post', request_uri('/comments'))
      end

      def view_comment comment_id
        make_http_request('get', request_uri("/comments/#{comment_id}"))
      end

      def edit_comment comment_id, text
        check_authorization('edit')
        @body['text'] = text
        make_http_request('patch', request_uri("/comments/#{comment_id}"))
      end

      def delete_comment comment_id
        check_authorization('delete')
        make_http_request('delete', request_uri("/comments/#{comment_id}"))
      end

    end
  end
end
