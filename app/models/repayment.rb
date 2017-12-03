class Repayment < ApplicationRecord
  extend Enumerize

  belongs_to :tranche

  validates :month_number, numericality: { only_integer: true, greater_than: 0 }
  validates :amount, numericality: { greater_than: 0 }

  enumerize :type, in: { in_time: 0, overdue: 1, full_early: 2 }
end
