module VimeoMe2

  class VimeoObject

    attr_reader :client
    attr_accessor :api_version

    def initialize token, api_version = "3.4"
      @api_version = api_version
      @token = token
      @client = VimeoMe2::Http::HttpRequest.new(token)
      get_object
    end

    ["get", "post", "delete", "put","patch"].each do |method|
      define_method(method) do |url, **params|
        params[:method] = "#{method}"
        request request_uri(url), **params
      end
    end

    private
      def get_object
        request
      end

      def request(url=@base_uri, method:'get', code: 200, headers:nil, body:nil, query:nil)
        # Moved responsibility to reset the request to the beginning of a new call
        @client.reset_request
        @client.body = body
        # Vimeo API version 3.4 contains some breaking changes to things like upload
        # The endpoints implemented by VimeoMe2 all seem to work up to at least version 3.2
        # https://developer.vimeo.com/api/changelog#34
        @client.add_header('Accept', "application/vnd.vimeo.*+json;version=#{@api_version}")
        @client.add_header('User-Agent', 'Vimeo_Me2')
        @client.add_headers(headers)
        @client.add_queries(query)
        @client.make_http_request(method, url, code)
      end

      def request_uri uri=nil
        /http?/.match(uri) ? uri : "#{@base_uri}#{uri}"
      end
  end

  class RequestFailed < StandardError
    attr_reader :status, :error, :message, :ratelimit

    def initialize(_error=nil, _status=nil, _message=nil, _ratelimit=nil)
      @error = _error || 422
      @status = _status || :unprocessable_entity
      @message = _message || 'Something went wrong'
      @ratelimit = _ratelimit
    end
  end
end
