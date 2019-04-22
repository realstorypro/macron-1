# frozen_string_literal: true

module Game
  class World
    def initialize

    end

    # @return [Object] all available paths
    def all_paths
      options_to_object('paths')
    end

    def all_spells
      options_to_object('spells')
    end

    private

    def options_to_object(options_path)
      path_obj = {}
      s(options_path).each do |path|
        path_obj[path[0]] = {}

        path[1].keys.each do |key|
          path_obj[path[0]][key] = path[1][key]
        end
      end
      path_obj

    end

    # shortcut for settings
    def s(path)
      SettingProxy.instance.s(path)
    end

  end
end
