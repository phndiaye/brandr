Rails.application.routes.draw do
  use_doorkeeper

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      match 'users/me' => 'users#me', via: :get
      resources :users
    end
  end
end
