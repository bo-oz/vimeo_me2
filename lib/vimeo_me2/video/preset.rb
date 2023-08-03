module VimeoMe2
  module VideoMethods
    module Preset

      def add_preset preset_id
        put("/presets/#{preset_id}", code: 204)
      end

    end
  end
end
