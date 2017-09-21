# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  skip_before_action :signed_in_user?, :admin_user?
  before_action :find_user, :valid_user, :check_expiration, only: %i[edit update]

  def new
  end

  def create
    if (@user = User.find_by(email: params[:password_reset][:email].downcase))
      @user.create_reset_digest
      @user.send_password_reset_email
      redirect_to root_url, flash: { info: t(:password_reset_sent) }
    else
      flash.now[:danger] = t(:email_not_found)
      render 'new'
    end
  end

  def edit
  end

  def update
    @user.updating_password = true
    if @user.update_attributes(user_params)
      @user.clear_password_reset
      complete_sign_in(@user, interface_path, t(:password_successfully_reset))
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:password)
    end

    def find_user
      @user = User.find_by(email: params[:email])
    end

    def valid_user
      return if @user&.activated? && @user.active &&
                password_recovered?(params[:reset_token])
      redirect_to root_url, flash: { danger: t(:invalid_or_inactive_user) }
    end

    def password_recovered?(token)
      @token = BCrypt::Password.new(@user.reset_digest)
      @token == token
    end

    def check_expiration
      return unless @user.password_reset_expired?
      redirect_to root_url, flash: { danger: t(:reset_link_expired) }
    end
end
