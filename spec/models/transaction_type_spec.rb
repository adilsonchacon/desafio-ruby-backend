require 'rails_helper'

RSpec.describe TransactionType, type: :model do

  describe "relations" do
    it { should have_many(:orders) }
  end

  describe "validations" do
    it { should validate_numericality_of(:type_id).only_integer }
    it { should validate_uniqueness_of(:type_id) }
    it { should validate_presence_of(:type_id) }
    it { should validate_presence_of(:description) }
    it { should validate_uniqueness_of(:description) }
    it { should validate_presence_of(:nature) }
    it { should validate_inclusion_of(:nature).in_array(['Entrada', 'Saída']) }
    it { should validate_presence_of(:signal) }
    it { should validate_inclusion_of(:signal).in_array(['+', '-']) }
  end

end
