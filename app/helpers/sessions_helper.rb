# frozen_string_literal: true

module SessionsHelper
  def signed_in?
    !current_user.nil?
  end

  def optional_registration?
    current_user.first_name.nil?
  end
end
