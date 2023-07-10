class Stores::VehiclesController < ApplicationController
  def index
    @store = Store.find(params[:location_id])
    if params[:sort] == 'alphabetical'
      @vehicles = Vehicle.where(store_id: @store.id).order(:make)
    else
      @vehicles = Vehicle.where(store_id: @store.id)
    end
  end

  def edit
    @store = Store.find(params[:location_id])
  end

  def add
    store = Store.find(params[:location_id])
    vehicle = Vehicle.new({
      model_year: params[:vehicle][:model_year],
      make: params[:vehicle][:make],
      model: params[:vehicle][:model],
      mileage: params[:vehicle][:mileage],
      repairs_needed: params[:vehicle][:repairs_needed],
      store_id: params[:vehicle][:store_id],
      seating: params[:vehicle][:seating],
      last_service_date: params[:vehicle][:last_service_date],
      engine_hours: params[:vehicle][:engine_hours]
      })
      vehicle.save
      redirect_to "/stores/#{store.id}/vehicles"
  end
end