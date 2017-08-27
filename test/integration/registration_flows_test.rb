# frozen_string_literal: true

require 'test_helper'

class RegistrationFlowsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end

  test 'complete registration' do
    get register_path
    assert_select 'form label', 2
    post '/register', params: { user: { email: 'john.newman@example.com',
                                        password: 'password12' } }
    refute in_session?
    assert_equal 1, ActionMailer::Base.deliveries.size
    ## Find a better way to read activation token
    ## assigns has been depreciated
    ## instance_variable_get returns nil
    user = assigns(:user)
    # Try to signin without activation
    post '/signin', params: { session: { email: 'john.newman@example.com',
                                         password: 'password12' } }
    refute in_session?
    # Activate user
    get edit_account_activation_path(activation_token: user.activation_token,
                                     email: user.email)
    assert in_session?
    assert_redirected_to register_optional_path
    follow_redirect!
    assert_select 'form label', 3
    post '/register_optional', params: { user: { first_name: 'John',
                                                 last_name: 'Newman',
                                                 student_id: '123123' } }
    assert_redirected_to interface_path
  end

  test 'log out after registration and log in again to finish registration' do
    get register_path
    post '/register', params: { user: { email: 'john.newman@example.com',
                                        password: 'password12' } }
    user = assigns(:user)
    get edit_account_activation_path(activation_token: user.activation_token,
                                     email: user.email)
    assert_redirected_to register_optional_path
    assert in_session?
    sign_out
    assert_not in_session?
    get signin_path
    post '/signin', params: { session: { email: 'john.newman@example.com',
                                         password: 'password12' } }
    assert in_session?
    get register_optional_path
    assert_response :success
    post '/register_optional', params: { user: { first_name: 'John',
                                                 last_name: 'Newman',
                                                 student_id: '123123' } }
    assert_not_nil User.find_by(student_id: '123123')
    assert_redirected_to interface_path
  end
end
