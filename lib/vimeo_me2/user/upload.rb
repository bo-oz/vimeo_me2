module VimeoMe2
  module UserMethods
    module Upload

      # Upload a video object to the authenticated account
      #
      # @param [File] video A File that contains a valid video format
      def upload_video video
        @video = video
        #check_file_format!
        #check_user_quota!
        @ticket = get_upload_ticket
        uploaded_video = handle_upload
        change_name(uploaded_video)
        return uploaded_video
      end

      # Upload a video to the authenticated account
      #   The video is pulled automatically
      #
      # @param [String] name video name
      # @param [String] link a link to a video on the Internet that is accessible to Vimeo’s upload server
      def pull_upload name, link
        res = start_pull_upload link
        uploaded_video = res['uri']
        change_name uploaded_video, name

        return uploaded_video
      end

      #private

        def handle_upload
          start_upload
          verify_upload
          end_upload
        end

        def change_name uploaded_video, name = nil
          name = @video.original_filename if name.nil?

          video = VimeoMe2::Video.new(@token, uploaded_video)
          video.name = name
          video.update
        end

        # get an upload ticket which is neede for the upload
        def get_upload_ticket
          body = {:type => "streaming"}
          post('/videos', body:body, code:201)
        end

        # start the pull upload
        def start_pull_upload link
          body = {type: 'pull', link: link}
          post('/videos', body:body)
        end

        # start the upload
        def start_upload
          headers = {'Content-Type': @video.content_type}
          headers['Content-Length'] = @video.size.to_s
          @video.rewind
          body = @video.read(@video.size).to_s
          put(@ticket['upload_link_secure'], body:body, headers:headers)
        end

        # Verify the upload
        def verify_upload
          headers = {}
          headers['Content-Length'] = "0"
          headers['Content-Range'] = 'bytes */*'
          put(@ticket['upload_link_secure'], headers:headers, code:308)
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
          delete("https://api.vimeo.com#{@ticket['complete_uri']}", code:201)
          return @client.last_request.headers['location']
        end

        def check_file_format!

        end

        def check_user_quota!

        end
    end
  end
end
