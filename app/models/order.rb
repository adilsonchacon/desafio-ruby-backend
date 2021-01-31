class Order < ApplicationRecord
  belongs_to :transaction_type
  belongs_to :store_owner
  belongs_to :recipient_credit_card

  validates_presence_of :occurrence_value
  validates_numericality_of :occurrence_value
  validates_presence_of :occurrence_date
  validates_presence_of :occurrence_time

  class << self
    def save_from_cnab_content(contents)
      ActiveRecord::Base.transaction do
        i = 0
        contents.each do |content|
          i = i + 1
          store = Store.find_or_create_by(name: content[:store_name])
          owner = Owner.find_or_create_by(name: content[:store_owner_name])
          store_owner = StoreOwner.find_or_create_by(store_id: store.id, owner_id: owner.id)

          recipient = Recipient.find_or_create_by(cpf: content[:recipient_cpf])
          credit_card = CreditCard.find_or_create_by(number: content[:credit_card_number])
          recipient_credit_card = RecipientCreditCard.find_or_create_by(recipient_id: recipient.id, credit_card_id: credit_card.id)

          transaction_type = TransactionType.where(type_id: content[:transaction_type]).first

          order = Order.new(store_owner: store_owner,
            recipient_credit_card: recipient_credit_card,
            transaction_type: transaction_type,
            occurrence_value: content[:occurrence_value],
            occurrence_date: content[:occurrence_date],
            occurrence_time: content[:occurrence_time])
          
          if !order.save
            raise ActiveRecord::Rollback, "#{order.errors.full_messages.first} at object #{i}"
          end
        end
      end
    end
  end

end
