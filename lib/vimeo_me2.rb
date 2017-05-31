$:.unshift(File.dirname(__FILE__))
require "vimeo_me2/user"
require "vimeo_me2/video"
require "vimeo_me2/version"

module VimeoMe2
  class RequestFailed < StandardError
    attr_reader :status, :error, :message

    def initialize(_error=nil, _status=nil, _message=nil)
      @error = _error || 422
      @status = _status || :unprocessable_entity
      @message = _message || 'Something went wrong'
    end
  end
end
