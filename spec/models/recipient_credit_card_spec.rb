require 'rails_helper'

RSpec.describe RecipientCreditCard, type: :model do
  describe "relations" do
    it { should belong_to(:recipient) }
    it { should belong_to(:credit_card) }
  end  
end
