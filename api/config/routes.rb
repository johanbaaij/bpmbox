# frozen_string_literal: true
require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  defaults format: :json do
    mount_devise_token_auth_for(
      'User',
      at: 'auth',
      controllers: {
        sessions: 'overrides/devise_token_auth/sessions',
        registrations: 'overrides/devise_token_auth/registrations'
      }
    )
    get 'auth/user', controller: 'auth', action: 'user'
    get 'auth/refresh', controller: 'auth', action: 'refresh'

    get 'collections/:username/discogs_lookup', controller: 'collections', action: 'discogs_lookup'
    post 'collections/:username/import', controller: 'collections', action: 'import'
    get 'collections/:username/tracks', controller: 'tracks', action: 'index'

    namespace :discogs do
      get 'authorize', controller: 'authorizer', action: 'authorize'
      get 'callback', controller: 'authorizer', action: 'callback'
    end
  end
end
