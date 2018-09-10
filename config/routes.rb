Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :markers
      resources :users, only: [:create, :read, :update]
      post "/login", to: 'users#login'
      get "/current_user", to: 'users#get_current_user'
      get "/users/:id/markers", to: 'markers#get_markers'
      post "/users/:id/markers", to: 'markers#add_marker'
      patch "users/:id/markers/:marker_id", to: 'markers#update_marker'
      get "users/:id/markers/:marker_id/comment", to: 'markers#get_comment'
      get "users/:id/markers/:marker_id/photo", to: 'markers#get_photo'
      delete "/users/:id/markers/:marker_id", to: 'markers#delete_marker'
    end
  end
end
