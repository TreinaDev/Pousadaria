class CreateInns < ActiveRecord::Migration[7.1]
  def change
    create_table :inns do |t|
      t.string :name

      t.timestamps
    end
  end
end
