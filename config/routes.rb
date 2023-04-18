Rails.application.routes.draw do



  
  namespace :api do
    namespace :v1 do
       resources  :orders, only:[:index, :show, :create, :update, :destroy]
       resources  :line_items, only:[:index, :show, :create, :update, :destroy]
       resources  :carts, only:[:index, :show, :create, :update, :destroy]
       resources  :instruments, only:[:index, :show, :create, :update, :destroy]
       resources  :ordered_items, only:[:index, :show, :create, :update, :destroy]
       resources  :payments, only:[:index, :show, :create, :update, :destroy]
       resources  :registrations, only:[:create]

       # scope  'cart/add/' do
       #    get "instruments/:id", to: ""
       # end
    end
  end
  
   use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :customers
  resources :sellers
  resources :ordered_items
  resources :wishlist do
    post '/insert' =>'wishlist#insert', on: :collection
  end
  resources :orders do
    resources :payments
  end
  resources :line_items do
    get :add_quantity, on: :member
    get :remove_quantity, on: :member
  end
  resources :carts
  resources :instruments
  get 'search',to:"instruments#search"
  #get 'addquantity',to:"line_items#add_quantity"
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
