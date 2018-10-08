require "test_helper"

describe Book do
  # Books must have a method that is part of the relationship to author and returns the expected thing from that method
  # it has a .author method, it returns a specific Author


  describe 'validations' do

    before do
      author = Author.new(name: 'test author')
      @book = Book.new(title: 'test book', author: author)
    end

    it 'is valid when title is present and unique and author is present' do

      is_valid = @book.valid?
      expect( is_valid ).must_equal true

    end

    it 'is invalid without a title' do
      @book.title = nil

      is_valid = @book.valid?

      expect( is_valid ).must_equal false
      expect( @book.errors.messages ).must_include :title
    end

    # A book that has a not-unique title is not valid
    # There is an instance of Book (first book)
    # There is an instance of Book (second book), both have same titles
    # Calling .valid? on second book will return false
    it 'is invalid with a non-unique title' do
      second_book = Book.new(title: @book.title, author: Author.new(name: 'foo'))

      is_valid = second_book.valid?

      # expect( is_valid ).must_equal false
    end

  end







  # Book must be of type Book
  # a new book instance if of type Book
end
