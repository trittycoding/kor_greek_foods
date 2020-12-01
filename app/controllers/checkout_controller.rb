class CheckoutController < ApplicationController
  def create
    # Establishes a connection with Stripe, redirects user to payment screen
  end

  def success
    # Payment accepted
  end

  def cancel
    # Payment did not go through
  end
end
