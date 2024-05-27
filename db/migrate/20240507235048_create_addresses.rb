class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :postal_code
      t.string :address
      t.string :number
      t.string :city
      t.string :state
      t.references :inn, null: false, foreign_key: true

      t.timestamps
    end
  end
end
