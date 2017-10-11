# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :signed_in?, :current_user, :editable?
  protect_from_forgery with: :exception
  before_action :set_locale, :signed_in_user?, :admin_user?

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        sign_in user
        @current_user = user
      end
    end
  end

  def editable?(item)
    !item.used && !item.archived
  end

  private

    def signed_in_user?
      return if signed_in?
      redirect_to root_url, flash: { danger: t(:signin_first) }
    end

    def admin_user?
      return if current_user&.admin?
      redirect_to root_url, flash: { danger: t(:access_denied) }
    end

    def sign_in(user)
      if user.active
        session[:user_id] = user.id
      else
        flash[:error] = t(:wrong_credentials)
      end
    end

    def remember(user)
      user.remember
      cookies.permanent.signed[:user_id] = user.id
      cookies.permanent[:remember_token] = user.remember_token
    end

    # Isn't that too much?
    def complete_sign_in(user, redirect_path, message = nil)
      sign_in user
      remember user
      flash[:success] = message unless message.nil?
      redirect_to redirect_path
    end
end
