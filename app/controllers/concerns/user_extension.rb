# frozen_string_literal: true

module UserExtension
  extend ActiveSupport::Concern

  private

    def user_required_params
      params.require(:user).permit(:email, :password)
    end

    def user_optional_params
      params.require(:user).permit(:first_name, :last_name, :student_id)
    end

    def authenticated?(remember_token)
      return false if cookie_digest.nil?
      BCrypt::Password.new(cookie_digest).is_password?(remember_token)
    end

    def nil_optional_attributes?
      return if current_user.student_id.nil?
      flash[:danger] = t(:completed_optional_once)
      redirect_to interface_path
    end
end