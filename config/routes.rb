Rails.application.routes.draw do
  namespace :user do
    resources :event
  end
  get 'home/index'
  devise_for :users
  root "home#index"
end
