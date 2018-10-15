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
      book = books(:poodr)
      id = book.id

      get book_path(id)
      must_respond_with :success


      book.destroy

      get book_path(id)

      must_respond_with :missing
    end

  end



end
