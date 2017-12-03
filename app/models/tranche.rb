class Tranche < ApplicationRecord
  belongs_to :loan
  has_many :repayments

  validates :amount, presence: true
  validates :term, presence: true
  validates :base_rate, presence: true
  validates :overdue_rate, presence: true
end
