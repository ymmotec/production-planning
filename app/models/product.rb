class Product < ApplicationRecord
    validates :name, presence: true
    validates :internal_id_number, presence: true

    has_many :elements
    has_many :stocks
end
