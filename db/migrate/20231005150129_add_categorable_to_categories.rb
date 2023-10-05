class AddCategorableToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :categorable_id, :integer
    add_column :categories, :categorable_type, :string
  end
end
