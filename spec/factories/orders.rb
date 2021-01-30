FactoryBot.define do
  factory :order do
    transaction_type { nil }
    store_owner { nil }
    recipient_credit_card { nil }
    occurrence_date { "2021-01-29" }
    occurrence_time { "2021-01-29 19:30:45" }
    occurrence_value { 1.5 }
  end
end
