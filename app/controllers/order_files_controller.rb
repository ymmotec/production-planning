class OrderFilesController < ApplicationController
  def index
    @order_files = OrderFile.all
  end
  
  def new
    @order_file = OrderFile.new
  end

  def show
    @order_file = OrderFile.find(params[:id])
  end

  def create
    @order_file = OrderFile.new(order_files_params)
    if @order_file.save

      if import_orders(@order_file)
        flash[:notice] = "Wczytano nowe zamówienia"
        @order_file.remove_file!
        # @order_file.destroy
        redirect_to order_file_path(@order_file)
      else
        @order_file.remove_file!
        @order_file.save
        @order_file.destroy
        flash[:error] = "Nie udało się wczytać zamówienia: #{ @error_message }"
        render action: 'new'
      end
    end
  end

  def import_orders(order_file_object_to_import)
   
    result = ImportOrder.new(order_file_object_to_import).call
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
  
  def order_files_params
    params.require(:order_file).permit(:file, :order_date)
  end
end
