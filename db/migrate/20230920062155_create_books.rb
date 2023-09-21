class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.text :description
      t.string :thumbnail
      t.float :rating
      t.decimal :price
      t.boolean :stock
      t.timestamps
    end
  end
end
