Rails.application.routes.draw do
  devise_for :admins, only: %i[sessions]
  namespace :admin do
    root 'home#index'
    resources :teachers
  end

  devise_for :teachers, only: %i[sessions]
  namespace :teacher do
    root 'home#index'
    get 'edit', to: 'home#edit'
    patch 'update', to: 'home#update'
    resources :lessons, only: %i[index new create edit update destroy]
    resources :reserved_lessons, only: %i[index]
  end

  root 'home#index'
  devise_for :users
  resources :charges
  resources :lessons, only: :index
  resources :lesson_reservations
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
