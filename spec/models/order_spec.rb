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

  describe 'save_from_cnab_content' do
    it 'should save all file content' do
      create_transaction_types
      
      valid_file = File.join(Rails.root, 'spec', 'fixtures', 'valid_cnab_file.txt')
      cnab = CnabParser.new(valid_file)
      cnab.parse

      Order.save_from_cnab_content(cnab.content)

      expect(Order.count).to eq(21)
      expect(Store.count).to eq(5)
      expect(Owner.count).to eq(4)
      expect(StoreOwner.count).to eq(5)
      expect(Recipient.count).to eq(4)
      expect(CreditCard.count).to eq(13)
      expect(RecipientCreditCard.count).to eq(17)
    end

    it 'should not save any if content is invalid' do
      create_transaction_types
      
      valid_file = File.join(Rails.root, 'spec', 'fixtures', 'valid_cnab_file.txt')
      cnab = CnabParser.new(valid_file)
      cnab.parse
      cnab.content[0][:occurrence_value] = 'x'

      Order.save_from_cnab_content(cnab.content)

      expect(Order.count).to eq(0)
      expect(Store.count).to eq(0)
      expect(Owner.count).to eq(0)
      expect(StoreOwner.count).to eq(0)
      expect(Recipient.count).to eq(0)
      expect(CreditCard.count).to eq(0)
      expect(RecipientCreditCard.count).to eq(0)
    end

  end

end
