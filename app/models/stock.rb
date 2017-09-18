class Stock < ApplicationRecord
    belongs_to :stock_file
    belongs_to :product
end
