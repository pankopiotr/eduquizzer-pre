# frozen_string_literal: true

class UsersController < ApplicationController
  include UserExtension
  include CreateSession
  include GenerateDigest
  before_action :nil_optional_attributes?, only: %i[new_optional
                                                    create_optional]
  skip_before_action :signed_in_user?, :correct_user?, only: %i[new create]
  skip_before_action :admin_user?

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_required_params)
    if @user.save
      sign_in @user
      remember @user
      flash.now[:success] = t(:account_created)
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
      flash[:success] = t(:full_registration_completed)
      redirect_to interface_path
    else
      render 'new_optional'
    end
  end

  def show
  end
end
