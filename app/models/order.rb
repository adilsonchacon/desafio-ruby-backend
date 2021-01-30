class Order < ApplicationRecord
  belongs_to :transaction_type
  belongs_to :store_owner
  belongs_to :recipient_credit_card

  validates_presence_of :occurrence_value
  validates_numericality_of :occurrence_value
  validates_presence_of :occurrence_date
  validates_presence_of :occurrence_time
end
