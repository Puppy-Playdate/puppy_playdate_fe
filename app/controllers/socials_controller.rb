class SocialsController < ApplicationController
  def index
    #hit endpoint to see allllll socials
  end

  def new;end

  def create
    response = GoogleFacade.verify_address_and_create_social(params)
    if response[:status] == 201
      flash[:success] = "Social Created"
      redirect_to user_social_path(current_user, response[:social_id])
    else
      flash[:error] = response[:error]
      redirect_back(fallback_location: new_user_social_path(current_user))
    end
  end
  
  def show
    @social = SocialsFacade.find_social(params[:user_id], params[:id])
    @host = UsersFacade.find_user(params[:user_id])
  end

  def guest_index
    render :index
  end
end