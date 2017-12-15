class StockFile < ApplicationRecord
    mount_uploader :file, StockFileUploader
    has_many :stocks
    has_many :products, through: :stocks
end
