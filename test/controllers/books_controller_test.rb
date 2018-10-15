require "test_helper"

describe BooksController do

  it "should get index" do
    # Act
    get books_path

    # Assert
    must_respond_with :success
  end

  describe "show" do

    it "should respond with success for showing an existing book" do
      # Arrange
      existing_book = books(:poodr)

      # Act
      get book_path(existing_book.id)

      # Assert
      must_respond_with :success
    end

    it "should respond with not found for showing a non-existing book" do
      # Arrange
      book = books(:poodr)
      id = book.id

      get book_path(id)
      must_respond_with :success


      book.destroy

      # Act
      get book_path(id)

      # Assert
      must_respond_with :missing
    end

  end

  describe "create" do
    it "can create a book with valid data" do
      # Arrange
      book_data = {
        book: {
          title: "new test book",
          author_id: Author.first.id
        }
      }

      # Assumptions
      test_book = Book.new(book_data[:book])
      test_book.must_be :valid?, "Book data was invalid. Please come fix this test"

      # Act
      expect {
        post books_path, params: book_data
      }.must_change('Book.count', +1)

      # Assert
      must_redirect_to book_path(Book.last)
    end
  end

  describe "destroy" do
    it "can destroy an existing book" do
      # Arrange
      book = books(:poodr)
      # before_book_count = Book.count

      # Act
      expect {
        delete book_path(book)
      }.must_change('Book.count', -1)

      # Assert
      must_respond_with :redirect
      must_redirect_to books_path

      # expect(Book.count).must_equal(
      #   before_book_count - 1,
      #   "book count did not decrease"
      # )
    end
  end



end
