Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/", to: "welcome#index"
  get "/stores", to: "stores#index"
  get "/stores/:store_id", to: "stores#show"
  get "/vehicles", to: "vehicles#index"
end
