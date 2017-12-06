class MachinesController < ApplicationController
  def index
    @machines = Machine.all
  end

  def new
    @machine = Machine.new
  end

  def create
    @machine = Machine.new(machine_params)
    if @machine.save
      flash[:notice] = "Dodano nową maszynę"
      redirect_to machines_path
    else
      render action: 'new'
    end
  end

  def edit
    @machine = Machine.find(params[:id])
  end

  def update
    @machine = Machine.find(params[:id])
    if @machine.update_attributes(machine_params)
      flash[:notice] = "Maszyna pomyślnie zaktualizowana"
      redirect_to machines_path
    else
      render action: 'edit'
    end
  end

  def show
    @machine = Machine.find(params[:id])
    @spis = Spi.where(spi_file_id: SpiFile.last).all
    # @spis = Spi.where(spi_file_id: 27).all
    @current_week_num = Time.now.year.to_s + Time.now.strftime('%W').to_s
    @order_details = OrderDetail.all
  end

  def machine_params
    #TODO zmienić parametry permit
    params.require(:machine).permit(:name, :factory, :aditional_times, :down_times )    
  end
end
