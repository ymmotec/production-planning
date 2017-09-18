class StockFile < ApplicationRecord
    mount_uploader :file, StockUploader
    has_many :stocks
end
