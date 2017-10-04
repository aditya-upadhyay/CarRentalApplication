class AddActiveToReservation < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :active, :boolean
  end
end
