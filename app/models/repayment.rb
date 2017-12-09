class Repayment < ApplicationRecord
  extend Enumerize

  belongs_to :tranche

  validates :month_number, numericality: { only_integer: true, greater_than: 0 }

  enumerize :repayment_type, in: { in_time: 0, overdue: 1, full_early: 2 }, predicates: true

  before_save :calculate_amounts!
  after_save :update_tranche
  after_destroy :update_tranche

  scope :ordered, -> { order(month_number: :asc) }

  private

  def calculate_amounts!
    return unless self.repayment_type && self.month_number && self.tranche&.monthly_total_payment && self.tranche&.monthly_overdue_total_payment
    if %w[in_time overdue].include? self.repayment_type
      self.main_debt = self&.tranche.monthly_main_debt_payment
      self.percent = self.in_time? ? self&.tranche.monthly_percent_payment : self.tranche&.monthly_overdue_percent_payment
      self.total_amount = self.in_time? ? self&.tranche.monthly_total_payment : self.tranche&.monthly_overdue_total_payment
    else
      params = FullEarlyRepaymentCalcService.new(tranche: self.tranche, month_number: self.month_number).call
      self.main_debt = params[:main_debt]
      self.percent = params[:percent]
      self.total_amount = params[:total_amount]
    end
  end

  def update_tranche
    self.tranche.update_repaid!(self, self.destroyed?)
  end

end
