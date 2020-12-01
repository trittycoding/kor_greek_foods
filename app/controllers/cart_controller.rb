class CartController < ApplicationController
  # Modelled after the 7 RESTful routes

  # Adds item to cart through params[:id] through POST
  def create
    logger.debug("Product ID:#{params[:id]} added to the cart")
    # Turning product ID into integer, push id to cart array
    id = params[:id].to_i
    quantity = params['quantity'].to_i
    session[:user_cart] << id
    item_quantity_hash[id] = quantity
    flash[:products_added] = 'Item(s) added to cart'
    redirect_to root_path
  end

  # Removes item from cart through params[:id], /cart/:id through DELETE
  def destroy
    id = params[:id].to_i
    session[:user_cart].delete(id)
    # Need to pass quantity of items removed here to remove from hash---
    session[:item_quantity].delete(id.to_s)
    flash[:product_removed] = 'Item(s) removed from cart'
    redirect_to root_path
  end

  def show
    @cart_items = cart
  end

  def adjust_quantity
    quantity = params[:quantity].to_i
    id_number = params[:id].to_s
    adjust_item_quantity(id_number, quantity)
    flash[:quantity_adjusted] = 'Quantities adjusted for items'
    redirect_to root_path
  end
end
