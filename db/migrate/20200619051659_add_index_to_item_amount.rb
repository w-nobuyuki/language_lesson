class AddIndexToItemAmount < ActiveRecord::Migration[6.0]
  def change
    add_index :items, :amount
  end
end
