Rails.application.routes.draw do
  devise_for :admins
  namespace :admin do
    root 'home#index'
    resources :teachers
  end
  root 'home#index'
  devise_for :teachers
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
