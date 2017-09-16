class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :license_plate_number
      t.string :manufacturer
      t.string :model
      t.float :hourly_rental_rate
      t.string :style
      t.string :location
      t.string :status

      t.timestamps
    end
  end
end
