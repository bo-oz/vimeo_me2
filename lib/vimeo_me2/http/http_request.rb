require 'httparty'
$:.unshift(File.dirname(__FILE__))
require "oauth/verify"

module VimeoMe2
  module Http

    class HttpRequest
      include VimeoMe2::Http::OAuth::Verify

      attr_reader :last_request

      def initialize(token=nil)
        @token = token
        reset_request
      end

      def make_http_request(method, endpoint)
        call = HTTParty.public_send(method, prefix_endpoint(endpoint), http_request)
        validate_response!(call)
        reset_request
        return JSON.parse(call) if call.is_a? Hash
        return call
      end

      def set_token token
        set_auth_header(token)
      end

      private

        def request_uri uri=nil
          "#{@base_uri}#{uri}"
        end

        def reset_request
          @headers = {}
          @body = {}
          set_auth_header(@token) unless @token.nil?
        end

        def add_header(key, value)
          @headers[key.to_sym] = value
        end

        def add_headers(additional)
          @headers.merge!(additional) if additional.instance_of? Hash
        end

        def set_auth_header token
          add_header('authorization', "Bearer #{token}")
        end

        def http_request
          return {headers:@headers, body:@body}
        end

        def prefix_endpoint endpoint
          /https?/.match(endpoint) ? endpoint : "https://api.vimeo.com#{endpoint}"
        end

        # Raises an exception if the response does contain a +stat+ different from "ok"
        def validate_response!(call)
          raise "empty call" unless call
          @last_request = call
          unless call.response.code.in? %w(200 201 204)
            error = JSON.parse(call)
            if error
              raise RequestFailed, "#{call.response.code}: #{call.response.msg}, explanation: #{error['error']}"
            else
              raise RequestFailed, "Error: #{call.response.code}: #{call.response.msg}, no error message"
            end
          end
        end
    end

  end
end
