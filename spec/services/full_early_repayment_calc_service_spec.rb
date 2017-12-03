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
    tranche = create :test_calculated_tranche
    result = FullEarlyRepaymentCalcService.new(tranche: tranche, month_number: 4).call
    expect(result).to eq "524999.99".to_d
  end
end