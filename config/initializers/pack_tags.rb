# frozen_string_literal: true

module Webpacker
  module Helper
    def stylesheet_pack_url(name)
      source_from_pack(name, type: :stylesheet)
    end

    def javascript_pack_url(name)
      source_from_pack(name, type: :javascript)
    end

    private

      def source_from_pack(name, type:)
        return Webpacker.instance.manifest.lookup!("#{name}.css") if type == :stylesheet
        return Webpacker.instance.manifest.lookup!("#{name}.js") if type == :javascript
      end
  end
end
