class Plan < ApplicationRecord
    has_many :production_orders
    has_many :products, :through => :production_orders
end
