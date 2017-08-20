# frozen_string_literal: true

class SessionsController < ApplicationController
  include SessionsHelper
  before_action :find_user, only: :create

  def new
  end

  def create
    if @user&.active && authenticate(params[:session][:password])
      sign_in @user
      remember @user
      redirect_to interface_path
    else
      flash.now[:danger] = t(:wrong_credentials)
      render 'new'
    end
  end

  def destroy
    sign_out if signed_in?
    redirect_to root_path
  end

  private

    def authenticate(password)
      @password = BCrypt::Password.new(@user.password_digest)
      @password == password
    end

    def find_user
      @user = User.find_by(email: params[:session][:email])
    end

    def sign_out
      forget(current_user)
      session.delete(:user_id)
      @current_user = nil
    end

    def forget(user)
      user.forget
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
    end
end
