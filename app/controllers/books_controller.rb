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

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(
      author: params[:book][:author],
      title: params[:book][:title]
    )

    is_successful_save = @book.save

    if is_successful_save
      redirect_to books_path
    else
      render :new
    end
  end
end
