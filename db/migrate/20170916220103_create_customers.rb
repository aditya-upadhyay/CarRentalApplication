class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :email
      t.string :name
      t.string :password
      t.float :rental_charges

      t.timestamps
    end
  end
end
