Rails.application.routes.draw do
  devise_for :users

  root to: "sightings#index"
  resources :sightings, only: [ :index, :show, :new ]

  resource :point_sightings, only: [ :create, :edit, :update ]

  resource :path_sightings, only: :create

  resource :zone_sightings, only: :create

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :admin do
    resources :users, except: [ :create ]
  end

  resources :species, only: [ :index, :new, :create, :edit, :update, :destroy ]
end
