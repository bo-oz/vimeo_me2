$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
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
  track_files "lib/vimeo_mw2/**/*.rb"
end
