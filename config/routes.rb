Rails.application.routes.draw do
  # Root route says what do I get for '/'
  root 'books#index'

  # Auto-generate all the RESTful routes
  resources :books

  # Non-RESTful routes are OK, so long as you have
  # non-RESTful work to do
  post '/books/:id/check_out', to: 'books#check_out', as: 'check_out_book'

  resources :authors, except: [:destroy] do
    resources :books, only: [:index, :new]
  end

  resources :sessions, only: [:new, :create]
  post '/sessions/logout', to: 'sessions#logout', as: 'logout'

end
