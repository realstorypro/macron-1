# frozen_string_literal: true

Rails.application.routes.draw do

  # Pulling in Root from Configuration
  root to: Settings.defaults.root_route.to_s

  # Exceptions
  get "403", to: "exceptions#forbidden"
  get "404", to: "exceptions#page_not_found"
  get "422", to: "exceptions#server_error"
  get "500", to: "exceptions#server_error"

  devise_for(
    :users,
      class_name: "User",
      module: :users,
      controllers: {
          sessions: "genesis/users/sessions",
          registrations: "genesis/users/registrations",
          passwords: "genesis/users/passwords"
      }
  )

  devise_scope :user do
    get "/sign_in" => "users/sessions#new"
    get "/sign_up" => "users/registrations#new"
  end

  # After Signup Wizard
  resources :after_signup

  # Loading Pages
  Settings.pages.each do |page|
    get page[0], to: "page##{page[0]}"
  end

  # Sitemap
  get "sitemap", to: "page#sitemap"

  resources :members, component: "members", only: %i[index show]
  resource  :profile, controller: "profile", component: "profile", only: %i[show edit update]

  resources :articles, component: "articles", only: %i[index]
  get "articles/:category", to: "articles#index", as: "article_category", component: "articles"
  get "articles/:category/:id", to: "articles#show", as: "article_details", component: "articles"

  resources :discussions, component: "discussions", only: %i[index]
  get "discussions/:category", to: "discussions#index", as: "discussion_category", component: "discussions"
  get "discussions/:category/:id", to: "discussions#show", as: "discussion_details", component: "discussions"

  resources :videos, component: "videos", only: %i[index]
  get "videos/:category", to: "videos#index", as: "video_category", component: "videos"
  get "videos/:category/:id", to: "videos#show", as: "video_details", component: "videos"

  post "newsletter/subscribe/", to: "newsletter#subscribe"

  # Comments API
  resources :comments

  namespace :admin do
    root to: "dashboard#index"
    resources :dashboard, only: :index
    resources :users, component: "users" do
      get "ban", on: :member
      get "unban", on: :member
    end
    resources :articles, component: "articles"
    resources :discussions, component: "discussions"
    resources :videos, component: "videos"
    resources :advertisements, component: "advertisements"
    resources :tags, component: "tags"
    resources :categories, component: "categories"
    resources :settings, component: "site_settings", only: %i[index edit update]
    resources :support, component: "support", only: %i[index]
  end
end
