require 'rails_helper'

RSpec.describe Tranche, type: :model do
  it { should belong_to :loan }
  it { should have_many :repayments }

  it { should validate_presence_of :amount }
  it { should validate_presence_of :term }
  it { should validate_presence_of :base_rate }
  it { should validate_presence_of :overdue_rate }
  # ...
end