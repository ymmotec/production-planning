class StockFilesController < ApplicationController
  def index
    @stock_files = StockFile.all
  end

  def new
    @stock_file = StockFile.new
  end

  def create
    @stock_file = StockFile.new(stock_files_params)
    if @stock_file.save
      if import_stock(@stock_file)
        flash[:notice] = "Wczytano stan magazynu"
        @stock_file.remove_file!
        redirect_to stock_files_path
      else
        @stock_file.remove_file!
        @stock_file.save
        @stock_file.destroy
        flash[:error] = "Nie udało się wczytać stanu magazynu: #{ @error_message }"
        render action: 'new'
      end
    end
  end

  def import_stock(stock_file_object_to_import)
    result = ImportStock.new(stock_file_object_to_import).call
    return result
  
    rescue Errno::EISDIR
      didnt_chose_the_file
      return false
    rescue AppService::DoesNotContainRequiredHeaders
      does_not_contain_required_headers
      return false
    rescue ActiveRecord::AssociationTypeMismatch => e
      @error_message = e.message
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

  def stock_files_params
    params.require(:stock_file).permit(:file, :stock_date)
  end


end
