class AddAncestryToAccount < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :ancestry, :string
    add_index :accounts, :ancestry
  end
end
