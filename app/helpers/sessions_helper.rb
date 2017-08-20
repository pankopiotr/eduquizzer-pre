# frozen_string_literal: true

module SessionsHelper

  def optional_registration?
    current_user.first_name.nil?
  end

  # Methods below have to be moved to concerns
  # as they are used in multiple controllers

  def signed_in?
    !current_user.nil?
  end
end
