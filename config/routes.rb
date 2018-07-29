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
      controllers: {
          sessions: "users/sessions",
          registrations: "users/registrations",
          passwords: "users/passwords"
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

  resources :podcasts, component: "podcasts", only: %i[index]
  get "podcasts/:category", to: "podcasts#index", as: "podcast_category", component: "podcasts"
  get "podcasts/:category/:id", to: "podcasts#show", as: "podcast_details", component: "podcasts"

  post "newsletter/subscribe/", to: "newsletter#subscribe"

  # Comments API
  resources :comments

  namespace :admin do
    root to: "dashboard#index"
    resources :dashboard, only: :index

    resources :users, component: "users" do
      get "ban", on: :member
      get "unban", on: :member
      get "enable_help", on: :member
      get "disable_help", on: :member
      get "enable_advanced", on: :member
      get "disable_advanced", on: :member
    end

    resources :articles, component: "articles"
    resources :discussions, component: "discussions"
    resources :videos, component: "videos"
    resources :podcasts, component: "podcasts"
    resources :advertisements, component: "advertisements"
    resources :tags, component: "tags"
    resources :categories, component: "categories"
    resources :support, component: "support", only: %i[index]

    scope :settings, module: "site_settings", component: "site_settings", as: "settings"  do
      root to: "settings#all"
      resource :general, controller: "general", component: "site_settings_general"
      resource :branding, controller: "branding", component: "site_settings_branding"
      resource :contact, controller: "contact", component: "site_settings_contact"
      resource :integration, controller: "integration", component: "site_settings_integration"

      scope :theme, controller: "theme", module: "theme", component: "site_settings_theme", as: "theme" do
        root to: "theme#all"
        resource :video, controller: "theme_video", component: "site_settings_theme_video"
        resource :article, controller: "theme_article", component: "site_settings_theme_article"
        resource :podcast, controller: "theme_podcast", component: "site_settings_theme_podcast"
        resource :footer, controller: "theme_footer", component: "site_settings_theme_footer"
        resource :header, controller: "theme_header", component: "site_settings_theme_header"
        resource :global, controller: "theme_global", component: "site_settings_theme_global"
        resource :general, controller: "theme_general", component: "site_settings_theme_general"
        resource :homepage, controller: "theme_homepage", component: "site_settings_theme_homepage"
        resource :discussion, controller: "theme_discussion", component: "site_settings_theme_discussion"
      end
    end
  end

  authenticate :user, ->(user) { user.can_manage?(:reports) } do
    mount Blazer::Engine, at: "admin/reports"
  end


  # Sidekiq
  require "sidekiq/web"

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    sidekiq_username = ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])
    sidekiq_password = ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"])

    passed_username = ::Digest::SHA256.hexdigest(username)
    passed_password = ::Digest::SHA256.hexdigest(password)

    ActiveSupport::SecurityUtils.secure_compare(passed_username, sidekiq_username) &
    ActiveSupport::SecurityUtils.secure_compare(passed_password, sidekiq_password)
  end if Rails.env.production?

  mount Sidekiq::Web => "/sidekiq"
end
