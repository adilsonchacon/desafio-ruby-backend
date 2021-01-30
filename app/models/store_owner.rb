class StoreOwner < ApplicationRecord
  belongs_to :store
  belongs_to :owner
end
