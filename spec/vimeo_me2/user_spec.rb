require "spec_helper"
require 'vimeo_me2'

describe VimeoMe2::User do


  before(:example) do
    VCR.use_cassette("vimeo-user") do
      @user = VimeoMe2::User.new('2081091e83977725227e878c4127ba39')
      @other_user = VimeoMe2::User.new('2081091e83977725227e878c4127ba39', 'staff')
    end
  end

  context "#initialize" do

    it "initializes with a valid token" do
      expect(@user.client.last_request.code).to eq(200)
    end

    it "initializes with a valid token & user" do
      expect(@other_user.client.last_request.code).to eq(200)
    end

    it "gives an error when token is wrong" do
      VCR.use_cassette("vimeo-user-error") do
        expect{@user = VimeoMe2::User.new('error-vimeo-token')}.to raise_error(VimeoMe2::RequestFailed)
      end
    end
  end

  context '#videos' do

    before(:each) do
      VCR.use_cassette("vimeo-authenticated-user") do
        @is_pending = VCR.current_cassette.recording? && ENV['VIMEO_AUTHENTICATED_TOKEN'].nil?
        @authenticated_user = VimeoMe2::User.new(ENV['VIMEO_AUTHENTICATED_TOKEN']) unless @is_pending
      end
    end

    it 'returns user videos' do
      if @is_pending
        pending("ENV['VIMEO_AUTHENTICATED_TOKEN'] is not defined.")
        raise
      else
        VCR.use_cassette("vimeo-user-videos") do
          videos = @authenticated_user.get_video_list
          expect(@authenticated_user.client.last_request.code).to eq(200)
        end
      end
    end

    it 'returns specific user video' do
      if @is_pending
        pending("ENV['VIMEO_AUTHENTICATED_TOKEN'] is not defined.")
        raise
      else
        VCR.use_cassette("vimeo-user-videos") do
          video = @authenticated_user.get_video('219689930')
          expect(@authenticated_user.client.last_request.code).to eq(200)
        end
      end
    end

    it 'supports query string params' do
      if @is_pending
        pending("ENV['VIMEO_AUTHENTICATED_TOKEN'] is not defined.")
        raise
      else
        VCR.use_cassette("vimeo-user-videos-params") do
          videos = @authenticated_user.get_video_list(query: { per_page: 100 })
          expect(videos['per_page']).to eq(100)
        end
      end
    end

  end

end

