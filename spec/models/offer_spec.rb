require 'rails_helper'

RSpec.describe Offer, type: :model do
  subject(:offer) { create(:offer) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:currency_amount).class_name('Currency') }
    it { should belong_to(:currency_unit_price).class_name('Currency') }
  end

  describe 'validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:unit_price) }
    it { should_not allow_value(0).for(:amount) }
    it { should_not allow_value(10).for(:amount) }
    it { should allow_value(20).for(:amount) }
    it { should allow_value(20.9999).for(:amount) }
    it { should allow_value(5.2).for(:unit_price) }
    it { should_not allow_value(0).for(:unit_price) }
    it { should validate_uniqueness_of(:currency_amount_id).scoped_to([:id, :currency_unit_price_id]) }
  end
end
