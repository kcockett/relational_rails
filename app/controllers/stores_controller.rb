class StoresController < ApplicationController
  def index
    @stores = Store.all
  end
  def show
    @store = Store.find(params[:store_id])
    @vehicle_count = Vehicle.where(store_id: @store.id).count
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

  def destroy
    @store = Store.find(params[:id])
    @store.destroy
    redirect_to "/stores", notice: "Store was successfully deleted."
  end
end