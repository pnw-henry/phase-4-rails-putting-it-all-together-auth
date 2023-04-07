Rails.application.routes.draw do
  resources :recipes, only: [:index, :create]

  post "/signup", to: "users#create"

  post "/login", to: "sessions#create"
  
  get "/me", to: "users#show"

  delete "/logout", to: "sessions#destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
