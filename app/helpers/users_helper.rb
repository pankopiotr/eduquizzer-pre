# frozen_string_literal: true

module UsersHelper
  def user_alias(user)
    if user.student_id.present?
      user.student_id
    elsif user.last_name.present? && user.first_name.present?
      "#{user.last_name}, #{user.first_name}"
    else
      user.email.split('@')[0]
    end
  end
end