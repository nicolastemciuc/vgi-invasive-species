Rails.application.routes.draw do
  devise_for :users

  root to: "home#index"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :admin do
    resources :users, except: [ :create ]
  end

  resources :species, only: [ :index ]
end
