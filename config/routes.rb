Rails.application.routes.draw do
  resources :chat_rooms, only: [ :index, :new, :create, :show ] do
    resources :messages, only: [ :create ]
    member do
      post :join
      delete :leave
    end
  end
  devise_for :users
  post "/add_user_name" => "users#add_name", as: :add_user_name
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
end
