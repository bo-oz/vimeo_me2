module VimeoMe2
  module UserMethods
    module Upload

      # Upload a video object to the authenticated account
      #
      # @param [File] video A File that contains a valid video format
      def upload_video video, name: nil
        @video = video
        @ticket = create_video
        start_upload
        video = change_name_and_get_video(name)
        return video
      end

      # Upload a video to the authenticated account
      #   The video is pulled automatically
      #
      # @param [String] name video name
      # @param [String] link a link to a video on the Internet that is accessible to Vimeo’s upload server
      def pull_upload name, link, options = {}
        body = {
          upload: { approach: 'pull', link: link},
          name: name.present? ? name : @video.original_filename
        }.merge!(options)

        post '/videos', body: body, code: 201
      end

      private

        def change_name_and_get_video name = nil
          video = VimeoMe2::Video.new(@token, @ticket['uri'])
          video.name = name || get_file_name
          video.update
        end

        def get_file_name
          return @video.path if @video.is_a? File
          return @video.original_filename
        end

        # 3.4 Update
        def create_video
          tus = {approach: 'tus', size: @video.size.to_s}
          body = {upload: tus}
          post '/videos', body: body, code: 200
        end

        # start the upload
        def start_upload
          headers = {'Content-Type' => 'application/offset+octet-stream'}
          headers['Tus-Resumable'] = '1.0.0'
          headers['Upload-Offset'] = '0'
          @video.rewind
          video_content = @video.read(@video.size).to_s
          begin
            body = video_content[headers['Upload-Offset'].to_i..-1]
            patch @ticket['upload']['upload_link'], body: body, headers: headers, code:204
            headers['Upload-Offset'] = @client.last_request.headers['upload-offset']
          end while upload_incomplete
        end

        def upload_incomplete
          @client.last_request.headers['upload-offset'].to_i != @video.size
        end
    end
  end
end
