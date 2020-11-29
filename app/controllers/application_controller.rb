class ApplicationController < ActionController::Base
  before_action :initialize_session
  # We can turn anything into a helper method in the
  # application controller using -> helper_method :method_name
  # This will be available to any view when declared this way
  helper_method :cart

  private

  # Initializes the shopping cart for session
  def initialize_session
    # When setting a value, using ||= sets the default value
    # EX:// cart ||= 0 will initialize the variable and default to zero
    #     if no value exists for cart
    session[:user_cart] ||= []
  end

  # Returns a collection of Products based on the IDs in the user's cart
  def cart
    Product.find(session[:user_cart])
  end
end
