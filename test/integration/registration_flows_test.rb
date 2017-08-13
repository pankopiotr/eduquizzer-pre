# frozen_string_literal: true

require 'test_helper'

class RegistrationFlowsTest < ActionDispatch::IntegrationTest
  test 'complete registration' do
    get register_path
    assert_select 'form label', 2
    post '/register', params: { user: { email: 'john.newman@example.com',
                                        password: 'password12' } }
    assert in_session?
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
    refute_equal 'password12',
                 User.find_by(email: 'john.newman@example.com').password
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
