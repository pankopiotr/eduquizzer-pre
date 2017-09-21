# frozen_string_literal: true

class UsersController < ApplicationController
  include GenerateDigest
  before_action :nil_optional_attributes?, only: %i[new_optional
                                                    create_optional]
  skip_before_action :signed_in_user?, only: %i[new create]
  skip_before_action :admin_user?

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_required_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      redirect_to root_url, flash: { info: t(:please_check_email) }
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
      redirect_to interface_path, flash: { success: t(:full_registration_completed) }
    else
      render 'new_optional'
    end
  end

  def show
  end

  private

    def user_required_params
      params.require(:user).permit(:email, :password)
    end

    def user_optional_params
      params.require(:user).permit(:first_name, :last_name, :student_id)
    end

    def nil_optional_attributes?
      return if current_user.student_id.nil?
      redirect_to interface_path, flash: { danger: t(:completed_optional_once) }
    end
end
