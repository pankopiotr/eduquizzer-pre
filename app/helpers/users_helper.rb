# frozen_string_literal: true

module UsersHelper
  def user_alias
    if current_user.first_name.present? && current_user.last_name.present?
      "#{current_user.first_name} #{current_user.last_name}"
    else
      current_user.email
    end
  end

  def authenticated?(remember_token)
    return false if cookie_digest.nil?
    BCrypt::Password.new(cookie_digest).is_password?(remember_token)
  end

  def user_required_params
    params.require(:user).permit(:email, :password)
  end

  def user_optional_params
    params.require(:user).permit(:first_name, :last_name, :student_id)
  end

  def nil_optional_attributes?
    return if current_user.student_id.nil?
    flash[:danger] = t(:completed_optional_once)
    redirect_to interface_path
  end

  def generate_token
    SecureRandom.urlsafe_base64
  end

  def digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end
end
