class Order < ApplicationRecord
    belongs_to :order_file
    has_many :order_details
end
