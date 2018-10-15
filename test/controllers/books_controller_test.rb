require "test_helper"

describe BooksController do

  it "should get index" do
    # Act
    get books_path

    # Assert
    must_respond_with :success
  end

end
