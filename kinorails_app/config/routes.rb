Rails.application.routes.draw do
  resources :rooms

  resources :pages, :only => :show

  root to: redirect('/pages/home')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
