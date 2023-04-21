Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :teas, only: [:create]
      resources :subscriptions, only: [:create, :update]
      resources :customers, only: [:create] do
        scope module: :customers do
          resources :subscriptions, only: [:index]
        end
      end
    end
  end
end
