class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.all
  end
  # def show
  #   @store = Store.find(params[:store_id])
  # end
end