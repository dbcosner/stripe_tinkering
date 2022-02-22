Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#subscription"

  get 'success', to: 'pages#success', as: 'success'
  get 'cancel', to: 'pages#cancel', as: 'cancel'

  resources :checkout_sessions, only: %w[create destroy]
  resources :portal_sessions, only: %w[create destroy]
end
