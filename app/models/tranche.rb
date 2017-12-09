class Tranche < ApplicationRecord
  belongs_to :loan
  has_many :repayments, dependent: :delete_all

  validates :amount, presence: true
  validates :term, presence: true
  validates :base_rate, presence: true
  validates :overdue_rate, presence: true

  # TODO: нужен явный признак
  scope :repaid, -> { where.not(real_rate: nil) }

  def base_rate_percent
    (base_rate || 0) * 100
  end

  def overdue_rate_percent
    (overdue_rate || 0) * 100
  end

  def real_rate_percent
    (real_rate || 0) * 100
  end

  def repaid?
    last_repayment = repayments.ordered.last
    last_repayment&.full_early? || last_repayment&.month_number == term
  end

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
