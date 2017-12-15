class OpenOrder < ApplicationRecord
    belongs_to :open_order_file
    has_many :open_order_details
    has_many :products, through: :open_order_details
end
