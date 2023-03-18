Rails.application.routes.draw do
  resources :orders
  resources :line_items
  resources :carts
  resources :instruments
  devise_for :users,controllers:{
    registrations: 'registrations'
  }
  devise_scope :user do  
   get '/users/sign_out' => 'devise/sessions#destroy'     
end
  root 'instruments#index'
  delete 'instruments/:id'=>"instrument#destroy"
  # delete 'logout'  => 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
