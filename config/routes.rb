Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :markers
      resources :users, only: [:create, :read, :update]
      post "/login", to: 'users#login'
      get "/current_user", to: 'users#get_current_user'
      get "/users/:id/markers", to: 'users#get_markers'
      post "/users/:id/markers", to: 'users#add_marker'
      patch "users/:id/markers/:marker_id", to: 'users#update_marker'
      delete "/users/:id/markers/:marker_id", to: 'users#delete_marker'
    end
  end
end
