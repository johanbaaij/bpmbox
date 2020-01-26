# frozen_string_literal: true
require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable'

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

    resources :collections, param: :username, only: [:show] do
      member do
        post :import
      end
      resources :tracks, only: [:index]
      resources :releases, only: [:index, :show]
    end

    namespace :discogs do
      get 'authorize', controller: 'authorizer', action: 'authorize'
      get 'callback', controller: 'authorizer', action: 'callback'
    end
  end
end
