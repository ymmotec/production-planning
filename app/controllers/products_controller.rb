class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy ]
  
  def index
    @products = Product.page(params[:page]).per(50)
  end

  def only_new
    @products = Product.where(
      internal_id_number: "Brak").page(params[:page]).per(50)
    render action: "index"
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "Dodano nowy produkt"
      redirect_to products_path
    else
      render action: 'new'
    end

  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:notice] = "Produkt pomyślnie zaktualizowany."
      redirect_to products_path
    else
      render action: 'edit'
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_element
    @product = Product.find(params[:id])
    @element = @product.elements.new
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = "Pomyślnie usunięto produkt"
    redirect_to products_path
  end

  def product_params
    params.require(:product).permit(:name, 
      :customer_id_number, 
      :internal_id_number, :color, 
      :quantity_on_palet, 
      :product_family_id, 
      :page, :min_production, 
      :max_production, :min_stock, 
      :max_stock, 
      :lack_group, 
      :size, 
      :palet_size, 
      :status, 
      :max_orders_per_week, 
      :lead_time, 
      :average_spi, 
      :average_sale, 
      :average_order_qty )
  end
  

end
