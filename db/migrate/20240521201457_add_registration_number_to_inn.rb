class AddRegistrationNumberToInn < ActiveRecord::Migration[7.1]
  def change
    add_column :inns, :registration_number, :string
    add_index  :inns, :registration_number, unique: true
  end
end
