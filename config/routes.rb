Rails.application.routes.draw do
  get 'home/index'
  devise_for :users , controllers: {
  registrations: 'user/registrations',
  sessions: 'user/sessions'
}
  root "home#index"  
end
