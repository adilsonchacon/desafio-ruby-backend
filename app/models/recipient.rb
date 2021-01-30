class Recipient < ApplicationRecord
    has_many :recipient_credit_cards, dependent: :delete_all
    has_many :credit_cards, through: :recipient_credit_cards

    validates_presence_of :cpf
    validates_uniqueness_of :cpf
end
