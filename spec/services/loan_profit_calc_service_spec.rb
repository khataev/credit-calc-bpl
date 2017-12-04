require 'rails_helper'

RSpec.describe LoanProfitCalcService do

  describe 'loan profit calculating' do
    it 'calculates loan profit' do
      expected_result = {
          optimistic_rate: '0.3'.to_d,
          realistic_rate:  '0.31'.to_d
      }

      loan = create :loan
      tranche1 = create :test_calculated_tranche, { loan: loan }
      tranche2 = create :test_calculated_tranche, { loan: loan }
      tranche3 = create :test_calculated_tranche, { loan: loan }

      # first tranche repayments
      (1..6).each do |i|
        build(:repayment, tranche: tranche1, month_number: i, repayment_type: :in_time).save!
      end
      # По-хорошему, этот тест надо разбить на несколько: тест на расчет реальной ставки в транше и тест расчета
      # общей реальной ставки. Скомпоновано ради экономии времени
      expect(tranche1.real_rate).to eq '0.3'.to_d

      # second tranche repayments
      (1..3).each do |i|
        build(:repayment, tranche: tranche2, month_number: i, repayment_type: :in_time).save!
      end
      build(:repayment, tranche: tranche2, month_number: 4, repayment_type: :full_early).save!
      expect(tranche2.real_rate).to eq '0.2'.to_d

      # third tranche repayments
      (1..2).each do |i|
        build(:repayment, tranche: tranche3, month_number: i, repayment_type: :in_time).save!
      end

      (3..6).each do |i|
        build(:repayment, tranche: tranche3, month_number: i, repayment_type: :overdue).save!
      end
      expect(tranche3.real_rate).to eq '0.43'.to_d

      result = LoanProfitCalcService.new(loan: loan).call
      expect(result).to eq expected_result
    end
  end

end