# frozen_string_literal: true

module SessionExtension
  extend ActiveSupport::Concern

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