class CheckoutController < ApplicationController
  def create
    user_province = Province.find_by(province_id: current_user.province_id)
    province_gst = user_province.gst
    province_hst = user_province.hst
    province_pst = user_province.province_pst
    province_taxrate = user_province.taxrate

    # Validations for cart items
    session[:user_cart].each do |item|
      product = Product.find(item.to_i)
      product_quantity = (session[:item_quantity][item.to_s])

      # If the data is invalid do not call the Stripe API
      if product.nil? || product_quantity.nil?
        redirect_to root_path
        return
      end
    end

    # Purchasing valid items
    valid_products = []
    total = 0
    session[:user_cart].each do |valid_item|
      valid_product = Product.find(valid_item.to_i)
      valid_product_quantity = session[:item_quantity][valid_item.to_s]
      valid_product_cost = (valid_product.price * 100).to_i
      total += valid_product_cost
      valid_products <<
        {
          name: valid_product.name,
          description: valid_product.description,
          amount: valid_product_cost,
          currency: 'cad',
          quantity: valid_product_quantity
        }
    end

    # Calculating tax
    unless province_hst.nil?
      hst_tax = total * (province_hst * 100).to_i
      valid_products <<
        {
          name: 'HST',
          description: 'Harmonized Sales Tax',
          amount: hst_tax,
          currency: 'cad',
          quantity: 1
        }
    end

    unless province_gst.nil?
      gst_tax = total * (province_gst * 100).to_i
      valid_products <<
        {
          name: 'GST',
          description: 'General Sales Tax',
          amount: gst_tax,
          currency: 'cad',
          quantity: 1
        }
    end

    unless province.pst.nil?
      pst_tax = total * (province_pst * 100).to_i
      valid_products <<
        {
          name: 'PST',
          description: 'Provincial Sales Tax',
          amount: pst_tax,
          currency: 'cad',
          quantity: 1
        }
    end

    # Establishing a connection with Stripe
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url,
      line_items: valid_products
    )
    # Redirecting the user to a payment screen via JS view
    respond_to do |format|
      format.js # render app/views/checkout/create.js.erb
    end
  end

  def success
    # Payment accepted
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel
    # Payment did not go through
  end
end
