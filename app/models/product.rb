class Product < ApplicationRecord
    validates :name, presence: true
    validates :internal_id_number, presence: true

    has_many :elements
    has_many :stocks
    has_many :com40s
    has_many :order_details
    has_many :open_order_details
    has_many :spis
    has_many :spi_infos

    belongs_to :product_family
    
end
