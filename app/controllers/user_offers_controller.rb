# frozen_string_literal: true

class UserOffersController < ApplicationController
  before_action :set_offer, only: %i[edit update destroy]

  def index
    @offers = Offer.where(user: current_user).order(created_at: :desc)
  end

  def new
    @offer = Offer.new
  end

  def edit
    @offer.wait!
  end

  def create
    @result = Core::CreateOffer.call(user: current_user, offer_params: offer_params.merge(currency_amount: Currency.currency_usd,
                                                                                          currency_unit_price: Currency.currency_brl))

    respond_to do |format|
      if @result.success?
        format.html { redirect_to user_offers_url, notice: 'Offer was successfully created.' }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('user_offers_form',
                                                    partial: 'form', locals: { offer: @result.offer })
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @offer.update(offer_params)
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@offer)}_line", partial: 'offer_line',
                                                                                      locals: { offer: @offer })
        end
        format.html { redirect_to user_offers_url, notice: 'Offer was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @offer.destroy!

    respond_to do |format|
      format.html { redirect_to offers_url, notice: 'Offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_offer
    @offer = Offer.find_by(id: params[:id], user: current_user)
  end

  def offer_params
    params.require(:offer).permit(:amount, :unit_price, :state)
  end
end
