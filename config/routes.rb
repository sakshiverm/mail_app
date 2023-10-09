Rails.application.routes.draw do
  root "products#index"
  resources :products
  resources :users
  post '/authentications/login', to: 'authentications#login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
