class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(12).padding(4)
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    search_keywords = "%#{params[:keywords]}%"
    @search_results = Product.where('name LIKE ?', search_keywords).or(Product.where('description LIKE ?', search_keywords))
    @paginated_search_results = @search_results.page.per(12).padding(4)
  end
end
