require 'rails_helper'

RSpec.describe Recipient, type: :model do
  describe "relations" do
    it { should have_many(:recipient_credit_cards).dependent(:delete_all) }
    it { should have_many(:credit_cards).through(:recipient_credit_cards) }
  end

  describe "validations" do
    it { should validate_uniqueness_of(:cpf) }
    it { should validate_presence_of(:cpf) }
  end
end
