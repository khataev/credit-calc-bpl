class TrancheRepaymentCalcService < BaseService

  attribute :tranche, Tranche

  def call
    return {} unless tranche&.amount && tranche&.term && tranche.term != 0 && tranche&.base_rate
    monthly_main_debt_payment = (tranche.amount / tranche.term).round(2)
    monthly_percent_payment = (tranche.amount * tranche.base_rate / 12).round(2)
    monthly_overdue_percent_payment = (tranche.amount * tranche.overdue_rate / 12).round(2)
    monthly_total_payment = monthly_main_debt_payment + monthly_percent_payment
    monthly_overdue_total_payment = monthly_main_debt_payment + monthly_overdue_percent_payment
    {
        monthly_main_debt_payment: monthly_main_debt_payment,
        monthly_percent_payment: monthly_percent_payment,
        monthly_total_payment: monthly_total_payment,
        monthly_overdue_percent_payment: monthly_overdue_percent_payment,
        monthly_overdue_total_payment: monthly_overdue_total_payment,
        total_to_pay: (monthly_total_payment * tranche.term).round(2)
    }
  end
end