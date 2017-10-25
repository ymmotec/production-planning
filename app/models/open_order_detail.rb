class OpenOrderDetail < ApplicationRecord
    belongs_to :open_order
    belongs_to :product
end
