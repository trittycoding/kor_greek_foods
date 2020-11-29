class CartController < ApplicationController
  # Modelled after the 7 RESTful routes

  # Adds item to cart through params[:id] through POST
  def create
    logger.debug("Product ID:#{params[:id]} added to the cart")
    # Turning product ID into integer, push id to cart array
    id = params[:id].to_i
    quantity = params['quantity'].to_i
    quantity.times do
      session[:user_cart] << id
    end
    flash[:products_added] = 'Item(s) added to cart'
    redirect_to root_path
  end

  # Removes item from cart through params[:id], /cart/:id through DELETE
  def destroy; end
end
