require 'rails_helper'

RSpec.describe Repayment, type: :model do
  it { should belong_to :tranche }

  it { should validate_numericality_of(:month_number).only_integer.is_greater_than(0) }
  it { should enumerize(:repayment_type).in(:in_time, :overdue, :full_early) }

  describe 'calculate_amount!' do
    let(:tranche) { create :test_calculated_tranche }
    it 'in-time repayment' do
      repayment = tranche.repayments.new(month_number: 1, repayment_type: :in_time)
      repayment.send :calculate_amounts!

      expect(repayment.main_debt).to eq tranche.monthly_main_debt_payment
      expect(repayment.percent).to eq tranche.monthly_percent_payment
      expect(repayment.total_amount).to eq tranche.monthly_total_payment
    end

    it 'overdue repayment' do
      repayment = tranche.repayments.new(month_number: 1, repayment_type: :overdue)
      repayment.send :calculate_amounts!

      expect(repayment.main_debt).to eq tranche.monthly_main_debt_payment
      expect(repayment.percent).to eq tranche.monthly_overdue_percent_payment
      expect(repayment.total_amount).to eq tranche.monthly_overdue_total_payment
    end

    # third case is tested in service spec
  end

  describe 'update tranche' do
    let(:tranche) { create :test_calculated_tranche }

    it 'create' do
      initial_main_debt_repaid, initial_percent_repaid = tranche.main_debt_repaid, tranche.percent_repaid
      repayment = build(:repayment, tranche: tranche, repayment_type: :in_time, month_number: 1)
      repayment.save
      tranche.reload
      expect(tranche.main_debt_repaid).to eq (initial_main_debt_repaid + repayment.main_debt)
      expect(tranche.percent_repaid).to eq (initial_percent_repaid + repayment.percent)
    end

    it 'destroy' do
      repayment = build(:repayment, tranche: tranche, repayment_type: :in_time, month_number: 1)
      repayment.save
      initial_main_debt_repaid, initial_percent_repaid = tranche.main_debt_repaid, tranche.percent_repaid
      tranche.repayments.first.destroy
      tranche.reload

      expect(tranche.main_debt_repaid).to eq (initial_main_debt_repaid - repayment.main_debt)
      expect(tranche.percent_repaid).to eq (initial_percent_repaid - repayment.percent)
    end

    it 'update'
  end
end