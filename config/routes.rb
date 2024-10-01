require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'posts#index'

  resources :posts do
    resources :comments, only: [:index, :new, :create]

    resource :like, only: [:show, :create, :destroy]
  end

  resources :accounts, only: [:show] do
    resources :follows, only: [:show, :create]
    resources :unfollows, only: [:create]

    member do
      get :followings
      get :followers
    end
  end

  resource :timeline, only: [:show]

  resource :profile, only: [:show, :edit, :update]
end

