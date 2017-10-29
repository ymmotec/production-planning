require 'csv'

class ImportOpenOrders
    include AppService
    include ProductService

    def initialize(order_file_object_to_import)
        @order_file_object = order_file_object_to_import
        @data_to_import = CSV.read("#{Rails.root}/public#{order_file_object_to_import.file.to_s}", :encoding =>  'windows-1250:utf-8', :headers => true, :col_sep => ';')
        @required_headers = ['Order', 'Art No', 'Rcv', 'Cty', 'Orig Week', 'Orig Qty', 'Orig Date', 'IKEA Desc', 'SL', 'Type', 'Bal Qty', 'Bkd Qty']
    end

    def call
        if is_valid?
            import_open_orders
        end
        return true
    end

    private

    def import_open_orders
        licznik = 0
        @data_to_import.each do |row|
            open_order = OpenOrder.where(order: row['Order']).where(open_order_file_id: @order_file_object.id).first
            open_order ||= create_new_order(row['Order'], @order_file_object.id)
            
            product = find_or_create_new_product(customer_id_number: row['Art No'], name: row['IKEA Desc'])
  
            open_order_detail = OpenOrderDetail.new
            open_order_detail.open_order = open_order
            open_order_detail.product = product
            open_order_detail.rcv = row['Rcv']
            open_order_detail.cty = row['Cty']
            open_order_detail.orig_week = row['Orig Week']
            open_order_detail.orig_qty = row['Orig Qty']
            open_order_detail.orig_date = row['Orig Date']
            open_order_detail.bal_qty = row['Bal Qty']
            open_order_detail.sl = row['SL']
            open_order_detail.mtype = row['Type']
            open_order_detail.bkd_qty = row['Bkd Qty']
            open_order_detail.save
            licznik += 1
        end
    end

    def create_new_order(order_number, order_file_id)
        o = OpenOrder.new
        o.order = order_number
        o.open_order_file_id = order_file_id
        o.save
        return o
    end

    # def find_or_create_new_product(customer_id_number:, name:)
    #     product = Product.where(customer_id_number: customer_id_number).first
    #     product ||= create_new_product(customer_id_number: customer_id_number, product_name: name)
    #     product
    # end

    # def create_new_product(product_name:, customer_id_number:)
        
    #     product_family = ProductFamily.where(name: product_name.split.first.upcase ).first
    #     product_family ||= create_new_product_family(product_name.split.first.upcase)
    
    #     product = Product.new
    #     product.customer_id_number = customer_id_number
    #     product.name = product_name 
    #     product.internal_id_number = "Brak"
    #     product.product_family = product_family
    #     product.save
    #     product
    # end

    # def create_new_product_family(product_family_name)
    #     product_family = ProductFamily.new
    #     product_family.name = product_family_name
    #     product_family.save
    # end
    
    def is_valid?
        contains_required_headers?(@required_headers, @data_to_import.headers)
    end

end