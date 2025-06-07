Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  resources :items, only: %i[ index ]
  resources :orders, except: %i[ destroy ]
  root "welcome#show"

  namespace :kitchen do
    resources :orders, only: %i[ index ]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
