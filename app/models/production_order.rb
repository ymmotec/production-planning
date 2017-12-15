class ProductionOrder < ApplicationRecord
    belongs_to :plan
    belongs_to :product
end
