class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.where(repairs_needed: true)
  end
  def show
    @vehicle = Vehicle.find(params[:vehicle_id])
  end
  def edit
    @vehicle = Vehicle.find(params[:vehicle_id])
  end
  def update
    vehicle = Vehicle.find(params[:vehicle_id])
    vehicle.update({
      model_year: params[:vehicle][:model_year],
      make: params[:vehicle][:make],
      model: params[:vehicle][:model],
      mileage: params[:vehicle][:mileage],
      repairs_needed: params[:vehicle][:repairs_needed],
      seating: params[:vehicle][:seating],
      last_service_date: params[:vehicle][:last_service_date],
      engine_hours: params[:vehicle][:engine_hours]
      })
    vehicle.save
    redirect_to "/vehicles/#{vehicle.id}"
  end
end