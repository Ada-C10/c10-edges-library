class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    book_id = params[:id].to_i
    @book = Book.find_by(id: book_id)
    if @book.nil?
      head :not_found
    end
  end
end
