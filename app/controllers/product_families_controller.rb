class ProductFamiliesController < ApplicationController
  def index
    @product_families = ProductFamily.all
  end

  def new
    @product_family = ProductFamily.new
  end

  def create
    @product_family = ProductFamily.new(product_family_params)
    if @product_family.save
      flash[:notice] = "Dodano nową rodzinę produktów"
      redirect_to product_families_path
    else
      render action: 'new'
    end
  end

  def show
    @product_family = ProductFamily.find(params[:id])
  end

  def edit
    @product_family = ProductFamily.find(params[:id])
  end

  def destroy
    @product_family = ProductFamily.find(params[:id])
    @product_family.destroy
    flash[:notice] = "Pomyślnie usunięto nazwę rodziny produktów"
    redirect_to product_families_path
  end
  def product_family_params
    params.require(:product_family).permit(:name)
  end
end
