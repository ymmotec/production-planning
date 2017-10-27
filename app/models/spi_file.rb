class SpiFile < ApplicationRecord
    mount_uploader :file, SpiUploader
    has_many :spis
    has_many :spi_infos
end
