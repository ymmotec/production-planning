class SpiFilesController < ApplicationController
  def index
    @spi_files = SpiFile.all
  end
  
  def new
    @spi_file = SpiFile.new
  end

  def create
    @spi_file  = SpiFile.new(spi_files_params)
    if @spi_file.save
      if import_spi(@spi_file)
        flash[:notice] = "Wczytano SPI"
        @spi_file.remove_file!
        redirect_to spi_files_path
      else
        @spi_file.remove_file!
        @spi_file.save
        @spi_file.destroy
        flash[:error] = "Nie udało się wczytać SPI: #{ @error_message }"
        render action: 'new'
      end
    end
  end


  def import_spi(spi_file_object_to_import)
    result = ImportSpi.new(spi_file_object_to_import).call
    return result
  
    rescue Errno::EISDIR
      didnt_chose_the_file
      return false
    rescue AppService::DoesNotContainRequiredHeaders
      does_not_contain_required_headers
      return false
    rescue ActiveRecord::AssociationTypeMismatch => e
      @error_message = e.message
      return false
    rescue => e
      @error_message = e.message
      return false
  end

  def didnt_chose_the_file
    @error_message = "Nie wybrano pliku"
  end

  def does_not_contain_required_headers
    @error_message = "Plik nie zawiera potrzebnych nagłówków"
  end
  

  def spi_files_params
    params.require(:spi_file).permit(:file, :spi_date)
  end
end
