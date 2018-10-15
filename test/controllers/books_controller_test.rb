require "test_helper"

describe BooksController do
  describe "index" do
    it "should get index" do
      # Act
      get books_path

      # Assert
      must_respond_with :success
    end
  end

  describe "new" do
    it "can get the new page" do
      get new_book_path

      must_respond_with :success
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

    it "does not creat a new book w/ invalid data" do
      # Arrange
      book_data = {
        book: {
          title: Book.first.title,
          author_id: Author.first.id
        }
      }

      # Assumptions
      Book.new(book_data[:book]).wont_be :valid?, "Book data wasn't invalid. Please come fix this test"

      # Act
      expect {
        post books_path, params: book_data
      }.wont_change('Book.count')

      # Assert
      must_respond_with :bad_request
    end
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

  describe "edit" do
    it "responds with success for an existing book" do
      get edit_book_path(Book.first)
      must_respond_with :success
    end

    it "responds with not_found for a book that D.N.E." do
      b = Book.first.destroy
      get edit_book_path(b)
      must_respond_with :not_found
    end
  end

  describe "update" do
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
