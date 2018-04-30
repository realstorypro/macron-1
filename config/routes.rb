# frozen_string_literal: true

Rails.application.routes.draw do
  get 'diagnostics/index'
  root to: 'diagnostics#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
