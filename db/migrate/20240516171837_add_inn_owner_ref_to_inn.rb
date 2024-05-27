class AddInnOwnerRefToInn < ActiveRecord::Migration[7.1]
  def change
    add_reference :inns, :inn_owner, null: false, foreign_key: true
  end
end
