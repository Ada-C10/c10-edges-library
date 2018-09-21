Rails.application.routes.draw do
  # Root route says what do I get for '/'
  root 'books#index'

  # Auto-generate all the RESTful routes
  resources :books

  # Non-RESTful routes are OK, so long as you have
  # non-RESTful work to do
  post '/books/:id/check_out', to: 'books#check_out', as: 'check_out_book'

  # the "as: 'books'" part is defining a NICKNAME for a path (in this case: '/books')

  # Therefore, I can refer to this path '/books' with the NICKNAME formed by the pattern: books_path (which is the nickname + _path)
  # get '/books', to: 'books#index', as: 'books'
  #
  # # The nickname of this path '/books/new' is: new_book_path
  # get '/books/new', to: 'books#new', as: 'new_book'
  # post '/books', to: 'books#create'
  #
  # # book_path
  # get '/books/:id', to: 'books#show', as: 'book'
  #
  # # edit_book_path
  # get '/books/:id/edit', to: 'books#edit', as: 'edit_book'
  # patch '/books/:id', to: 'books#update'
  #
  # delete '/books/:id', to: 'books#destroy'



  # Very possible:
  # patch '/user/:user_id/books/:id', to: 'books#mark_read', as: 'mark_read'

end
