class Com40File < ApplicationRecord
    mount_uploader :file, Com40Uploader
    has_many :com40s
    has_many :products, through: :com40s
end
