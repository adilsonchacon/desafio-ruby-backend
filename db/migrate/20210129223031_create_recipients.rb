class CreateRecipients < ActiveRecord::Migration[6.1]
  def change
    create_table :recipients do |t|
      t.string :cpf, index: true, unique: true

      t.timestamps
    end
  end
end
