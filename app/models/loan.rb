class Loan < ApplicationRecord
  has_many :tranches, dependent: :destroy, class_name: 'Tranche'

  validates :name, presence: true
end
