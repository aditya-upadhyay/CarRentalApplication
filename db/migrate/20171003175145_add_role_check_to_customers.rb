class AddRoleCheckToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :role_check, :string
  end
end
