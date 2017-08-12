class SessionsController < ApplicationController
  include SessionsHelper

  def new
  end

  def create
    if (@user = User.find_by(email: params[:session][:email]))
      @password = BCrypt::Password.new(@user.password_digest)
    end
    if session[:user_id].nil?
      if @user&.active && @password == params[:session][:password]
        sign_in @user
        remember @user
        # Change to user path when user interface is done
        redirect_to root_path
      else
        flash.now[:danger] = t(:wrong_credentials)
        render 'new'
      end
    else
      flash[:danger] = t(:already_signed_in)
      # Change to user path when user interface is done
      redirect_to root_path
    end
  end

  def destroy
    sign_out if signed_in?
    redirect_to root_path
  end
end
