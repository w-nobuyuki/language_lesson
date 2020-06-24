Rails.application.routes.draw do
  devise_for :admins, only: %i[sessions]
  namespace :admin do
    root 'home#index'
    resources :teachers, only: %i[index new create edit update destroy] do
      member do
        get :login
      end
    end
  end

  devise_for :teachers, only: %i[sessions]
  namespace :teacher do
    root 'home#index'
    get 'edit', to: 'home#edit'
    patch 'update', to: 'home#update'
    resources :lessons, only: %i[index new create edit update destroy]
    resources :lesson_reservations, only: %i[index] do
      resources :feedbacks, only: %i[index new create edit update destroy]
      resources :notifications, only: %i[index new create edit update destroy]
    end
    resources :users, only: :show
  end

  root 'home#index'
  devise_for :users, only: %i[sessions]
  as :user do
    get '/users/sign_up', to: 'users/registrations#new', as: :new_user_registration
    post '/users', to: 'users/registrations#create', as: :user_registration
  end
  resources :lessons, only: :index
  resources :items, only: :index do
    resources :charges, only: :new
  end
  resources :lesson_reservations, only: %i[index create]

  namespace :webhook do
    resources :charges, only: :create
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
