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
        redirect_to orders_path
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
            o = create_new_order(row['Order'], order_file_object_to_import.id)
          end
          
          product = Product.where(customer_id_number: row['Art No']).first
          if product.nil?
            product = create_new_product(row['IKEA Desc'], row['Art No'])
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
    rescue => e
      # @error_message = file_check.error_message + e.message
      @error_message = e.message
      @error_message += e.backtrace.join("\n")
      return false
    else
      return true
    end
  end

  def create_new_order(order_number, order_file_id)
    o = Order.new
    o.order = order_number
    o.order_file_id = order_file_id
    o.save
    return o
  end
  def create_new_product(product_name, customer_id_number)
    
    product_family = ProductFamily.where(name: product_name.split.first.upcase ).first
    if product_family.nil?
      product_family = create_new_product_family(product_name.split.first.upcase)
    end

    product = Product.new
    product.customer_id_number = customer_id_number
    product.name = product_name 
    product.internal_id_number = "Brak"
    product.product_family = product_family
    product.save
    return product
  end

  def create_new_product_family(product_family_name)
    product_family = ProductFamily.new
    product_family.name = product_family_name
    product_family.save
  end

  def order_files_params
    params.require(:order_file).permit(:file, :order_date)
  end
end
