class CreditCard < ApplicationRecord
    has_many :recipient_credit_cards, dependent: :delete_all
    has_many :recipients, through: :recipient_credit_cards

    validates_presence_of :number
    validates_uniqueness_of :number
end
