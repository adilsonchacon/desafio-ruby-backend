class CreateOwners < ActiveRecord::Migration[6.1]
  def change
    create_table :owners do |t|
      t.string :name, index: true, unique: true

      t.timestamps
    end
  end
end
