module VimeoMe2
  module UserMethods
    module Album

      # Get a list of albums for the current user.
      def get_album_list
        check_authorization
        make_http_request('get', request_uri("/albums") )
      end

      # Get one album by it's ID
      # @param [String] album_id The Id of the album.
      def get_album album_id
        check_authorization
        make_http_request('get', request_uri("/albums/#{album_id}") )
      end

      # Create a new album
      # @param [String] name The name of the album.
      # @param [String] description The description of the album.
      def create_album(name, description)
        check_authorization('create')
        @body['name'] = name
        @body['description'] = description
        make_http_request('post', request_uri("/albums") )
      end

      # Edit an album
      # @param [String] name The name of the album.
      # @param [String] description The description of the album.
      def edit_album(album_id, name=nil, description=nil)
        check_authorization('edit')
        @body['name'] = name if name
        @body['description'] = description if description
        make_http_request('patch', request_uri("/albums/#{album_id}") )
      end

      # Delete one album by it's ID
      # @param [String] album_id The Id of the album.
      def delete_album album_id
        check_authorization('delete')
        make_http_request('delete', request_uri("/albums/#{album_id}") )
      end

      # Get video's of album
      # @param [String] album_id The Id of the album.
      def get_album_videos album_id
        check_authorization
        make_http_request('get', request_uri("/albums/#{album_id}/videos") )
      end

      # Put multiple video's in an album
      # @param [String] album_id The Id of the album.
      # @param [String] videos String of video URIs seperated by comma
      # @param [Array] videos Array of video URIs
      def add_videos_to_album album_id, videos
        check_authorization('edit')
        @body['videos'] = videos if videos.is_a? String
        @body['videos'] = videos.join(',') if videos.is_a? Array
        make_http_request('put', request_uri("/albums/#{album_id}") )
      end

      # Add single video to an album
      # @param [String] album_id The Id of the album.
      # @param [String] video_id The Id of the video.
      def add_video_to_album album_id, video_id
        check_authorization('edit')
        make_http_request('put',request_uri("/albums/#{album_id}/videos/#{video_id}") )
      end

      # Check if video exists in an album
      # @param [String] album_id The Id of the album.
      # @param [String] video_id The Id of the video.
      def check_video_in_album album_id, video_id
        check_authorization!
        make_http_request('get',request_uri("/albums/#{album_id}/videos/#{video_id}") )
      end

      # Remove video from an album
      # @param [String] album_id The Id of the album.
      # @param [String] video_id The Id of the video.
      def remove_video_from_album album_id, video_id
        check_authorization('edit')
        make_http_request('delete',request_uri("/albums/#{album_id}/videos/#{video_id}") )
      end
    end
  end
end
