require 'rails_helper'

RSpec.describe OffersController, type: :request do
  describe "GET /index" do
    it "renders a successful response" do
      currency_usd = create(:currency, code: 'USD')
      currency_sgd = create(:currency, code: 'SGD')
      create_list(:offer, 5, currency_amount: currency_usd, currency_unit_price: currency_sgd)
      get offers_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      offer = create(:offer)
      get offer_url(offer)
      expect(response).to be_successful
    end
  end
end
