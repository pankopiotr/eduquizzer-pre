# frozen_literal_string: true

require 'test_helper'

class AccountActivationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @inactivated_user = users(:peter)
    @inactivated_user.activation_token = 'token123'
  end

  test 'should not activate user with wrong token' do
    get edit_account_activation_path(activation_token:
                                         'wrong_token',
                                     email: @inactivated_user.email)
    refute User.find_by(email: @inactivated_user.email).activated?
    assert_response :redirect
  end

  test 'should not activate user with wrong email' do
    get edit_account_activation_path(activation_token:
                                         @inactivated_user.activation_token,
                                     email: 'wrong@email.com')
    refute User.find_by(email: @inactivated_user.email).activated?
    assert_response :redirect
  end

  test 'should activate user with valid credentials' do
    get edit_account_activation_path(activation_token:
                                         @inactivated_user.activation_token,
                                     email: @inactivated_user.email)
    assert User.find_by(email: @inactivated_user.email).activated?
    assert_response :redirect
  end
end
