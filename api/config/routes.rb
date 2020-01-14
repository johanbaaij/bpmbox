# frozen_string_literal: true

Rails.application.routes.draw do
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
    get 'discogs/authenticate', controller: 'discogs', action: 'authenticate'
    get 'discogs/callback', controller: 'discogs', action: 'callback'
    resources :releases
    resources :artists
    resources :songs
  end
end
