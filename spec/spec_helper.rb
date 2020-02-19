$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "vimeo_me2"
require "vcr"
require 'simplecov'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.ignore_localhost = false
end

SimpleCov.start do
  add_filter '/spec/'
  add_group 'Files', '/lib/**/*'
end
