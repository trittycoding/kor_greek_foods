class CheckoutController < ApplicationController
  def create
    province_gst = gst_get
    province_hst = hst_get
    province_pst = pst_get

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
    @total = 0
    valid_products = []
    session[:user_cart].each do |valid_item|
      valid_product = Product.find_by(id: valid_item)
      valid_product_quantity = session[:item_quantity][valid_item.to_s]
      valid_product_cost = valid_product.price
      @total += valid_product_cost
      valid_products <<
        {
          name: valid_product.name,
          description: valid_product.description,
          amount: (valid_product_cost * 100).to_i,
          currency: 'cad',
          quantity: valid_product_quantity
        }
    end

    # Calculating tax
    unless province_hst.nil?
      @hst_tax = @total * province_hst
      @total += @hst_tax
      valid_products <<
        {
          name: 'HST',
          description: 'Harmonized Sales Tax',
          amount: (@hst_tax * 100).to_i,
          currency: 'cad',
          quantity: 1
        }
    end

    unless province_gst.nil?
      @gst_tax = @total * province_gst
      @total += @gst_tax
      valid_products <<
        {
          name: 'GST',
          description: 'General Sales Tax',
          amount: (@gst_tax * 100).to_i,
          currency: 'cad',
          quantity: 1
        }
    end

    unless province_pst.nil?
      @pst_tax = @total * province_pst
      @total += @pst_tax
      valid_products <<
        {
          name: 'PST',
          description: 'Provincial Sales Tax',
          amount: (@pst_tax * 100).to_i,
          currency: 'cad',
          quantity: 1
        }
    end

    # Establishing a connection with Stripe
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
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    paid = @session[:payment_status] == 'paid'
    stripe_identifier = @session[:id]
    # logger.debug(@session.inspect)
    logger.debug(@payment_intent.inspect)
    logger.debug(paid.inspect)
    total = @session[:amount_total]
    converted_total = (total.to_d / 100).round(2)
    subtotal = converted_total - (converted_total * taxrate_get)
    paid_order = Order.create(total: converted_total, subtotal: subtotal, user_id: current_user.id,
                              gst: gst_get, hst: hst_get, pst: pst_get, taxrate: taxrate_get,
                              paid: paid, stripe_identifier: stripe_identifier)

    session[:user_cart].each do |x|
      product = Product.find(x)
      quantity_for_item = session[:item_quantity][x.to_s]
      Productorder.create(order_id: paid_order.id, product_id: product.id,
                          unitcost: product.price, quantity: quantity_for_item)
    end

    logger.debug(paid_order.inspect)
    logger.debug(paid_order.errors.messages)
    console

    session[:user_cart] = []
    session[:item_quantity] = {}
  end

  def cancel
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    paid = @session[:payment_status] == 'paid'
    stripe_identifier = @session[:id]
    # logger.debug(@session.inspect)
    logger.debug(@payment_intent.inspect)
    logger.debug(paid.inspect)
    total = @session[:amount_total]
    converted_total = total.to_d / 100
    subtotal = converted_total - (converted_total * taxrate_get)

    Order.create(total: converted_total, user_id: current_user.id,
                 gst: gst_get, hst: hst_get, pst: pst_get, taxrate: taxrate_get,
                 paid: false, stripe_identifier: stripe_identifier)
    session[:user_cart] = []
    session[:item_quantity] = {}
  end

  def pst_get
    user_province = Province.find_by(id: current_user.province_id)
    user_province.pst
  end

  def hst_get
    user_province = Province.find_by(id: current_user.province_id)
    user_province.hst
  end

  def gst_get
    user_province = Province.find_by(id: current_user.province_id)
    user_province.gst
  end

  def taxrate_get
    user_province = Province.find_by(id: current_user.province_id)
    user_province.taxrate
  end

  def total_get; end
end
