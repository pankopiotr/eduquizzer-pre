class SessionsController < ApplicationController
  include SessionsHelper

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if session.empty?
      if user&.active && user.password == params[:session][:password]
        sign_in user
        remember user
        # Change to user path when user interface is done
        redirect_to root_path
      else
        flash.now[:error] = t(:wrong_credentials)
        render 'new'
      end
    else
      flash.now[:error] = t(:already_signed_in)
      # Change to user path when user interface is done
      redirect_to root_path
    end
  end

  def destroy
    sign_out if signed_in?
    redirect_to root_path
  end
end
