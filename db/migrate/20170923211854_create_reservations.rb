class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.datetime :checkout_time
      t.datetime :return_time
      t.references :customer, foreign_key: true
      t.references :car, foreign_key: true

      t.timestamps
    end
  end
end
