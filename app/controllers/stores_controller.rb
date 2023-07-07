class StoresController < ApplicationController
  def index
    @stores = Store.all
  end
  def show
    @store = Store.find(params[:store_id])
  end
  def show_vehicles
    @store = Store.find(params[:location_id])
    @vehicles = Vehicle.where(store_id: @store.id)
  end
end