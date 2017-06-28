require "spec_helper"

module VimeoMe2

  describe User do


    before(:example) do
      VCR.use_cassette("vimeo-user") do
        @user = User.new('2081091e83977725227e878c4127ba39')
        @other_user = User.new('2081091e83977725227e878c4127ba39', 'staff')
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
          expect{@user = User.new('error-vimeo-token')}.to raise_error(VimeoMe2::RequestFailed)
        end
      end
    end

  end

end
