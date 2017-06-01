$:.unshift(File.dirname(__FILE__))
require "http/http_request"
require "video/comment"

module VimeoMe2
  class Video < VimeoMe2::VimeoObject
    include VimeoMe2::VideoMethods::Comment

    attr_reader :video, :video_id

    def initialize token, video_id
      set_uri video_id
      @video = super(token)
    end

    def load video_id
      set_uri video_id
      @video = get_object
    end

    def reload
      raise "No video selected, use load first" if @base_uri.nil?
      @video = get_object
    end

    def name= name
      @video['name'] = name
    end

    def name
      @video['name']
    end

    def update
      @client.body = @video
      @video = @client.make_http_request('patch', request_uri)
    end

    def delete
      @video = @client.make_http_request('delete', request_uri, 204)
      @base_uri = nil
    end

    private
      def set_uri video_id
        @base_uri = /videos?/.match(video_id) ? video_id : "/videos/#{video_id}"
      end
  end
end
