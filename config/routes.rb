Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/", to: "welcome#index"
  get "/stores", to: "stores#index"
  get "/stores/new", to: "stores#new"
  post "/stores/new", to: "stores#create"
  get "/stores/:store_id", to: "stores#show"
  get "/stores/:location_id/vehicles", to: "stores#show_vehicles"
  get "/stores/new", to: "stores#new"
  get "/vehicles", to: "vehicles#index"
  get "/vehicles/:vehicle_id", to: "vehicles#show"
end
