Rails.application.routes.draw do



  
  namespace :api do
    namespace :v1 do
       resources  :orders
   
       resources  :carts do
          post '/insert'=>'carts#insert', on: :collection
          post '/add_quantity'=>'carts#add_quantity',on: :collection
          post '/remove_quantity'=>'carts#remove_quantity',on: :collection
           post '/remove_item'=>'carts#remove_item',on: :collection

        end
       resources  :instruments
       resources  :ordered_items
       resources  :payments
      

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
  resources :orders 
    resources :payments
  
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
