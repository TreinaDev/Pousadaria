class AddNeighborhoodToAddresses < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :neighborhood, :string
  end
end
