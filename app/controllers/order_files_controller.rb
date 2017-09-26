class OrderFilesController < ApplicationController
  def index
    @order_files = OrderFile.all
  end
  
  def new
    @order_file = OrderFile.new
  end

  def create
    @order_file = OrderFile.new(order_files_params)
    if @order_file.save
      if import_orders(@order_file)
        flash[:notice] = "Wczytano nowe zamówienia"
        redirect_to order_files_path
      else
        flash[:notice] = "Nie udało się wczytać zamówienia"
        render action: 'new'
      end
    end
  end

  def import_orders(order_file_object_to_import)
    require 'csv'
    begin
      CSV.foreach("#{Rails.root}/public#{order_file_object_to_import.file.to_s}", :encoding =>  'windows-1250:utf-8', :headers => true, :col_sep => ';') do |row|
        
      end
    rescue 
      return false
    else
      return true
    end
  end

  def order_files_params
    params.require(:order_file).permit(:file, :order_date)
  end
end
