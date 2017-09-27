# frozen_string_literal: true

module SessionsHelper
  def optional_registration?
    current_user.first_name.nil?
  end
end