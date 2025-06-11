Rails.application.routes.draw do
  resources :joints
  mount ActionCable.server => "/cable"

  root "joints#new"

  resources :joints, key: :joint_id, only: %i[ new create show ] do
    resources :orders, except: %i[ edit update destroy ]

    namespace :kitchen do
      resources :orders, only: %i[ index ] do
        collection do
          delete :destroy_all
        end
      end
    end

    get :kitchen, controller: "kitchen/orders", action: :index
  end

  get "up" => "rails/health#show", as: :rails_health_check
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
