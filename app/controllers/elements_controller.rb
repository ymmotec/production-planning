class ElementsController < ApplicationController
  def index
  end

  def show
    @element = Element.find(params[:id])
  end

  def create
    @element = Element.new(element_params)
    if @element.save
      flash[:notice] = "Dodano nowy element"
      redirect_to product_path(@element.product_id)
    end
  end

  def edit
    @element = Element.find(params[:id])
    @product = Product.find(@element.product_id)
  end

  def update
    @element = Element.find(params[:id])
    if @element.update_attributes(element_params)
      flash[:notice] = "Element został pomyślnie zaktualizowany."
      redirect_to product_path(@element.product_id)
    else
      render action 'edit'
    end
  end

  def destroy
    @element = Element.find(params[:id])
    @element.destroy
    flash[:notice] = "Pomyślnie usunięto element."
    redirect_to product_path(@element.product_id)
  end

  def add_operation
    @element = Element.find(params[:id])
    @operation = @element.operations.new
  end

  def element_params
    params.require(:element).permit( :name, :internal_id_number, :quantity_per_set, :product_id )
  end
end
