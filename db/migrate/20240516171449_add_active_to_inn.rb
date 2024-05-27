class AddActiveToInn < ActiveRecord::Migration[7.1]
  def change
    add_column :inns, :active, :boolean, default: true
  end
end
