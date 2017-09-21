# frozen_string_literal: true

class AccountActivationsController < ApplicationController
  skip_before_action :signed_in_user?, :admin_user?
  before_action :find_user

  def edit
    if @user && !@user.activated? && correct_token?(params[:activation_token])
      @user.activate
      complete_sign_in(@user, register_optional_path,
                       t(:account_activated))
    else
      redirect_to root_url, flash: { danger: t(:activation_failure) }
    end
  end

  private

    def find_user
      @user = User.find_by(email: params[:email])
    end

    def correct_token?(token)
      @token = BCrypt::Password.new(@user.activation_digest)
      @token == token
    end
end
