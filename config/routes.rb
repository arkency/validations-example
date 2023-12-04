Rails.application.routes.draw do
  mount RailsEventStore::Browser => '/res' if Rails.env.development?

  get "up" => "rails/health#show", as: :rails_health_check

  resources :signups, only: [:new, :create]

  root "signups#new"
end
