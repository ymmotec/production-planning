class Com40FilesController < ApplicationController
  def new
    @com40_file = Com40File.new
  end

  def create
    @com40_file = Com40File.new(com40_files_params)
    if @com40_file.save
      if import_stock(@com40_file)
        flash[:notice] = "Wczytano stan magazynu Com40"
        @com40_file.remove_file!
        redirect_to com40s_path
      else
        @com40_file.remove_file!
        @com40_file.save
        @com40_file.destroy
        flash[:error] = "Nie udało się wczytać stnu magazynu Com40: #{@error_message}"
        render action: 'new'
      end
    end
  end

  def import_stock(stock_file_object_to_import)
    result = ImportCom40.new(stock_file_object_to_import).call
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

  def com40_files_params
    params.require(:com40_file).permit(:file, :stock_date)
  end
end
