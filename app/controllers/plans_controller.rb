class PlansController < ApplicationController
  def index
    @plans = Plan.page(params[:page]).per(50)
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      flash[:notice] = "Dodano nowy plan produkcji"
      redirect_to plan_path(@plan.id)
    else
      render action: 'new'
    end
  end

  def show
    @plan = Plan.find(params[:id])
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update

  end

  def generate
    @plan = Plan.find(params[:id])
    if generate_production_plan(@plan)
      flash[:notice] = "Wygenerowano nowy plan produkcji"
      redirect_to plan_path(@plan.id)
    else
      flash[:error] = "Nie udało się wygenerować planu produkcji"
    end
  end

  def plan_params
    params.require(:plan).permit(:final_date)
  end

  def generate_production_plan(plan)
    result = PlanGenerator.new(plan).call
    return result
  end
end
