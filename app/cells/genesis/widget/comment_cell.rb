# frozen_string_literal: true

# frozen_string_literal: true

module Widget
  class CommentCell < BaseCell
    def current_user
      options[:user]
    end

    def support_email
      options[:support_email]
    end
  end
end
