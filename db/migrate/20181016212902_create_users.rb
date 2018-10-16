class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :image_url
      t.integer :uid, null: false
      t.string :provider, null: false

      t.timestamps
    end
  end
end
