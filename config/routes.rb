Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/", to: "welcome#index"
  get "/stores", to: "stores#index"
  get "/stores/new", to: "stores#new"
  post "/stores", to: "stores#create"
  get "/stores/:store_id", to: "stores#show"
  patch "/stores/:store_id", to: "stores#update"
  get "/stores/:store_id/edit", to: "stores#edit"
  get "/stores/:location_id/vehicles", to: "stores#show_vehicles"
  get "/stores/:location_id/vehicles/new", to: "stores#edit_vehicle"
  post "/stores/:location_id/vehicles", to: "stores#add_vehicle"
  get "/stores/new", to: "stores#new"
  get "/vehicles", to: "vehicles#index"
  get "/vehicles/:vehicle_id", to: "vehicles#show"
  get "/vehicles/:vehicle_id/edit", to: "vehicles#edit"
  patch "/vehicles/:vehicle_id", to: "vehicles#update"
end
