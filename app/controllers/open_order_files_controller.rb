class OpenOrderFilesController < ApplicationController
  def index
    @open_order_files = OpenOrderFile.all
  end

  def show
    @open_order_file = OpenOrderFile.find(params[:id])
  end
  
  def new
    @open_order_file = OpenOrderFile.new
  end

  def create
    @open_order_file = OpenOrderFile.new(open_order_files_params)
    if @open_order_file.save

      if import_orders(@open_order_file)
        flash[:notice] = "Wczytano nowe zamówienia"
        @open_order_file.remove_file!
        # @open_order_file.destroy
        redirect_to open_order_files_path #TODO zmień przekierowanie

      else
        @open_order_file.remove_file!
        @open_order_file.save
        @open_order_file.destroy
        flash[:error] = "Nie udało się wczytać zamówienia: #{ @error_message }"
        render action: 'new'
      end
    end
  end

  def import_orders(order_file_object_to_import)
    
     result = ImportOpenOrders.new(order_file_object_to_import).call
     return result
 
     rescue Errno::EISDIR
       didnt_chose_the_file
       return false
     rescue ImportOrder::DoesNotContainRequiredHeaders
       does_not_contain_required_headers
       result = false
     rescue ActiveRecord::AssociationTypeMismatch => e
       @error_message = e.message
       return false
     rescue => e
       @error_message = e.message
       return false
 
   end
 
   def didnt_chose_the_file
     @error_message = "Nie wybrano pliku!"
   end
 
   def does_not_contain_required_headers
     @error_message = "Plik nie zawiera potrzebnych nagłówków!"
   end

  def open_order_files_params
    params.require(:open_order_file).permit(:file, :open_orders_date)
  end
end
