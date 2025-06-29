Rails.application.routes.draw do
  devise_for :users

  root to: "sightings#index"
  resources :sightings, only: [ :index, :show ]

  resource :point_sightings, only: [ :new, :create, :edit, :update ]

  resource :path_sightings, only: [ :new, :create ]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :admin do
    resources :users, except: [ :create ]
  end

  resources :species, only: [ :index, :new, :create, :edit, :update, :destroy ]
end
