class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    selected_category = Category.find(params[:id])
    @products = Product.where(category_id: selected_category).page(params[:page]).per(12).padding(3)
  end
end
