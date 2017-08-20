# frozen_string_literal: true

module UsersHelper
  def user_alias
    if current_user.first_name.present? && current_user.last_name.present?
      "#{current_user.first_name} #{current_user.last_name}"
    else
      current_user.email
    end
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
