class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(12).padding(4)
  end

  def show
    @product = Product.find(params[:id])
  end
end
