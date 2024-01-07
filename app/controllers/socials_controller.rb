class SocialsController < ApplicationController
  def index;end

  def new
    # require 'pry'; binding.pry
  end

  def create
    # You have to send an address object as a post request to the Google Address Validator API
    require 'pry'; binding.pry
  end

  def guest_index
    render :index
  end
end