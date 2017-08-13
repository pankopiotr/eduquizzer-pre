class UsersController < ApplicationController
  include UsersHelper

  before_action :nil_optional_attributes?, only: %i[new_optional create_optional]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_required_params)
    if @user.save
      helpers.sign_in @user
      helpers.remember @user
      render 'new_optional'
    else
      render 'new'
    end
  end

  def new_optional
    @user = User.new
  end

  def create_optional
    @user = User.find_by(id: session[:user_id])
    if @user.update_attributes(user_optional_params)
      @user.update_attributes(active: true)
      # Change to user path when user interface is done
      redirect_to root_path
    else
      render 'new_optional'
    end
  end

  def show
  end
end
