class Store < ApplicationRecord
    has_many :store_owners, dependent: :delete_all
    has_many :owners, through: :store_owners

    validates_presence_of :name
    validates_uniqueness_of :name
end
