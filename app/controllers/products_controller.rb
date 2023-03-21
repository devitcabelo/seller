class ProductsController < ApplicationController
  respond_to :json

  def create
    product = Product.new(product_params)   
    if product.save   
      render json: product.to_json
    else   
      render json: { error: 'Failed to edit product!' }, status: :unprocessable_entity   
    end
  end

  def update
    product = Product.find(params[:id])
    if product.update(product_params)
      render json: product.to_json
    else   
      render json: { error: 'Failed to edit product!' }, status: :unprocessable_entity
    end
  end

  def show
    product = Product.find(params[:id])
    render json: product.to_json
  end

  def destroy
    product = Product.find(params[:id])
    if product.destroy
      render json: { message: 'Product deleted successfully' }
    else   
      render json: { error: 'Failed to destroy product!' }, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :quantity, :price)
  end
end