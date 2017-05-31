module VimeoMe2
  module UserMethods
    module Album

      # Get a list of albums for the current user.
      def get_album_list
        @client.check_authorization
        @client.make_http_request('get', request_uri("/albums") )
      end

      # Get one album by it's ID
      # @param [String] album_id The Id of the album.
      def get_album album_id
        @client.check_authorization
        @client.make_http_request('get', request_uri("/albums/#{album_id}") )
      end

      # Create a new album
      # @param [String] name The name of the album.
      # @param [String] description The description of the album.
      def create_album(name, description)
        @client.check_authorization('create')
        @client.body['name'] = name
        @client.body['description'] = description
        @client.make_http_request('post', request_uri("/albums") )
      end

      # Edit an album
      # @param [String] name The name of the album.
      # @param [String] description The description of the album.
      def edit_album(album_id, name=nil, description=nil)
        @client.check_authorization('edit')
        @client.body['name'] = name if name
        @client.body['description'] = description if description
        @client.make_http_request('patch', request_uri("/albums/#{album_id}") )
      end

      # Delete one album by it's ID
      # @param [String] album_id The Id of the album.
      def delete_album album_id
        @client.check_authorization('delete')
        @client.make_http_request('delete', request_uri("/albums/#{album_id}") )
      end

      # Get video's of album
      # @param [String] album_id The Id of the album.
      def get_album_videos album_id
        @client.check_authorization
        @client.make_http_request('get', request_uri("/albums/#{album_id}/videos") )
      end

      # Put multiple video's in an album
      # @param [String] album_id The Id of the album.
      # @param [String] videos String of video URIs seperated by comma
      # @param [Array] videos Array of video URIs
      def add_videos_to_album album_id, videos
        @client.check_authorization('edit')
        @client.body['videos'] = videos if videos.is_a? String
        @client.body['videos'] = videos.join(',') if videos.is_a? Array
        @client.make_http_request('put', request_uri("/albums/#{album_id}") )
      end

      # Add single video to an album
      # @param [String] album_id The Id of the album.
      # @param [String] video_id The Id of the video.
      def add_video_to_album album_id, video_id
        @client.check_authorization('edit')
        @client.make_http_request('put',request_uri("/albums/#{album_id}/videos/#{video_id}") )
      end

      # Check if video exists in an album
      # @param [String] album_id The Id of the album.
      # @param [String] video_id The Id of the video.
      def check_video_in_album album_id, video_id
        @client.check_authorization
        @client.make_http_request('get',request_uri("/albums/#{album_id}/videos/#{video_id}") )
      end

      # Remove video from an album
      # @param [String] album_id The Id of the album.
      # @param [String] video_id The Id of the video.
      def remove_video_from_album album_id, video_id
        @client.check_authorization('edit')
        @client.make_http_request('delete',request_uri("/albums/#{album_id}/videos/#{video_id}") )
      end
    end
  end
end
