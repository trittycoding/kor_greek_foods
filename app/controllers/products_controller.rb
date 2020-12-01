class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(12).padding(4)
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    search_keywords = "%#{params[:keywords]}%"
    if params[:category] == ''
      @search_results = Product.where('name LIKE ?', search_keywords).or(Product.where('description LIKE ?', search_keywords))
    else
      @search_results = Product.where('name LIKE ?', search_keywords).or(Product.where('description LIKE ?', search_keywords)).where(category_id: params[:category])
    end
  end
end
