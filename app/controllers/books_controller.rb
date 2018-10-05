class BooksController < ApplicationController
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
    @book = Book.find_by(id: params[:id])
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
      redirect_to books_path
    else
      render :new, status: :bad_request
    end
  end

  def edit
    @book = Book.find_by(id: params[:id])
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      redirect_to book_path(book.id)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    book = Book.find_by(id: params[:id])

    book.destroy
    redirect_to books_path
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
end
