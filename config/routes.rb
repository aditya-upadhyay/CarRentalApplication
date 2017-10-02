Rails.application.routes.draw do
  devise_for :customers

  resources :customers
  resources :cars
  resources :reservations
  root 'customers#home'
  get '/cars', to: 'cars#index'
  get '/home', to: 'customers#home'
  get '/reservation_new/:id', to: 'reservations#new', :as => 'reservation_new'
  get '/checkout/:id' => 'reservations#checkout', :as =>  'checkout'
  get '/return_car/:id' => 'reservations#return_car', :as =>  'return_car'
  get '/cars/[:id]', to: 'cars#show'

  #root 'customers#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
