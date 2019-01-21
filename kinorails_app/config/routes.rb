Rails.application.routes.draw do
  resources :reserved_seats
  resources :favourite_movies
  resources :reservations
  resources :screenings
  resources :seats
  resources :movies
  devise_for :users
  resources :rooms

  resources :pages, :only => :show
  resources :favourite_movies do
    collection do
      put 'favourite'
    end
  end

  root to: redirect('/pages/home')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
