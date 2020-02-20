Rails.application.routes.draw do
  get 'email/index'
  get 'restaurant/index'

  resources :users
  resources :restaurants  


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'landing#index'
  
end
