class StockController < ApplicationController
  
  def index
    @stock = Stock.all
  end
  def new
    @stock = Stock.new
  end

  def create
    @stock = Stock.new(stock_params)
    @stock.save
  end

  def stock_params
    params.require(:stock).permit(:product_id, :quantity_in_stock)
  end
end
