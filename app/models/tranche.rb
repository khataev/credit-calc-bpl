class Tranche < ApplicationRecord
  belongs_to :loan
  has_many :repayments

  validates :amount, presence: true
  validates :term, presence: true
  validates :base_rate, presence: true
  validates :overdue_rate, presence: true

  # TODO: Вынести в отдельный сервис?
  def update_repaid!(repayment, destroyed)
    self.main_debt_repaid +=  (destroyed ? -1 : 1) * repayment.main_debt
    self.percent_repaid +=  (destroyed ? -1 : 1) * repayment.percent
    self.real_rate = calc_real_rate if repayment.full_early? || repayment.month_number == self.term
    self.save!
  end

  private

  def calc_real_rate
    return 0 unless  self.percent_repaid && self.main_debt_repaid && self.term
    ((12 * self.percent_repaid) / (self.main_debt_repaid * self.term)).round(2)
  end
end
