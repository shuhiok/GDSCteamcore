Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:show]
  resources :posts
  root 'posts#index' 
  
  resources :tags do
    get 'posts', to: 'posts#search'
  end
end
