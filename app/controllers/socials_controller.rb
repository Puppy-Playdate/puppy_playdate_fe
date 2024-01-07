class SocialsController < ApplicationController
  def index;end

  def new;end

  def guest_index
    render :index
  end
end