class AddChargeIdAndTotalCentsToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :charge_id, :string
    add_column :bookings, :total_cents, :integer
  end
end
