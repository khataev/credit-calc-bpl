require 'rails_helper'

RSpec.describe FullEarlyRepaymentCalcService do
  it 'calculates empty params for nil tranche' do
    result = FullEarlyRepaymentCalcService.new.call
    expect(result).to be_blank
  end

  it 'calculates empty params if month not specified' do
    tranche = create :test_tranche
    result = FullEarlyRepaymentCalcService.new(tranche: tranche).call
    expect(result).to be_blank
  end

  it 'calculates full early repayment amount' do
    expected_result = { main_debt: "499999.99".to_d, percent: "25000".to_d, total_amount: "524999.99".to_d }
    tranche = create :test_calculated_tranche
    result = FullEarlyRepaymentCalcService.new(tranche: tranche, month_number: 4).call
    expect(result).to eq expected_result
  end
end