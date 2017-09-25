class StockFile < ApplicationRecord
    mount_uploader :file, StockFileUploader
    has_many :stocks
end
