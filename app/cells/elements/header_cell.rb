# frozen_string_literal: true

module Elements
  class HeaderCell < BaseElementCell
    def show
      render "shared"
    end

    def header_size
      "fullscreen"
    end

    def overlay_background
      if model.respond_to?(:overlay_background) && !model.overlay_background.blank?
        return model.overlay_background
      end
      ss("theme.global.overlay_background")
    end

    # ##############
    # title portion
    # ##############

    def has_title
      return true if model.respond_to?(:title) && !model.title.blank?
      false
    end

    def title
      model.title
    end

    def title_extra_classes
      ""
    end

    def title_alignment
      model.title_alignment
    end

    # ##############
    # summary portion
    # ##############
    def has_summary
      return true if model.respond_to?(:summary) && !model.summary.blank?
      false
    end

    def summary_alignment
      return model.summary_alignment if model.respond_to?(:summary_alignment)
      "left"
    end

    def summary_extra_classes
      ""
    end

    # ##############
    # credit portion
    # ##############
    def has_credit
      return true if model.respond_to?(:credit) && !model.credit.blank?
      false
    end


    # ##############
    # embed portion
    # ##############
    def has_embed
      return true if model.respond_to?(:url)
      false
    end


    # ##############
    # video portion
    # ##############
    def has_video
      return true if model.respond_to?(:video) && !model.video.blank?
      false
    end

    def video
      model.video
    end

    def video_cover
      return model.video_cover if model.respond_to?(:video_cover)
      ""
    end

    # ##############
    # amped portion
    # ##############
    def amped
      return true if options[:amped]
      false
    end
  end
end
