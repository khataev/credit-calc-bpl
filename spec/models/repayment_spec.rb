require 'rails_helper'

RSpec.describe Repayment, type: :model do
  it { should belong_to :tranche }

  it { should validate_numericality_of(:month_number).only_integer.is_greater_than(0) }
  it { should validate_numericality_of(:amount).is_greater_than(0) }
  it { should enumerize(:type).in(:in_time, :overdue, :full_early) }
end