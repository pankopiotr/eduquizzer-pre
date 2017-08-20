# frozen_string_literal: true

module UsersHelper
  def user_alias
    if current_user.first_name.present? && current_user.last_name.present?
      "#{current_user.first_name} #{current_user.last_name}"
    else
      current_user.email
    end
  end
end
