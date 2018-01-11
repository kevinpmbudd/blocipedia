class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Premium Membership - #{current_user.username}",
      amount: Amount.default
    }
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "Blocipedia Premium Membership - #{current_user.username}",
      currency: 'usd'
    )

    current_user.premium!
    flash[:notice] = "Thank you #{current_user.username} for upgrading to Blocipedia Premium!"
    redirect_to wikis_path

    rescue  Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to charges_new_path
  end
end

class Amount
  def self.default
    15_00
  end
end
