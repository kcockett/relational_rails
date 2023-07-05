class StoresController < ApplicationController
  def index
    @stores = ["Store 1", "Store 2", "Store 3"]
  end
end