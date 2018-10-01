class Author < ApplicationRecord
  has_many :books

  def first_published
    books_with_year = self.books.where.not(pub_date: nil)
    first_book = books_with_year.order(pub_date: :asc).first
    return first_book ? first_book.pub_date : nil
  end
end