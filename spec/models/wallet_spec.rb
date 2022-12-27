require 'rails_helper'

RSpec.describe Wallet, type: :model do
  subject(:wallet) { create(:wallet) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:currency) }
  end

  describe 'validations' do
    it { should validate_presence_of(:available_amount) }
    it { should validate_presence_of(:hold_amount) }
    it { should allow_value(0).for(:available_amount) }
    it { should allow_value(1000.5555).for(:available_amount) }
    it { should_not allow_value(-1).for(:available_amount) }
    it { should allow_value(0).for(:hold_amount) }
    it { should allow_value(1000.5555).for(:hold_amount) }
    it { should_not allow_value(-1).for(:hold_amount) }
  end
end
