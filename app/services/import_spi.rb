require 'csv'

class ImportSpi
    include AppService
    include ProductService

    def initialize(spi_file_object_to_import)
        @file_object = spi_file_object_to_import
        @data_to_import = CSV.read("#{Rails.root}/public#{@file_object.file.to_s}", :encoding =>  'windows-1250:utf-8', :headers => true, :col_sep => ';')
        @required_headers = ['Art No.', ['Art Name'], ['Art Status'],['Store Assets'], ['DC Stock'], ['Safety Stock'], ['in Transit'],['Open Orders'], ['Sales Forecast 52 weeks'], ['Supply Plan 52 weeks']]
    end

    def call
        if is_valid?
            import_spi_info
            # import_spi_data
        end
        return true
    end

    private

    def is_valid?
        contains_required_headers?(@required_headers, @data_to_import.headers)
    end

    def import_spi_info
        @data_to_import.each do |row|
            product = find_or_create_new_product(customer_id_number: row['Art No.'], name: row['Art Name'])
            spi_info = SpiInfo.new
            spi_info.product = product
            spi_info.spi_file = @file_object
            spi_info.art_status = row['Art Status']
            spi_info.store_assets = row['Store Assets']
            spi_info.dc_stock = row['Dc Stock']
            spi_info.safety_stock = row['Safety Stock']
            spi_info.in_transit = row['in Transit']
            spi_info.open_orders = row['Open Orders']
            spi_info.sales_forecast = row['Sales Forecast 52 weeks']
            spi_info.supply_plan = row['Supply Plan 52 weeks']
            spi_info.save
        end
    end

    def import_spi_data

    end

end