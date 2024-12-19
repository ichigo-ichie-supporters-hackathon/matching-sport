Rails.application.routes.draw do
  namespace :users do
    resources :event
  end
  get 'home/index'
  devise_for :users 
  root "home#index"  
end
