require 'httparty'
$:.unshift(File.dirname(__FILE__))
require "oauth/verify"

module VimeoMe2
  module Http

    class HttpRequest
      include VimeoMe2::Http::OAuth::Verify

      attr_reader :last_request
      attr_accessor :body, :headers, :query, :debug

      def initialize(token=nil)
        @token = token
        reset_request
      end

      def make_http_request(method, endpoint, allowed_status=200)
        log "#{method.upcase} #{prefix_endpoint(endpoint)} #{allowed_status}"
        call = HTTParty.public_send(method, prefix_endpoint(endpoint), http_request)
        @last_request = call
        validate_response!(call, allowed_status)
        reset_request
        return nil if call.response.body.nil?
        call.response.body.empty? ? call.response.body : JSON.parse(call.response.body)
      end

      def set_token token
        set_auth_header(token)
      end

      def add_header(key, value)
        @headers[key] = value
      end

      def add_headers(additional)
        @headers.merge!(additional) if additional.instance_of? Hash
      end

      def add_query(key, value)
        @query[key] = value
      end

      def add_queries(additional)
        @query.merge!(additional) if additional.instance_of? Hash
      end

      private

        def request_uri uri=nil
          "#{@base_uri}#{uri}"
        end

        def reset_request
          @headers = {}
          @body = {}
          @query = {}
          set_auth_header(@token) unless @token.nil?
        end

        def set_auth_header token
          add_header('authorization', "Bearer #{token}")
        end

        def http_request
          return {headers:@headers, body:@body, query:@query}
        end

        def prefix_endpoint endpoint
          /https?/.match(endpoint) ? endpoint : "https://api.vimeo.com#{endpoint}"
        end

        # Raises an exception if the response does contain a +stat+ different from "ok"
        def validate_response!(call, status)
          raise "empty call" unless call
          log "#{call.code} #{call.msg}"
          log ""
          status = [status] unless status.is_a? Array
          unless status.include? call.code
            if call.response.body.nil? || call.response.body.empty?
              raise RequestFailed.new(call.code, call.msg)
            else
              body = JSON.parse(call.response.body)
              raise RequestFailed.new(call.code, call.msg, body['error'])
            end
          end
        end

        def log(str)
          puts str if @debug
        end
    end
  end
end
