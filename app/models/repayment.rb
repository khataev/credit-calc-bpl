class Repayment < ApplicationRecord
  extend Enumerize

  belongs_to :tranche

  validates :month_number, numericality: { only_integer: true, greater_than: 0 }
  validates :amount, numericality: { greater_than: 0 }

  enumerize :repayment_type, in: { in_time: 0, overdue: 1, full_early: 2 }

  def calculate_amount!
    return unless self.repayment_type && self.month_number && self.tranche&.monthly_total_payment && self.tranche&.monthly_overdue_total_payment
    self.amount = if self.repayment_type == :in_time
                    self.tranche&.monthly_total_payment
                  elsif self.repayment_type == :overdue
                    self.tranche&.monthly_overdue_total_payment
                  else
                    FullEarlyRepaymentCalcService.new(tranche: self.tranche, month_number: self.month_number).call
                  end
  end
end
