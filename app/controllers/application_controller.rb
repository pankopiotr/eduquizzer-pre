# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationExtension
  include Session
  helper_method :signed_in?, :current_user
  protect_from_forgery with: :exception
  before_action :set_locale, :signed_in_user?, :admin_user?

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
