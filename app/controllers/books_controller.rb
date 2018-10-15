class BooksController < ApplicationController

  before_action :find_book, only: [:show, :edit, :update, :destroy]

  def index
    if params[:author_id]
      author = Author.find_by(id: params[:author_id])
      # How do we handle if the author is not found?
      #  If the author is not found, we would have a conditional to check
      # that the author was found.
      # Redirect to a 404 page
      # Redirect to another existing page (the home page?) (new author form?)
      # Show an error message saying that the author was not found
      @books = author.books
    else
      @books = Book.all
    end
  end

  def show
    if @book.nil?
      head :not_found
    end
  end

  def new
    if params[:author_id]
      author = Author.find_by(id: params[:author_id])
      @book = author.books.new
      # Same thing as above:
      # @book = Book.new(author: author)
    else
      @book = Book.new
    end
  end

  def create
    filtered_book_params = book_params()
    @book = Book.new(filtered_book_params)

    is_successful_save = @book.save

    if is_successful_save
      flash[:success] = "Successfully created new book with title \"#{@book.title}\""
      redirect_to book_path(@book)
    else
      flash.now[:error] = "Invalid book data"
      render :new, status: :bad_request
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      flash[:success] = "Successfully updated book \"#{@book.title}\""
      redirect_to book_path(@book.id)
    else
      flash.now[:error] = "Invalid book data"
      render(:edit, status: :bad_request)
    end
  end

  def destroy
    # if @book.author_id == session[:user_id]
      @book.destroy

      flash[:success] = "Successfully destroyed book \"#{@book.title}\""
      redirect_to books_path
      # head :no_content


    # else
    #   flash[:error] = "You must be logged in as a book's author in order to delete it!"
    #
    #   redirect_back(fallback_location: root_path)
    # end
  end

  private

  # Strong params: only let certain attributes
  # through
  def book_params
    return params.require(:book).permit(
      :title,
      :author_id,
      :description,
      :isbn,
      genre_ids: []
    )
  end

  def find_book
    @book = Book.find_by(id: params[:id])
  end
end
