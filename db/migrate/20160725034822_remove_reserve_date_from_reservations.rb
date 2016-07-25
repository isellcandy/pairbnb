class RemoveReserveDateFromReservations < ActiveRecord::Migration
  def change
    remove_column :reservations, :reserve_date, :date
  end
end
