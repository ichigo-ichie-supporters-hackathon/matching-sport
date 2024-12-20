Rails.application.routes.draw do
  namespace :user do
    resources :event
  end
  get 'home/index'
  get 'subgenre', to: 'subgenre#index'

  devise_for :users , controllers: {
  registrations: 'user/registrations',
  sessions: 'user/sessions'
}
  root "home#index"  
end
