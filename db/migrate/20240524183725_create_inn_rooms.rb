class CreateInnRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :inn_rooms do |t|
      t.string :name
      t.integer :size
      t.references :inn, null: false, foreign_key: true
      t.integer :guest_limit

      t.timestamps
    end
  end
end
