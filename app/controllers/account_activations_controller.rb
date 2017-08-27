# frozen_string_literal: true

class AccountActivationsController < ApplicationController
  include CreateSession
  skip_before_action :signed_in_user?, :admin_user?

  def edit
    @user = User.find_by(email: params[:email])
    if @user && !@user.activated? && correct_token?(params[:activation_token])
      @user.update_attribute(:activated, true)
      sign_in @user
      remember @user
      flash[:success] = t(:account_activated)
      redirect_to register_optional_path
    else
      flash[:danger] = t(:activation_failure)
      redirect_to root_url
    end
  end

  private

    def correct_token?(token)
      @token = BCrypt::Password.new(@user.activation_digest)
      @token == token
    end
end
