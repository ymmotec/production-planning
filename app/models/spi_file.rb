class SpiFile < ApplicationRecord
    mount_uploader :file, SpiUploader
end
