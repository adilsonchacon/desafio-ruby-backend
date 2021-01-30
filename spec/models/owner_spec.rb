require 'rails_helper'

RSpec.describe Owner, type: :model do
  describe "relations" do
    it { should have_many(:store_owners).dependent(:delete_all) }
    it { should have_many(:stores).through(:store_owners) }
  end

  describe "validations" do
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:name) }
  end
end
