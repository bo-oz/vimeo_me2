module VimeoMe2
  module UserMethods
    module Videos

      # Get a list of albums for the current user.
      def get_video_list
        get("/videos")
      end

      # Get one album by it's ID
      # @param [String] album_id The Id of the album.
      def get_video video_id
        get("/videos/#{video_id}")
      end

    end
  end
end
