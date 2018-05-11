# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@idealogic.io'
  layout "mailer"
end
