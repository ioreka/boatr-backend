Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :pins
      resources :users, only: [:create]
      post "/login", to: 'users#login'
      get "/current_user", to: 'users#get_current_user'
      get "/users/:id/markers", to: 'users#get_markers'
      post "/users/:id/markers", to: 'users#set_markers'
      delete "/users/:id/markers", to: 'users#delete_marker'
    end
  end
end
