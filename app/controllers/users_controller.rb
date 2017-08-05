class UsersController < ApplicationController
  include UsersHelper

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_required_params)
    if @user.save
      # Log user in
    else
      render 'new'
    end
  end

  def create_optional
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(user_optional_params)
      redirect_to '#'
    else
      render 'new_optional'
    end
  end
end
