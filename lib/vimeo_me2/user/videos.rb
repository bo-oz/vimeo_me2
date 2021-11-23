module VimeoMe2
  module UserMethods
    module Videos

      # Get a list of albums for the current user.
      # @param [Object] Arguments passed to http_request (optional keys include: headers, query)
      def get_video_list(**args)
        get("/videos", **args)
      end

      # Get one album by it's ID
      # @param [String] album_id The Id of the album.
      def get_video(video_id)
        get("/videos/#{video_id}")
      end

    end
  end
end
