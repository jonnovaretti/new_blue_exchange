require 'rails_helper'

RSpec.describe OffersController, type: :request do
  let(:user) { create(:user) }
  let(:currency_usd) { create(:currency, code: 'USD') }
  let(:currency_sgd) { create(:currency, code: 'SGD') }
  let(:offers) {create_list(:offer, 5, currency_amount: currency_usd, currency_unit_price: currency_sgd)}
  let(:valid_attributes) do
    attributes_for(:offer, user_id: user.id, currency_amount_id: currency_usd.id,
                           currency_unit_price_id: currency_sgd.id)
  end
  let(:invalid_attributes) do
    { amount: 5, unit_price: 1, user: user, currency_amount_id: currency_usd.id,
      currency_unit_price_id: currency_sgd.id }
  end

  before do
    sign_in user
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_user_offer_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      get edit_user_offer_url(offers.first)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Offer' do
        expect do
          post user_offers_url, params: { offer: valid_attributes }
        end.to change(Offer, :count).by(1)
      end

      it 'redirects to the created offer' do
        post user_offers_url, params: { offer: valid_attributes }
        expect(response).to redirect_to(user_offers_url)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Offer' do
        expect do
          post user_offers_url, params: { offer: invalid_attributes }
        end.to change(Offer, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post user_offers_url, params: { offer: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    let(:offer) { create(:offer, user: user) }

    context 'with valid parameters' do
      let(:new_amount) { 500 }
      let(:new_attributes) { { amount: new_amount } }

      it 'updates the requested offer' do
        patch user_offer_url(offer), params: { offer: new_attributes }
        offer.reload

        expect(offer.amount).to eq(new_amount)
      end

      it 'redirects to the offer' do
        patch user_offer_url(offer), params: { offer: new_attributes }
        offer.reload
        expect(response).to redirect_to(user_offers_url)
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        patch user_offer_url(offer), params: { offer: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    let(:offer) { create(:offer, user: user) }

    it 'destroys the requested offer' do
      expect do
        delete user_offer_url(offer)
      end.to change(Offer, :count).by(0)
    end

    it 'redirects to the offers list' do
      delete user_offer_url(offer)
      expect(response).to redirect_to(offers_url)
    end
  end
end
