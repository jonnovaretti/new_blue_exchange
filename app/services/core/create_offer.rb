module Core
  class CreateOffer < ApplicationService
    def initialize(offer_params, wallet)
      raise ArgumentError, 'Offer_params is required' if offer_params.nil?
      raise ArgumentError, 'Wallet is required' if wallet.nil?

      @offer_params = offer_params
      @wallet = wallet

      validate_currencies
    end

    def call
      @offer = Offer.new(offer_params)
      wallet.transfer_amount_to_hold(offer.amount)

      add_errors_to_offer if wallet.invalid?
      return offer if any_model_invalid?

      persist_changes

      offer
    end

    private

    attr_reader :offer, :offer_params, :wallet

    def any_model_invalid?
      offer.invalid? || wallet.invalid?
    end

    def add_errors_to_offer
      offer.errors.copy!(wallet.errors)
    end

    def persist_changes
      offer.with_lock do
        wallet.save!
        offer.save!
      end
    end

    def validate_currencies
      return unless wallet.currency != offer_params[:currency_amount]

      raise ArgumentError, 'Currency amount needs to be the same as wallet currency'
    end
  end
end
