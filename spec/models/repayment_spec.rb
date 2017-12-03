require 'rails_helper'

RSpec.describe Repayment, type: :model do
  it { should belong_to :tranche }

  it { should validate_numericality_of(:month_number).only_integer.is_greater_than(0) }
  it { should validate_numericality_of(:amount).is_greater_than(0) }
  it { should enumerize(:repayment_type).in(:in_time, :overdue, :full_early) }

  describe 'calculate_amount!' do
    it 'in-time repayment' do
      tranche = create :test_calculated_tranche
      repayment = tranche.repayments.new(month_number: 1, repayment_type: :in_time)
      repayment.calculate_amount!

      expect(repayment.amount).to eq tranche.monthly_total_payment
    end

    it 'overdue repayment' do
      tranche = create :test_calculated_tranche
      repayment = tranche.repayments.new(month_number: 1, repayment_type: :overdue)
      repayment.calculate_amount!

      expect(repayment.amount).to eq tranche.monthly_overdue_total_payment
    end

    it 'full early repayment' do
      tranche = create :test_calculated_tranche
      repayment = tranche.repayments.new(month_number: 4, repayment_type: :full_early)
      repayment.calculate_amount!

      expect(repayment.amount).to eq "524999.99".to_d
    end
  end
end