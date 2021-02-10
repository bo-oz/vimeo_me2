require "spec_helper"
require 'vimeo_me2'

describe VimeoMe2::Http::HttpRequest do
  subject(:req) { VimeoMe2::Http::HttpRequest.new('token') }

  describe 'make http request' do
    before(:example) do
      VCR.use_cassette("vimeo-video") do
        @own_video = VimeoMe2::Video.new('2081091e83977725227e878c4127ba39','219689930')
      end
    end

    it 'calls HTTPParty' do
      expect(HTTParty).to receive(:public_send).with('bla','https://api.vimeo.com', any_args).and_return(@own_video.client.last_request)
      req.make_http_request('bla', 'https://api.vimeo.com')
    end
  end

  describe 'repeat http request' do
    it 'should repeat the request' do
      expect(req).to receive(:make_http_request)
      req.repeat_http_request
    end
  end

  describe 'set_token' do
    it 'should call the header methid' do
      expect(req).to receive(:set_auth_header)
      req.set_token('test')
    end

    it 'should call the header methid' do
      req.set_token('test')
      expect(req.headers).to have_key('authorization')
      expect(req.headers['authorization']).to eq('Bearer test')
    end
  end

  describe 'add query' do
    it 'should add key value to the query' do
      req.add_query('key','value')
      expect(req.query).to have_key('key')
      expect(req.query['key']).to eq('value')
    end
  end
end
