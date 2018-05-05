# frozen_string_literal: true

module AdminAccess
  extend ActiveSupport::Concern

  included do
    before_action :authorize_admin
  end

    private

      def authorize_admin
        redirect_to "/403" unless Pundit.policy(current_user, :headless).index?(:admin)
      end
end
