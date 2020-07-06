Rails.application.routes.draw do
  devise_for :admin, only: %i[sessions]
  namespace :admin do
    root 'home#index'
    resources :teachers, only: %i[index new create edit update destroy] do
      member do
        get :login
      end
    end
  end

  devise_for :teacher, only: %i[sessions]
  namespace :teacher do
    root 'home#index'
    resource 'profile', only: %i[edit update]
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
  devise_for :user, only: %i[sessions]
  as :user do
    get '/user/sign_up', to: 'user/registrations#new', as: :new_user_registration
    post '/user', to: 'user/registrations#create', as: :user_registration
  end
  resources :lessons, only: :index
  resources :items, only: :index do
    resources :charges, only: :new
  end
  resources :lesson_reservations, only: %i[index create]

  namespace :webhook do
    resources :charges, only: :create do
      collection do
        get :success
        get :cancel
      end
    end
  end
end
