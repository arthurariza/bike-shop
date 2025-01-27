Rails.application.routes.draw do
  namespace :v1 do
    namespace :admin do
      resources :categories do
        resources :products
        resources :customizations
      end

      resources :customizations, only: [] do
        resources :customization_items
      end

      resources :prohibited_combinations, only: [ :index, :show, :create, :destroy ]
      resources :customization_item_stocks, only: [ :update ]
    end

    resources :products, only: [ :index, :show ]
    resource :cart, only: [ :show, :create ] do
      resources :cart_items, only: [ :create ]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
