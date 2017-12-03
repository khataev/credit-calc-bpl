require 'rails_helper'

RSpec.describe TrancheRepaymentCalcService do
  it 'calculates empty params for nil tranche' do
    result = TrancheRepaymentCalcService.new.call
    expect(result).to eq({})
  end

  it 'calculates tranche repayment parameters' do
    params = {
        monthly_main_debt_payment: "166666.67".to_d,
        monthly_percent_payment: "25000".to_d,
        monthly_overdue_percent_payment: "41666.67".to_d,
        monthly_total_payment: "191666.67".to_d,
        monthly_overdue_total_payment: "208333.34".to_d,
        total_to_pay: "1150000.02".to_d
    }

    tranche = create :test_tranche
    result = TrancheRepaymentCalcService.new(tranche: tranche).call

    expect(result).to eq params
  end
end