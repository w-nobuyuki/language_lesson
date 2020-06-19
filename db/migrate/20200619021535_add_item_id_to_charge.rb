class AddItemIdToCharge < ActiveRecord::Migration[6.0]
  def change
    add_reference :charges, :item, null: false, foreign_key: true
  end
end
