class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.all
  end
  def show
    @vehicle = Vehicle.find(params[:vehicle_id])
  end
end