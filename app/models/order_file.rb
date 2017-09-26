class OrderFile < ApplicationRecord
    mount_uploader :file, OrderFileUploader
    has_many :orders
end
