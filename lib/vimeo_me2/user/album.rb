module VimeoMe2
  module UserMethods
    module Album

      # Get a list of albums for the current user.
      def get_album_list
        get("/albums")
      end

      # Get one album by it's ID
      # @param [String] album_id The Id of the album.
      def get_album album_id
        get("/albums/#{album_id}")
      end

      # Create a new album
      # @param [String] name The name of the album.
      # @param [String] description The description of the album.
      def create_album(name, description=nil)
        body = {}
        body['name'] = name
        body['description'] = description
        post("/albums", body: body, code: 201 )
      end

      # Edit an album
      # @param [String] name The name of the album.
      # @param [String] description The description of the album.
      def edit_album(album_id, name=nil, description=nil)
        body = {}
        body['name'] = name if name
        body['description'] = description if description
        patch("/albums/#{album_id}", body: body)
      end

      # Delete one album by it's ID
      # @param [String] album_id The Id of the album.
      def delete_album album_id
        delete("/albums/#{album_id}", code: 204)
      end

      # Get video's of album
      # @param [String] album_id The Id of the album.
      def get_album_videos album_id
        get("/albums/#{album_id}/videos")
      end

      # Put multiple video's in an album
      # @param [String] album_id The Id of the album.
      # @param [String] videos String of video URIs seperated by comma
      # @param [Array] videos Array of video URIs
      def add_videos_to_album album_id, videos
        body = {}
        body['videos'] = videos if videos.is_a? String
        body['videos'] = videos.join(',') if videos.is_a? Array
        put("/albums/#{album_id}/videos", body:body, code: 201)
      end

      # Add single video to an album
      # @param [String] album_id The Id of the album.
      # @param [String] video_id The Id of the video.
      def add_video_to_album album_id, video_id
        put("/albums/#{album_id}/videos/#{video_id}", code: 204)
      end

      # Check if video exists in an album
      # @param [String] album_id The Id of the album.
      # @param [String] video_id The Id of the video.
      def check_video_in_album album_id, video_id
        get("/albums/#{album_id}/videos/#{video_id}", code:204)
        return true
      rescue VimeoMe2::RequestFailed
        return false
      end

      # Remove video from an album
      # @param [String] album_id The Id of the album.
      # @param [String] video_id The Id of the video.
      def remove_video_from_album album_id, video_id
        delete("/albums/#{album_id}/videos/#{video_id}", code: 204)
      end
    end
  end
end
