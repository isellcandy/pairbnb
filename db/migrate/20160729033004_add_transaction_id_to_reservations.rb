class AddTransactionIdToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :transaction_id, :string
  end
end
