class SocialsController < ApplicationController
  def index;end

  def new
    # require 'pry'; binding.pry
  end

  def create
    require 'pry'; binding.pry
    address = [params[:locality], params[:addressLines]]
    social = {name: params[:name], date: params[:date], time: [params["[time(4i)]"], params["[time(5i)]"]]}
    address_response = GoogleFacade.verify_address(address_object, social)
    require 'pry'; binding.pry
  end

  def guest_index
    render :index
  end
end