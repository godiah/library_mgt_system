# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "main#index"

  # GET /home
  get "home", to: "home#index"

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  delete "logout", to: "sessions#destroy"
end
