require 'rails_helper'

RSpec.describe Store, type: :model do
  describe "relations" do
    it { should have_many(:store_owners).dependent(:delete_all) }
    it { should have_many(:owners).through(:store_owners) }
  end

  describe "validations" do
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:name) }
  end

  describe "orders" do
    it 'should return entries for an specific store' do
      create_transaction_types

      valid_file = File.join(Rails.root, 'spec', 'fixtures', 'valid_cnab_file.txt')
      cnab = CnabParser.new(valid_file)
      cnab.parse
      Order.save_from_cnab_content(cnab.content)
      
      store = Store.find_by(name: 'BAR DO JOÃO')

      expect(store.orders.size).to eq(3)
    end
  end

  describe "balance" do
    it 'should return the balance for an specific store' do
      create_transaction_types
      
      valid_file = File.join(Rails.root, 'spec', 'fixtures', 'valid_cnab_file.txt')
      cnab = CnabParser.new(valid_file)
      cnab.parse
      Order.save_from_cnab_content(cnab.content)

      store = Store.find_by(name: 'BAR DO JOÃO')

      expect(store.balance).to eq(-102)
    end
  end

end
