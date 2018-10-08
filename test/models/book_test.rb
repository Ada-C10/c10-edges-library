require "test_helper"

describe Book do
  # Books must have a method that is part of the relationship to author and returns the expected thing from that method
  # it has a .author method, it returns a specific Author


  describe 'validations' do

    # For every model, have one test that says everything is good! and valid! sometimes!
    # Make a new book with a valid title (present and unique)
    # calling .valid? on it will be true

    it 'is valid when title is present and unique and author is present' do
      # Arrange
      author = Author.new(name: 'test author')
      book = Book.new(title: 'test book', author: author)

      # Act
      is_valid = book.valid?

      # Assert
      expect( is_valid ).must_equal true
    end

  end

  # A book that doesn't have a title is not valid
  # A book with a title of nil value or not provided will...
  # when calling .valid? will return false

  # A book that has a not-unique title is not valid
  # There is an instance of Book (first book)
  # There is an instance of Book (second book), both have same titles
  # Calling .valid? on second book will return false






  # Book must be of type Book
  # a new book instance if of type Book
end
