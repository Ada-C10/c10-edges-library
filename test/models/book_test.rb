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

    it 'is invalid if its title is non-unique within its author\'s books' do
      @book.title = @book.author.books.first.title

      is_valid = @book.valid?

      expect( is_valid ).must_equal false
      expect( @book.errors.messages ).must_include :title
    end

  end

end
