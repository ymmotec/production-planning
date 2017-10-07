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
        @order_file.remove_file!
        # @order_file.destroy
        redirect_to order_files_path
      else
        @order_file.remove_file!
        @order_file.save
        @order_file.destroy
        flash[:error] = "Nie udało się wczytać zamówienia: #{ @error_message }"
        render action: 'new'
      end
    end
  end

  def import_orders(order_file_object_to_import)
    require 'csv'
    begin
      data_to_import = CSV.read("#{Rails.root}/public#{order_file_object_to_import.file.to_s}", :encoding =>  'windows-1250:utf-8', :headers => true, :col_sep => ';')
      
      required_headers = ['Order', 'Art No', 'Rcv', 'Cty', 'Orig Week', 'Orig Qty', 'Orig Date', 'IKEA Desc']
      
      file_check = CSVImportFileService.new(required_headers, data_to_import.headers)

      if file_check.contains_required_headers
        
        data_to_import.each do |row|
          
          o = Order.where(order: row['Order']).first
          if o.nil?
            o = Order.new(order: row['Order'], order_file_id: order_file_object_to_import.id)
            o.save
          end
          
          product = Product.where(customer_id_number: row['Art No']).first
          if product.nil?
            product = Product.new(customer_id_number: row['Art No'], name: row['IKEA Desc'])
            product.save
          end

          order_details = OrderDetail.new()
          order_details.order = o
          order_details.product = product
          order_details.rcv = row['Rcv']
          order_details.cty = row['Cty']
          order_details.orig_week = row['Orig Week']
          order_details.orig_qty = row['Orig Qty']
          order_details.orig_date = row['Orig Date']
          order_details.save

        end

      else
        raise "Nie ma takiego nagłówka"
      end
    rescue Errno::EISDIR
      
      @error_message = "Nie wybrano pliku"
      # puts e.message
      return false
    rescue ActiveRecord::AssociationTypeMismatch => e
      @error_message = e.message
      return false
    rescue
      @error_message = file_check.error_message
      return false
    else
      return true
    end
  end

  def order_files_params
    params.require(:order_file).permit(:file, :order_date)
  end
end
