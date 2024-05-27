class AddDescriptionToInn < ActiveRecord::Migration[7.1]
  def change
    add_column :inns, :description, :text
  end
end
