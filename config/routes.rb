Rails.application.routes.draw do
  use_doorkeeper

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      match 'users/me' => 'users#me', via: :get
      resources :users
      resources :hunts
    end
  end

  get 'healthcheck', to: 'health_check#index'

  unless Rails.env.development?
    match '*path', to: 'home#index', via: [:get]
  end

  root to: 'home#index'
end
