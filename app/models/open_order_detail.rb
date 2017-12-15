class OpenOrderDetail < ApplicationRecord
    belongs_to :open_order
    belongs_to :product
    has_one :open_order_file, through: :open_order
end
