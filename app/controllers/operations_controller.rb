class OperationsController < ApplicationController
  include ApplicationHelper
  # def new
  #   @operation = Operation.new
  # end

  def create
    @operation = Operation.new(operation_params)
    # @operation.cycle_time = calculate_cycle_time(@operation.efficiency_per_shift)
    if @operation.save
      flash[:notice] = "Dodano nową operację"
      redirect_to element_path(@operation.element_id)
    end
  end


  def edit
    @operation = Operation.find(params[:id])
    @element = @operation.element
  end

  def update
    @operation = Operation.find(params[:id])
    if @operation.update_attributes(operation_params)
      flash[:notice] = "Dane operacji zostały zaktualizowane."
      redirect_to element_path(@operation.element_id)
    end
  end

  def show
    @operation = Operation.find(params[:id])
  end

  def operation_params
    params.require(:operation).permit( :name, :description, :machine_id, :efficiency_per_shift, :cycle_time, :element_id )
  end
end
