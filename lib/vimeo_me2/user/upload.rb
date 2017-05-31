module VimeoMe2
  module UserMethods
    module Upload

      # Upload a video object to the authenticated account
      #
      # @param [File] video A File that contains a valid video format
      def upload_video video
        @video = video
        @client.check_authorization('upload')
        check_file_format!
        check_user_quota!
        @ticket = get_upload_ticket
        uploaded_video = handle_upload
        change_name(uploaded_video)
        return uploaded_video
      end

      #private

        def handle_upload
          start_upload
          verify_upload
          end_upload
        end

        def change_name uploaded_video
          video = VimeoMe2::Video.new(@token, uploaded_video)
          video.name = @video.original_filename
          video.update
        end

        # get an upload ticket which is neede for the upload
        def get_upload_ticket
          @client.body[:type] = "streaming"
          @client.make_http_request('post','/me/videos', 201)
        end

        # start the upload
        def start_upload
          @client.add_header('Content-Type', @video.content_type)
          @client.add_header('Content-Length', @video.size.to_s)
          @video.rewind
          @client.body = @video.read(@video.size).to_s
          @client.make_http_request('put', @ticket['upload_link_secure'])
        end

        # Verify the upload
        def verify_upload
          @client.add_header('Content-Length', "0")
          @client.add_header('Content-Range', 'bytes */*')
          @client.make_http_request('put', @ticket['upload_link_secure'], 308)
          if @client.last_request.range.max.max == @video.size
            return true
          else
            #fix the broken upload and reupload a part of the video again
          end
        end

        # End the upload is the upload was verified
        #
        # @param [String] complete_uri The complete uri to end upload
        def end_upload
          @client.make_http_request('delete', @ticket['complete_uri'], 201)
          return @client.last_request.headers['location']
        end

        def check_file_format!

        end

        def check_user_quota!

        end
    end
  end
end
