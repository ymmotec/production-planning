class StockFilesController < ApplicationController
  def index
    @stock_files = StockFile.all
  end

  def new
    @stock_file = StockFile.new
  end

  def create
    @stock_file = StockFile.new(stock_files_params)
    if @stock_file.save
      if import_stock(@stock_file)
        flash[:notice] = "Wczytano stan magazynu"
        redirect_to stock_files_path
      end
    end
  end

  def import_stock(stock_file_object_to_import)
    require 'csv'
    begin
      CSV.foreach("#{Rails.root}/public#{stock_file_object_to_import.file.to_s}", :encoding =>  'windows-1250:utf-8', :headers => true, :col_sep => ';') do |row|
        s = Stock.new
        s.product = Product.where(customer_id_number: row['Art.'].to_i ).first
        s.quantity_in_stock = row['Suma']
        s.stock_file_id = stock_file_object_to_import.id
        s.save
      end
    rescue
      return false
    else
      return true
    end
  end

  def stock_files_params
    params.require(:stock_file).permit(:file, :stock_date)
  end


end
