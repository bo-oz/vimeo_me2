module VimeoMe2
  module UserMethods
    module Videos

      # Get all videos
      def view_all_videos(**args)
        get("/videos", args)
      end

    end
  end
end
