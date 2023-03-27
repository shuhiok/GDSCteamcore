Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :posts do
    collection do
      get 'kanryo', to: 'posts#kanryo'
    end
  end
  
  resources :events do
      resources :likes, only: [:create, :destroy]
      resources :comments, only: [:create]
  end
  
  resources :tags do
    get 'posts', to: 'posts#search'
  end
  
  root 'posts#index' 
  
end
