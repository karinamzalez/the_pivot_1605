class FarmersMarketsController < ApplicationController

  def index
    @farmers_market = FarmersMarket.all
  end

  def show
    # @farmersmarkets = Farmersmarkets.find(params[:id])
  end
end
