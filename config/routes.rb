Rails.application.routes.draw do
  devise_for :customers
  resources :customers
  resources :cars
  resources :reservations
  root 'customers#home'
  get '/cars', to: 'cars#index'
  get '/home', to: 'customers#home'
  get '/reservations/new', to: 'reservations#new'
  get '/checkout/:id' => 'reservations#checkout', :as =>  'checkout'
  get '/return_car/:id' => 'reservations#return_car', :as =>  'return_car'

  #root 'customers#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
