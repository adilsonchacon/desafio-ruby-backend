require 'rails_helper'

RSpec.describe StoreOwner, type: :model do
  describe "relations" do
    it { should belong_to(:store) }
    it { should belong_to(:owner) }
  end    
end
