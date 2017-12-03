FactoryBot.define do
  factory :tranche, class: 'Tranche' do
    loan

    factory :test_tranche do
      amount 1_000_000
      term 6
      base_rate 0.3
      overdue_rate 0.5

      factory :test_calculated_tranche do
        monthly_main_debt_payment "166666.67".to_d
        monthly_percent_payment "25000".to_d
        monthly_overdue_percent_payment "41666.67".to_d
        monthly_total_payment "191666.67".to_d
        monthly_overdue_total_payment "208333.34".to_d
        total_to_pay "1150000.02".to_d
      end
    end

  end
end
