class DropStuffModel < ActiveRecord::Migration[7.0]
  def up
    drop_table :book_categories if table_exists?(:book_categories)
    drop_table :books if table_exists?(:books)
    drop_table :categories if table_exists?(:categories)
    drop_table :users if table_exists?(:users)
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
