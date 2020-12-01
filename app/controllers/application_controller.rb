class ApplicationController < ActionController::Base
  before_action :initialize_session
  # We can turn anything into a helper method in the
  # application controller using -> helper_method :method_name
  # This will be available to any view when declared this way
  helper_method :cart, :item_quantity_hash, :get_item_quantity, :invalid_user_address

  private

  # Initializes the shopping cart for session
  def initialize_session
    # When setting a value, using ||= sets the default value
    # EX:// cart ||= 0 will initialize the variable and default to zero
    #     if no value exists for cart
    session[:user_cart] ||= []
    session[:item_quantity] ||= {}
  end

  # Returns a collection of Products based on the IDs in the user's cart
  def cart
    Product.find(session[:user_cart])
  end

  def item_quantity_hash
    session[:item_quantity]
  end

  def get_item_quantity(id_number)
    session[:item_quantity][id_number]
  end

  def adjust_item_quantity(id_number, quantity)
    session[:item_quantity][id_number] = quantity
  end

  def invalid_user_address
    nil_check = current_user.name.nil? || current_user.address.nil? || current_user.province_id.nil?
    blank_check = current_user.name.blank? || current_user.address.blank? || current_user.province_id.blank?
    if nil_check || blank_check
      true
    else
      false
    end
  end
end
