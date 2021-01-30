FactoryBot.define do
  factory :transaction_type do
    type_id { 1 }
    description { "MyString" }
    nature { "MyString" }
    signal { "MyString" }
  end
end
