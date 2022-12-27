require 'rails_helper'

RSpec.describe Currency, type: :model do
  subject(:currency) { build(:currency) }

  describe 'validations' do
    it { should validate_presence_of(:symbol) }
    it { should validate_presence_of(:code) }
    it { should validate_uniqueness_of(:code) }
  end
end
