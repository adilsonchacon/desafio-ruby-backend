class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :transaction_type, null: false, foreign_key: true
      t.references :store_owner, null: false, foreign_key: true
      t.references :recipient_credit_card, null: false, foreign_key: true
      t.date :occurrence_date
      t.time :occurrence_time
      t.float :occurrence_value, scale: 2

      t.timestamps
    end
  end
end
