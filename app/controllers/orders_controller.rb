class OrdersController < ApplicationController
  def user_orders
    @orders = Order.where(user_id: current_user.id)
  end
end
