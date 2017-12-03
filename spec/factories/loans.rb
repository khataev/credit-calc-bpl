FactoryBot.define do
  sequence(:name) { |n| "Loan#{n}" }

  factory :loan do
    name
  end
end
