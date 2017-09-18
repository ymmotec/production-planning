class Machine < ApplicationRecord
    has_many :operations
    has_many :elements, through: :operations
end
