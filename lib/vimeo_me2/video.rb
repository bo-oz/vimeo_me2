$:.unshift(File.dirname(__FILE__))
require "http/http_request"
require "video/comment"

module VimeoMe2
  class Video < VimeoMe2::Http::HttpRequest
    include VimeoMe2::VideoMethods::Comment

    attr_reader :video

    def initialize(token, video_id)
      @token = token
      @base_uri = "/videos/#{video_id}"
      reset_request
      @video = get_video
    end

    def delete
      check_authorization('delete')
      make_http_request('delete', request_uri )
    end

    def edit options = {}
      check_authorization('edit')
      @body = options
      make_http_request('patch', request_uri )
    end

    def categories
      make_http_request('get', request_uri('/categories'))
    end

    private

      def get_video
        JSON.parse(make_http_request('get', request_uri))
      end
  end
end
