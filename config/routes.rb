Rails.application.routes.draw do
  use_doorkeeper

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users
        match 'users/me' => 'users#me', via: :get
      resources :hunts
    end
  end
end
