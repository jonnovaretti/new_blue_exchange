module Core
  class CreateOffer < ApplicationService
    include Interactor

    before do
      context.fail!(error: 'User is required') if context.user.nil?
      context.fail!(error: 'Offer_params is required') if context.offer_params.nil?

      @offer_params = context.offer_params
      @user = context.user
    end

    def call
      @offer = Offer.new(offer_params.merge(user: user))

      @wallet = Wallet.find_by(user_id: user.id, currency_id: offer.currency_amount.id)
      @wallet.transfer_amount_to_hold(offer.amount)

      prepare_context
      
      context.fail!(error: wallet.errors) if wallet.invalid?
      context.fail!(error: offer.errors) if offer.invalid?

      persist_changes if context.success?
    end

    private

    attr_reader :offer, :offer_params, :user, :wallet

    def prepare_context
      context.offer = offer
      context.wallet = wallet
    end

    def persist_changes
      offer.with_lock do
        wallet.save!
        offer.save!
      end
    end
  end
end
