require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "relations" do
    it { should belong_to(:transaction_type) }
    it { should belong_to(:recipient_credit_card) }
    it { should belong_to(:store_owner) }
  end

  describe "validations" do
    it { should validate_numericality_of(:occurrence_value) }
    it { should validate_presence_of(:occurrence_value) }
    it { should validate_presence_of(:occurrence_date) }
    it { should validate_presence_of(:occurrence_time) }
  end

end
