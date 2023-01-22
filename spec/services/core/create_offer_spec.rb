require 'rails_helper'

RSpec.describe Core::CreateOffer do
  let(:user) { create(:user) }
  let(:currency) { create(:currency, :usd) }
  let!(:offer_params) { attributes_for(:offer).merge(currency_amount: currency, currency_unit_price: create(:currency, :brl)) }

  subject { Core::CreateOffer.call(user: user, offer_params: offer_params) }

  context 'when user is nil' do
    let(:user) { nil }

    it 'fails' do
      expect(subject).to be_failure
    end
  end

  context 'when offer_params is nil' do
    let(:offer_params) { nil }

    it 'fails' do
      expect(subject).to be_failure
    end
  end

  context 'when user and offer_params are present' do
    let(:wallet) { create(:wallet, user: user, currency: currency) }

    before do
      allow(wallet).to receive(:invalid?).and_return(false)
      allow_any_instance_of(Offer).to receive(:invalid?).and_return(false)
    end

    it 'succeeds' do
      expect(subject).to be_success
    end

    it 'creates a new offer' do
      expect(subject.offer).to be_persisted
    end
  end

  context 'when wallet is invalid' do
    before do
      create(:wallet, user: user, currency: currency)
      allow_any_instance_of(Wallet).to receive(:invalid?).and_return(true)
      allow_any_instance_of(Offer).to receive(:invalid?).and_return(false)
    end

    it 'fails' do
      expect(subject).to be_failure
    end

    it 'does not create a new offer' do
      expect(subject.offer).not_to be_persisted
    end
  end

  context 'when offer is invalid' do
    before do
      create(:wallet, user: user, currency: currency)
      allow_any_instance_of(Wallet).to receive(:invalid?).and_return(false)
      allow_any_instance_of(Offer).to receive(:invalid?).and_return(true)
    end

    it 'fails' do
      expect(subject).to be_failure
    end

    it 'does not create a new offer' do
      expect(subject.offer).not_to be_persisted
    end
  end
end
