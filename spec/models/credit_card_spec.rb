require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  describe "relations" do
    it { should have_many(:recipient_credit_cards).dependent(:delete_all) }
    it { should have_many(:recipients).through(:recipient_credit_cards) }
  end

  describe "validations" do
    it { should validate_uniqueness_of(:number) }
    it { should validate_presence_of(:number) }
  end
end
