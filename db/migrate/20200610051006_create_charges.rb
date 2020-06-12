class CreateCharges < ActiveRecord::Migration[6.0]
  def change
    create_table :charges do |t|
      t.references :user, null: false, foreign_key: true
      t.string :stripe_session_id
      t.string :stripe_payment_intent_id

      t.timestamps
    end
  end
end
