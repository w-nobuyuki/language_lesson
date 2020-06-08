Rails.application.routes.draw do
  devise_for :admins
  namespace :admin do
    root 'home#index'
    resources :teachers
  end

  devise_for :teachers
  namespace :teacher do
    root 'home#index'
    get 'edit', to: 'home#edit'
    patch 'update', to: 'home#update'
    resources :lessons, except: %i[show]
  end

  root 'home#index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
