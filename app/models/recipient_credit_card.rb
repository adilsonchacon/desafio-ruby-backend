class RecipientCreditCard < ApplicationRecord
  belongs_to :recipient
  belongs_to :credit_card
end
