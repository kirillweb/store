class OrderItemsController < ApplicationController
  def index
    @items = current_order.order_items
  end

  def create
    current_order.order_items.create!(order_item_params)
    flash[:success] = t('add_to_cart')
    redirect_to :back
  end

  def update
    current_order.order_items.find(params[:id]).update_attributes(order_item_params)
    redirect_to :back
  end

  def destroy
    if params[:id] == "all"
      current_order.order_items.delete(:all)
      redirect_to :back
    else
      current_order.order_items.delete(params[:id])
      redirect_to :back
    end
  end

  private

    def order_item_params
      params.require(:order_item).permit(:quantity, :book_id)
    end
end
