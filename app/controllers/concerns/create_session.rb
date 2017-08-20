# frozen_string_literal: true

module CreateSession
  extend ActiveSupport::Concern

  private

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
end