class TransactionType < ApplicationRecord
    has_many :orders

    validates_numericality_of :type_id, only_integer: true
    validates_uniqueness_of :type_id
    validates_presence_of :type_id

    validates_presence_of :description
    validates_uniqueness_of :description

    validates_presence_of :nature
    validates_inclusion_of :nature, in: ['Entrada', 'Saída']

    validates_presence_of :signal
    validates_inclusion_of :signal, in: ['+', '-']
end
