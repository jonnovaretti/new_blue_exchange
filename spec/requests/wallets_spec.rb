require 'rails_helper'

RSpec.describe WalletsController, type: :request do
  describe 'GET /index' do
    let(:wallet) { create(:wallet) }

    it 'renders a successful response' do
      sign_in wallet.user

      get user_wallets_url(wallet.user)

      expect(response).to be_successful
    end

    it 'renders a not authorized response' do
      get user_wallets_url(wallet.user)

      expect(response).to be_unauthorized
    end
  end
end
