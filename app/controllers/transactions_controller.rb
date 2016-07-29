class TransactionsController < ApplicationController
  include ReservationsHelper
  def new
  	gon.client_token = generate_client_token
  end

  def create
    @reservations = Reservation.where(user_id: current_user.id, payment: false)
  	@result = Braintree::Transaction.sale(
              amount: cart_total_price(@reservations),
              payment_method_nonce: params[:payment_method_nonce])
    if @result.success?
      @reservations.each { |r| r.update_attributes(payment: true, transaction_id: @result.transaction.id) }
       flash[:success] = "Congraulations! Your transaction has been successfully!"
       redirect_to root_url
    else
      flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
      gon.client_token = generate_client_token
      render :new
    end
  end

  private
  	def generate_client_token
  		Braintree::ClientToken.generate
  	end
end
