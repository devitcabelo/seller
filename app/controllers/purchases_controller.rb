class PurchasesController < ApplicationController
  respond_to :json

  def create
    purchase = Purchase.new(purchase_params)
    purchase.user = current_user
    product = purchase.product
    if product.can_be_purchased? purchase.quantity
      purchase.value = purchase.quantity * product.price
      if purchase.save
        render json: purchase.to_json
      else   
        render json: { error: 'Failed to create purchase!' }, status: :unprocessable_entity   
      end
    else
      render json: { error: 'insufficient stock' }, status: :unprocessable_entity   
    end
  end

  def update
    purchase = Purchase.find(params[:id])
    product = purchase.product
    new_quantity = purchase.quantity - purchase.quantity_was
    if product.can_be_purchased? new_quantity
      if purchase.update(purchase_params)
        render json: purchase.to_json
      else   
        render json: { error: 'Failed to edit purchase!' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Insufficient stock!' }, status: :unprocessable_entity   
    end
  end

  def show
    purchase = Purchase.find(params[:id])
    render json: purchase.to_json
  end

  def destroy
    purchase = Purchase.find(params[:id])
    if purchase.destroy
      render json: { message: 'Purchase deleted successfully' }
    else
      render json: { error: 'Failed to destroy purchase!' }, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.require(:purchase).permit(:product_id, :quantity)
  end
end