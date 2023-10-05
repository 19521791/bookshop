class ChangeRoleBackToEnum < ActiveRecord::Migration[7.0]
  def up
    change_column :users, :role, :integer, using: "role::integer"
  end

  def down
    change_column :users, :role, :integer
  end
end
