require 'rails_helper'

RSpec.describe Core::CreateOffer do
  describe '#initialize' do
    let(:currency_amount) { create(:currency, :usd) }
    let(:wallet) { create(:wallet, :usd_currency) }
    subject(:subject) { Core::CreateOffer.new(offer_params, wallet) }
    let(:offer_params) do
      { amount: 500,
        unit_price: 5.32,
        currency_amount: currency_amount,
        currency_unit_price: create(:currency, :brl) }
    end

    context 'when offer_params is nil' do
      let(:offer_params) { nil }
      it 'raises ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'when wallet is nil' do
      let(:wallet) { nil }
      it 'raises ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'when wallets currency is different of amount currency' do
      let(:currency_different) { create(:currency) }
      let(:wallet) { create(:wallet, currency: currency_different) }

      it 'raises ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#call' do
    let(:currency_amount) { create(:currency, :usd) }
    let(:wallet) { create(:wallet, :usd_currency) }
    subject(:subject) { Core::CreateOffer.call(offer_params, wallet) }
    let(:offer_params) do
      { amount: 500,
        unit_price: 5.32,
        currency_amount: currency_amount,
        currency_unit_price: create(:currency, :brl) }
    end

    context 'when wallets currency is different of amount currency' do
      let(:currency_different) { create(:currency) }
      let(:wallet) { create(:wallet, currency: currency_different) }

      it 'raises ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end
end
