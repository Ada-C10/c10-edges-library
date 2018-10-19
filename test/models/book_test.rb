require "test_helper"

describe Book do

  describe 'relations' do

    it "has an author" do
      # Arrange
      b = Book.first

      # Act
      author = b.author

      # Assert
      expect(author).must_be_instance_of Author
    end

    it "Has some genres" do
      b = Book.first

      genres = b.genres

      expect(genres).must_respond_to :each
    end

  end


  describe 'validations' do

    before do
      @book = Book.new(
        title: 'test book',
        author: Author.first
      )
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
      @book.title = Book.first.title

      is_valid = @book.valid?

      expect( is_valid ).must_equal false
      expect( @book.errors.messages ).must_include :title
    end

  end

end
