require 'rails_helper'

RSpec.describe Loan, type: :model do
  it { should have_many(:tranches).dependent(:destroy) }

  it { should validate_presence_of :name }
end