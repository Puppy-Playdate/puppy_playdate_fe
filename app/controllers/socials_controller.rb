class SocialsController < ApplicationController
  def index
    @socials = SocialsFacade.find_socials(current_user)
  end

  def new;end

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
    @social = SocialsFacade.find_social(params[:user_id], params[:id])
    @host = UsersFacade.find_user(params[:user_id])
  end

  def guest_index
    render :index
  end

  def edit
    @user = UsersFacade.find_user(params[:user_id].to_i)
    @social = SocialsFacade.find_social(@user.user_id, params[:id].to_i)
  end

  def update
    @social = SocialsFacade.find_social(current_user, params[:id])
    if social_update_params
      response = SocialsFacade.update_social(social_update_params)
      if response[:status] == 200
        redirect_to user_social_path(current_user, response[:id])
      else
        flash[:error] = response[:error].join(', ')
        redirect_back(fallback_location: edit_user_social_path(current_user, @social.id))
      end
    else
      flash[:error] = response[:error].join(', ')
      redirect_back(fallback_location: edit_user_social_path(current_user, @social.id))
    end
  end

  private

  def social_update_params
    params.permit(:name, :description, :event_type, :location, :event_date, :user_id, :id)
  end
end