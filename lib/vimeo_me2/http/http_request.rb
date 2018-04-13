require 'httparty'
$:.unshift(File.dirname(__FILE__))
require "oauth/verify"

module VimeoMe2
  module Http

    class HttpRequest
      include VimeoMe2::Http::OAuth::Verify

      attr_reader :method, :end_point, :last_request, :ratelimit, :allowed_status
      attr_accessor :body, :headers, :query, :debug

      def initialize(token=nil)
        @token = token
        reset_request
      end

      def make_http_request(method, end_point, allowed_status=200)
        @method = method
        @end_point = end_point
        @allowed_status = allowed_status
        print_request_to_console
        @last_request = HTTParty.public_send(@method, prefix_endpoint(@end_point), http_request)
        get_rate_limit_information
        validate_response!(@last_request, @allowed_status)
        return nil if @last_request.response.body.nil?
        @last_request.response.body.empty? ? @last_request.response.body : JSON.parse(@last_request.response.body)
      end

      # convenience method to replay the latest request
      def repeat_http_request
        make_http_request(@method, @end_point, @allowed_status)
      end

      def set_token token
        set_auth_header(token)
      end

      def add_header(key, value)
        @headers[key] = value
      end

      def add_headers(additional)
        @headers.merge!(additional) if additional.is_a? Hash
      end

      def add_query(key, value)
        @query[key] = value
      end

      def add_queries(additional)
        @query.merge!(additional) if additional.is_a? Hash
      end

      def reset_request
        @headers = {}
        @body = {}
        @query = {}
        set_auth_header(@token) unless @token.nil?
      end

      private

        def get_rate_limit_information
          @ratelimit = {
            'limit' => @last_request.headers['x-ratelimit-limit'],
            'remaining' => @last_request.headers['x-ratelimit-remaining'],
            'reset' => @last_request.headers['x-ratelimit-reset']
          }
        end

        def print_request_to_console
          log("#{@method.upcase} #{prefix_endpoint(@end_point)} #{@allowed_status}")
        end

        def request_uri uri=nil
          "#{@base_uri}#{uri}"
        end

        def set_auth_header token
          add_header('authorization', "Bearer #{token}")
        end

        def http_request
          return {headers:request_headers, body:formatted_body, query:@query}
        end

        def formatted_body
          @body.is_a?(Hash) ? @body.to_json : @body
        end

        def request_headers
          add_header('Content-Type', 'application/json') if @body.is_a?(Hash)
          @headers
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
              raise RequestFailed.new(call.code, call.msg, body['error'], @ratelimit)
            end
          end
        end

        def log(str)
          puts str if @debug
        end
    end
  end
end
