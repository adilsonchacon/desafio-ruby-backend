class Owner < ApplicationRecord
    has_many :store_owners, dependent: :delete_all
    has_many :stores, through: :store_owners

    validates_presence_of :name
    validates_uniqueness_of :name
end
