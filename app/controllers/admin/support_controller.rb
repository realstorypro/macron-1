# frozen_string_literal: true

require_dependency "application_controller"

module Admin
  class SupportController < ApplicationController
    include AdminAccess
    semantic_breadcrumb "Support", :admin_support_index_path
    layout "layouts/admin"
  end
end
