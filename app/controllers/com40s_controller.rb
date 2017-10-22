class Com40sController < ApplicationController
  def index
    @com40_stocks = Com40.all
  end

  def new
  end

  def show
  end
end
