class Element < ApplicationRecord
    belongs_to :product
    has_many :operations
    has_many :machines, through: :operations
end
