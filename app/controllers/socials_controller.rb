class SocialsController < ApplicationController
  def index
    @socials = SocialsFacade.find_socials(current_user)
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

  def edit
    @user = UsersFacade.find_user(params[:user_id].to_i)
    @socials_facade = SocialsFacade.find_social(@user.user_id, params[:id])
  end

  def update
    if required_fields_present?
      response = SocialsFacade.update_social(params[:name], params[:description], params[:event_type], params[:addressLines], params[:locality], params[:datetime] @user.user_id, @socials_facade.social_id)
      # require 'pry'; binding.pry
      if response[:status] == 200
        redirect_to user_social_path(@user.user_id, @social.socia_id)
      else
        flash[:error] = "**NO FIELDS CAN BE LEFT BLANK.**"
        redirect_back(fallback_location: edit_user_social_path(@user.user_id, @socials_facade.social_id))
      end
    else
      flash[:error] = "**NO FIELDS CAN BE LEFT BLANK.**"
      redirect_back(fallback_location: edit_user_social_path(@user.user_id, @socials_facade.social_id))
    end
  end

  private

  def required_fields_present?
    required_params = [:name, :description, :event_type, :locality, :addressLines, :datetime, :user_id]
    required_params.all? { |param| params[param].present? }
  end
end