FactoryBot.define do
  factory :tranche, class: 'Tranche' do
    loan

    factory :test_tranche do
      amount 1_000_000
      term 6
      base_rate 0.3
      overdue_rate 0.5
    end

  end
end
