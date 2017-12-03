class FullEarlyRepaymentCalcService < BaseService

  attribute :tranche, Tranche
  attribute :month_number, Integer

  def call
    return unless tranche&.amount && tranche&.monthly_main_debt_payment && tranche&.monthly_percent_payment
    return unless month_number && month_number > 0

    (tranche.amount - (month_number - 1) * tranche.monthly_main_debt_payment + tranche.monthly_percent_payment).round(2)
  end
end