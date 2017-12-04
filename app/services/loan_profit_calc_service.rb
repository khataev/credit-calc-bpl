class LoanProfitCalcService < BaseService

  attribute :loan, Loan

  def call
    return {} unless loan
    tranches_count = loan.tranches.count
    optimistic_rate = loan.tranches.sum(&:base_rate) / tranches_count
    realistic_rate = loan.tranches.sum(&:real_rate) / tranches_count

    { optimistic_rate: optimistic_rate, realistic_rate: realistic_rate }
  end
end