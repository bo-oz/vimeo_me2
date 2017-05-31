$:.unshift(File.dirname(__FILE__))
require "http/http_request"
require "video/comment"

module VimeoMe2
  class Video
    include VimeoMe2::VideoMethods::Comment

    attr_reader :video, :video_id

    def initialize token, video_id
      @client = VimeoMe2::Http::HttpRequest.new(token)
      @video_id = video_id
      @video = get_video
    end

    def load video_id
      @video_id = video_id
      @video = get_video
    end

    def reload
      raise "No video selected, use load first" if @video_id.nil?
      @video = get_video
    end

    def name= name
      @video['name'] = name
    end

    def name
      @video['name']
    end

    def update
      @client.check_authorization('edit')
      @client.body = @video
      @video = @client.make_http_request('patch', @video_id)
    end

    def delete
      @client.check_authorization('delete')
      @video = @client.make_http_request('delete', @video_id, 204)
      @video_id = nil
    end

    private
      def get_video
        @client.make_http_request('get', @video_id)
      end

  end
end
