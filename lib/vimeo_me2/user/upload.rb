module VimeoMe2
  module UserMethods
    module Upload

      # Upload a video object to the authenticated account
      #
      # @param [File] video A File that contains a valid video format
      def upload_video video
        @video = video
        check_authorization('upload')
        check_file_format!
        check_user_quota!
        @ticket = get_upload_ticket
        start_upload(@ticket['upload_link_secure'])
        verify_upload(@ticket['upload_link_secure'], @ticket['complete_uri'])
      end

      #private

        # get an upload ticket which is neede for the upload
        def get_upload_ticket
          @body[:type] = "streaming"
          make_http_request('post','/me/videos')
        end

        # start the upload
        def start_upload endpoint
          add_header('content-type', @video.content_type)
          add_header('content-length', @video.size.to_s)
          @video.rewind
          @body = @video.read(@video.size).to_s
          return make_http_request('put', endpoint)
        end

        # Verify the upload
        def verify_upload endpoint, complete_uri
          add_header('content-length', "0")
          add_header('content-range', 'bytes */*')
          verify_upload = make_http_request('put', endpoint)
          if verify_upload.range.max.max == @video.size
            end_upload(complete_uri)
          end
        end

        # End the upload is the upload was verified
        #
        # @param [String] complete_uri The complete uri to end upload
        def end_upload complete_uri
          deleter = make_http_request('delete', complete_uri)
          if deleter.code == 201
            puts "Succesfull uploaded to Vimeo"
          end
        end

        def check_file_format!

        end

        def check_user_quota!

        end
    end
  end
end
