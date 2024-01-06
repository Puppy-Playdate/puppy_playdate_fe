class Users::DogsController < ApplicationController
  def index
    @dogs = Dog.all
  end
end