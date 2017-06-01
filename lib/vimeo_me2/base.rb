module VimeoMe2

  class VimeoObject

    attr_reader :client

    def initialize token
      @token = token
      @client = VimeoMe2::Http::HttpRequest.new(token)
      get_object
    end

  #  private
      def get_object
        request
      end

      def request(url=@base_uri, method:'get', code: 200, headers:nil, body:nil)
        @client.body = body
        @client.add_headers(headers)
        @client.make_http_request(method, url, code)
      end

      def get(url, **params)
        request request_uri(url), params
      end

      def post(url, **params)
        params[:method] = 'post'
        request request_uri(url), params
      end

      def delete(url, **params)
        params[:method] = 'delete'
        request request_uri(url), params
      end

      def put(url, **params)
        params[:method] = 'put'
        request request_uri(url), params
      end

      def patch(url, **params)
        params[:method] = 'patch'
        request request_uri(url), params
      end

      def request_uri uri=nil
        /http?/.match(uri) ? uri : "#{@base_uri}#{uri}"
      end
  end

  class RequestFailed < StandardError
    attr_reader :status, :error, :message

    def initialize(_error=nil, _status=nil, _message=nil)
      @error = _error || 422
      @status = _status || :unprocessable_entity
      @message = _message || 'Something went wrong'
    end
  end
end
