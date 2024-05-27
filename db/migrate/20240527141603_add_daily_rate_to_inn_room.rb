class AddDailyRateToInnRoom < ActiveRecord::Migration[7.1]
  def change
    add_column :inn_rooms, :daily_rate_cents, :integer
  end
end
