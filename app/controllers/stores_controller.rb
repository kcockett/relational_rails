class StoresController < ApplicationController
  def index
    @stores = Store.all
  end
  def show
    @store = Store.find(params[:store_id])
    @vehicle_count = Vehicle.where(store_id: @store.id).count
  end

  def show_vehicles
    @store = Store.find(params[:location_id])
    if params[:sort] == 'alphabetical'
      @vehicles = Vehicle.where(store_id: @store.id).order(:make)
    else
      @vehicles = Vehicle.where(store_id: @store.id)
    end
  end

  def new
  end

  def create
    store = Store.new({
      store_name: params[:store][:store_name],
      address1: params[:store][:address1],
      address2: params[:store][:address2],
      city: params[:store][:city],
      state: params[:store][:state],
      zip_code: params[:store][:zip_code],
      currently_hiring: params[:store][:currently_hiring],
      manager_name: params[:store][:manager_name]
      })
      store.save
      redirect_to "/stores/"
  end

  def edit
    @store = Store.find(params[:store_id])
  end

  def update
    store = Store.find(params[:store_id])
    store.update({
      store_name: params[:store][:store_name],
      address1: params[:store][:address1],
      address2: params[:store][:address2],
      city: params[:store][:city],
      state: params[:store][:state],
      zip_code: params[:store][:zip_code],
      currently_hiring: params[:store][:currently_hiring],
      manager_name: params[:store][:manager_name]
      })
    store.save
    redirect_to "/stores/#{store.id}"
  end

  def edit_vehicle
    @store = Store.find(params[:location_id])
  end

  def add_vehicle
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