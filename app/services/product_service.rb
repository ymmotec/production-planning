module ProductService

    def find_or_create_new_product(customer_id_number:, name:)
        product = Product.where(customer_id_number: customer_id_number).first
        product ||= create_new_product(customer_id_number: customer_id_number, product_name: name)
        product
    end

    def create_new_product(product_name:, customer_id_number:)
        
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