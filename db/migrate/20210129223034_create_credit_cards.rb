class CreateCreditCards < ActiveRecord::Migration[6.1]
  def change
    create_table :credit_cards do |t|
      t.string :number, index: true, unique: true

      t.timestamps
    end
  end
end
