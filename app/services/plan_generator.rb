class PlanGenerator
    def initialize(plan_to_generate)
        @plan = plan_to_generate
    end

    def call
        generate
    end

    private

    def generate
        products = Product.all

        products.each do |product|
            in_open_orders = calculate_open_orders(product)
            unless in_open_orders == 0
                in_stock = calculate_current_stock(product)
                in_com40 = calculate_com40_stock(product)
                bkd_qty = calculate_bkd_qty(product)
                in_production_process = calculate_in_production_qty(product)

                final_stock = in_stock + in_com40 - in_open_orders - bkd_qty + in_production_process
                qty_to_produce = calculate_production_order_qty(product, final_stock)

                if qty_to_produce > 0
                    production_order = ProductionOrder.new
                    production_order.plan = @plan
                    production_order.product = product
                    production_order.ordered_qty = qty_to_produce
                    production_order.status = "New"
                    production_order.save
                end
            end
        end
    end

    def calculate_current_stock(product)
        stock_file = StockFile.last
        in_stock = stock_file.stocks.where(product: product).sum(:quantity_in_stock)
    end

    def calculate_com40_stock(product)
        com40_file = Com40File.last
        in_com40 = com40_file.com40s.where(product: product).sum(:quantity_in_stock)
    end

    def calculate_open_orders(product)
        in_open_orders = OpenOrderFile.last.open_order_details.where(product: product).sum(:bal_qty)
    end

    def calculate_bkd_qty(product)
        bkd_qty = OpenOrderFile.last.open_order_details.where(product: product).sum(:bkd_qty)
    end

    def calculate_in_production_qty(product)
        # TODO obliczyć ilość towaru w otwartych zleceniach. lub go importować?
        0
    end

    def calculate_production_order_qty(product, final_stock)
        stock_shortage = product.max_stock - final_stock
        if stock_shortage > 0
            if stock_shortage > product.min_production && stock_shortage < product.max_production
                production_order_qty = stock_shortage
            elsif stock_shortage > product.max_production
                production_order_qty = product.max_production
            else
                production_order_qty = 0
            end
        else
            production_order_qty = 0
        end

        production_order_qty
    end

end