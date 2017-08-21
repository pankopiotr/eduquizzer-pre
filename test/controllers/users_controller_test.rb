# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get registration page' do
    get register_path
    assert_response :success
  end

  test 'should register user' do
    get register_path
    post '/register', params: { user: { email: 'john.newman@example.com',
                                        password: 'password12' } }
    assert_not_nil User.find_by(email: 'john.newman@example.com')
  end

  test 'should update user with optional data' do
    get register_path
    post '/register', params: { user: { email: 'john.newman@example.com',
                                        password: 'password12' } }
    assert_select 'form label', 3
    post '/register_optional', params: { user: { first_name: 'john',
                                                 last_name: 'Newman',
                                                 student_id: '123123' } }
    assert_not_nil User.find_by(student_id: '123123')
    assert_response :redirect
  end

  test 'should skip optional registration' do
    get register_path
    post '/register', params: { user: { email: 'john.newman@example.com',
                                        password: 'password12' } }
    assert_select 'form label', 3
    assert_nil User.find_by(email: 'john.newman@example.com').student_id
    post '/register_optional', params: { user: { first_name: '',
                                                 last_name: '',
                                                 student_id: '' } }
    assert_equal '', User.find_by(email: 'john.newman@example.com').student_id
    assert_response :redirect
  end

  test 'should continue optional registration if first time' do
    get register_path
    post '/register', params: { user: { email: 'john.newman@example.com',
                                        password: 'password12' } }
    get register_path
    assert_response :success
    get register_optional_path
    assert_response :success
  end

  test 'should prevent optional registration if done it already' do
    get register_path
    post '/register', params: { user: { email: 'john.newman@example.com',
                                        password: 'password12' } }
    post '/register_optional', params: { user: { first_name: '',
                                                 last_name: '',
                                                 student_id: '' } }
    get register_optional_path
    assert_response :redirect
  end
end
