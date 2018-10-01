class BookAuthorToAuthorId < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :author


    # add_column :books, :author_id, :integer
    add_reference :books, :author, foreign_key: true
  end
end
