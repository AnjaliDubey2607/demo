Rails.application.routes.draw do
 

  devise_for :users, controllers: {
     omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root "home#index"
  get "autherised", to: "home#autherised"

  namespace :admin do
    get "dashboards/user_list",to: "dashboards#user_list"
    get "dashboards/product_list",to: "dashboards#product_list"
    get "dashboards/order_list",to: "dashboards#order_list"
  end 
  
  resources :categories

  namespace :supplier do
    resources :products
  end

  namespace :customer do
    get "dashboards/product_list/:id", to: "dashboards#product_list", as: "product_list"
    get "dashboards/cart_details", to: "dashboards#cart_details", as: "cart_details"
    get "dashboards/add_cart/:id", to: "dashboards#add_cart", as: "add_cart"
    get "dashboards/order_list", to: "dashboards#order_list", as: "order_list"
    get "dashboards/add_order/:id", to: "dashboards#add_order", as: "add_order"
    get "dashboards/payment_type/:id", to: "dashboards#payment_type", as: "payment_type"
    get "dashboards/remove_cartproduct/:id", to: "dashboards#remove_cartproduct", as: "remove_cartproduct"
    resources :dashboards, only: [:index, :show, :destroy]
  end
  resources :charges

  match '*path', :to => 'home#page_not_found', :via => [:get, :post]

end