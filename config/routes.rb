# frozen_string_literal: true

Rails.application.routes.draw do
  get "diagnostics/index"
  root to: "diagnostics#index"
end
