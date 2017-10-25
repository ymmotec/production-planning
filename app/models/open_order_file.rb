class OpenOrderFile < ApplicationRecord
    mount_uploader :file, OpenOrderFileUploader
    has_many :open_orders
end
