class OpenOrderFile < ApplicationRecord
    mount_uploader :file, OpenOrderFileUploader
    has_many :open_orders
    has_many :open_order_details, through: :open_orders
    has_many :products, through: :open_order_details
end
