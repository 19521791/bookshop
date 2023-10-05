class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.text :description
      t.string :thumbnail
      t.float :rating
      t.decimal :price, null: false
      t.boolean :stock
         
      t.timestamps
    end
  end
end
