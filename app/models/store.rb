class Store < ApplicationRecord
  has_many :store_owners, dependent: :delete_all
  has_many :owners, through: :store_owners

  validates_presence_of :name
  validates_uniqueness_of :name

  def orders
    Order.find_by_sql("SELECT * FROM orders WHERE store_owner_id 
      IN (SELECT id FROM store_owners WHERE store_id = #{self.id})")
  end

  def balance
    input = Order.find_by_sql("SELECT SUM(orders.occurrence_value) AS total FROM orders 
    INNER JOIN transaction_types ON transaction_types.id = orders.transaction_type_id 
    WHERE orders.store_owner_id IN (SELECT id FROM store_owners WHERE store_id = #{self.id})
    AND transaction_types.nature = 'Entrada'")

    output = Order.find_by_sql("SELECT SUM(orders.occurrence_value) AS total FROM orders 
    INNER JOIN transaction_types ON transaction_types.id = orders.transaction_type_id 
    WHERE orders.store_owner_id IN (SELECT id FROM store_owners WHERE store_id = #{self.id})
    AND transaction_types.nature = 'Saída'")

    (input[0].total || 0) - (output[0].total || 0)
  end

end
