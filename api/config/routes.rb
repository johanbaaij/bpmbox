Rails.application.routes.draw do
  defaults format: :json do
    mount_devise_token_auth_for 'User', at: 'auth',
      controllers: {
        sessions: 'overrides/devise_token_auth/sessions',
        registrations: 'overrides/devise_token_auth/registrations',
      }
    get 'auth/user', controller: 'auth', action: 'user'
    get 'auth/refresh', controller: 'auth', action: 'refresh'
    resources :releases
    resources :artists
    resources :songs

    resources :discogs do
      collection do
        get :authenticate
        get :callback
        get :whoami
        get :add_want
        get :edit_want
        get :remove_want
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
