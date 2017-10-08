class OrdersController < ApplicationController
  def index
    @order_details = OrderDetail.all
  end

  def order_params
    params.require(:order).permit(:order, :order_file_id)
  end
end
