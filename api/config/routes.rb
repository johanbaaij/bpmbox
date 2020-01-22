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

    get 'collections/new/:username', controller: 'collections', action: 'new'
    get 'collections/import/:username', controller: 'collections', action: 'import'

    namespace :discogs do
      get 'authorize', controller: 'authorizer', action: 'authorize'
      get 'callback', controller: 'authorizer', action: 'callback'
    end
  end
end
