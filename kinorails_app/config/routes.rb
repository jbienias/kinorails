Rails.application.routes.draw do
  devise_for :users
  resources :rooms

  resources :pages, :only => :show

  root to: redirect('/pages/home')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
