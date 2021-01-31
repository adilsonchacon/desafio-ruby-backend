class CreateTransactionTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :transaction_types do |t|
      t.integer :type_id, unique: true, index: true
      t.string :description
      t.string :nature
      t.string :signal

      t.timestamps
    end
  end
end
