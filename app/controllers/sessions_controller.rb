# frozen_string_literal: true

class SessionsController < ApplicationController
  include SessionExtension
  include CreateSession
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
end
