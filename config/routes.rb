Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'posts#index'

  resources :posts do
  

    resource :like, only: [:create, :destroy]
  end

  resource :timeline, only: [:show]

  resource :profile, only: [:show, :edit, :update]
end
