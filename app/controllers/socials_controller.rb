class SocialsController < ApplicationController
  def index
    #hit endpoint to see allllll socials
  end

  def new
    # require 'pry'; binding.pry
  end

  def create
    response = GoogleFacade.verify_address_and_create_social(params)
    # require 'pry'; binding.pry
    if response[:status] == 201
      flash[:success] = "Social Created"
      redirect_to user_social_path(current_user, response[:social_id])
    else
      flash[:error] = response[:error]
      redirect_back(fallback_location: new_user_social_path(current_user))
    end
  end
  
  def show
    require 'pry'; binding.pry
    @social = SocialsFacade.find_social(params[:id])
  end

  def guest_index
    render :index
  end
end