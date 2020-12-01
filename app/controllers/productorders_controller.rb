class ProductordersController < ApplicationController
  def order_details
    found_order = Order.find(params[:order_id])
    @productorders = Productorder.where(order_id: found_order)
  end
end
