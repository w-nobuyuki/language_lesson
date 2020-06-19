class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :description
      t.integer :amount, null: false
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
