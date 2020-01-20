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
    get 'release/:discogs_id', controller: 'releases', action: 'show'
    namespace :discogs do
      get 'url/redirect', controller: 'url', action: 'redirect'
      get 'authorize', controller: 'authorizer', action: 'authorize'
      get 'callback', controller: 'authorizer', action: 'callback'
      get 'import_releases', controller: 'importer', action: 'import_releases'
    end
  end
end
