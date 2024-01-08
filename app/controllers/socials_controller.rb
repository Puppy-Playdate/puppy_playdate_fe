class SocialsController < ApplicationController
  def index
    #hit endpoint to see allllll socials
  end

  def new
    # require 'pry'; binding.pry
  end

  def create
    address_response = GoogleFacade.verify_address_and_create_social(params)
    require 'pry'; binding.pry
  end

  def guest_index
    render :index
  end
end