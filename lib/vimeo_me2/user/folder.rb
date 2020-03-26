module VimeoMe2
  module UserMethods
    module Folder

      # Get a list of folders for the current user (up 100 folders).
      def get_folder_list
        get("/projects")
      end

      # Get one folder by it's ID
      # @param [String] folder_id The Id of the folder.
      def get_folder folder_id
        get("/projects/#{folder_id}")
      end

      # Create a new folder
      # @param [String] name The name of the folder.
      # @param [String] description The description of the folder.
      def create_folder(name, description=nil)
        body = {}
        body['name'] = name
        post("/projects", body: body, code: 201 )
      end

      
      # Delete one folder by it's ID
      # @param [String] folder_id The Id of the folder.
      def delete_folder folder_id
        delete("/projects/#{folder_id}", code: 204)
      end

      # Get video's of folder
      # @param [String] folder_id The Id of the folder.
      def get_folder_videos folder_id
        get("/projects/#{folder_id}/videos")
      end      

      # Add single video to an folder
      # @param [String] folder_id The Id of the folder.
      # @param [String] video_id The Id of the video.
      def add_video_to_folder folder_id, video_id
        put("/projects/#{folder_id}/videos/#{video_id}", code: 204)
      end

      # Remove video from an folder
      # @param [String] folder_id The Id of the folder.
      # @param [String] video_id The Id of the video.
      def remove_video_from_folder folder_id, video_id
        delete("/projects/#{folder_id}/videos/#{video_id}", code: 204)
      end
    end
  end
end
