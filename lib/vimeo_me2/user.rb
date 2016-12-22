$:.unshift(File.dirname(__FILE__))
require "user/upload"
require "user/album"
require "user/category"
require "user/channel"
require "user/feed"
require "user/followers"
require "user/following"
require "user/groups"
require "user/likes"
require "http/http_request"

module VimeoMe2
  class RequestFailed < StandardError; end

  class User < VimeoMe2::Http::HttpRequest
    include VimeoMe2::UserMethods::Album
    include VimeoMe2::UserMethods::Upload
    include VimeoMe2::UserMethods::Category
    include VimeoMe2::UserMethods::Channel
    include VimeoMe2::UserMethods::Feed
    include VimeoMe2::UserMethods::Followers
    include VimeoMe2::UserMethods::Following
    include VimeoMe2::UserMethods::Groups
    include VimeoMe2::UserMethods::Likes

    attr_accessor :video

    def initialize(token, user_id = nil)
      @token = token
      @base_uri = user_id ? "/users/#{user_id}" : "/me"
      reset_request
    end

  end
end
