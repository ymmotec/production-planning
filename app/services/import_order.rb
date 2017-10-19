require 'csv'

class ImportOrder
    class DoesNotContainRequiredHeaders < StandardError; end
    include AppService
    

    def initialize(order_file_object_to_import)
        @order_file_object = order_file_object_to_import
        @data_to_import = CSV.read("#{Rails.root}/public#{order_file_object_to_import.file.to_s}", :encoding =>  'windows-1250:utf-8', :headers => true, :col_sep => ';')
        @required_headers = ['Order', 'Art No', 'Rcv', 'Cty', 'Orig Week', 'Orig Qty', 'Orig Date', 'IKEA Desc']
    end

    def call
        if is_valid?
            @data_to_import.each do |row|
                o = Order.where(order: row['Order']).first
                o ||= create_new_order(row['Order'], @order_file_object.id)
                
                product = find_or_create_new_product(customer_id_number: row['Art No'], name: row['IKEA Desc'])
      
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
            return true
        end
    end

    private

    def is_valid?
        if contains_required_headers?(@required_headers, @data_to_import.headers)
            return true
        end
        raise DoesNotContainRequiredHeaders
        
    end

    def create_new_order(order_number, order_file_id)
        o = Order.new
        o.order = order_number
        o.order_file_id = order_file_id
        o.save
        return o
      end

    def find_or_create_new_product(customer_id_number:, name:)
        product = Product.where(customer_id_number: customer_id_number).first
        product ||= create_new_product(row['IKEA Desc'], row['Art No'])
        product
    end

    def create_new_product(product_name, customer_id_number)
        
        product_family = ProductFamily.where(name: product_name.split.first.upcase ).first
        product_family ||= create_new_product_family(product_name.split.first.upcase)
    
        product = Product.new
        product.customer_id_number = customer_id_number
        product.name = product_name 
        product.internal_id_number = "Brak"
        product.product_family = product_family
        product.save
        product
    end

    def create_new_product_family(product_family_name)
        product_family = ProductFamily.new
        product_family.name = product_family_name
        product_family.save
    end

end