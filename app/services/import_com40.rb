require 'csv'

class ImportCom40
    include AppService

    def initialize(stock_file_object_to_import)
        @file_object = stock_file_object_to_import
        @data_to_import = CSV.read("#{Rails.root}/public#{@file_object.file.to_s}", :encoding =>  'windows-1250:utf-8', :headers => true, :col_sep => ';')
        @required_headers = ['Art_No', 'Available_stock_in_qty']
    end

    def call
        if is_valid?
            @data_to_import.each do |row|
                s = Com40.new
                s.product = Product.where(customer_id_number: row['Art_No'].to_i ).first
                s.quantity_in_stock = row['Available_stock_in_qty']
                s.com40_file_id = @file_object.id
                s.save
            end
        end
    end

    private
    
    def is_valid?
        contains_required_headers?(@required_headers, @data_to_import.headers)
    end
end