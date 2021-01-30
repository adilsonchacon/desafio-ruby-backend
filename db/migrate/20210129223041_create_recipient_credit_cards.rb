class CreateRecipientCreditCards < ActiveRecord::Migration[6.1]
  def change
    create_table :recipient_credit_cards do |t|
      t.references :recipient, null: false, foreign_key: true
      t.references :credit_card, null: false, foreign_key: true

      t.timestamps
    end
  end
end
