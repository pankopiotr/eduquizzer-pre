# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:jane)
    @incomplete_user = users(:josh)
  end

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
    sign_in_as @incomplete_user
    get register_optional_path
    assert_response :success
    assert_select 'form label', 3
    post '/register_optional', params: { user: { first_name: 'john',
                                                 last_name: 'Newman',
                                                 student_id: '123123' } }
    assert_not_nil User.find_by(student_id: '123123')
    assert_response :redirect
  end

  test 'should update empty attributes on optional registration' do
    sign_in_as @incomplete_user
    get register_optional_path
    assert_response :success
    assert_select 'form label', 3
    post '/register_optional', params: { user: { first_name: '',
                                                 last_name: '',
                                                 student_id: '' } }
    assert_equal '', @incomplete_user.reload.student_id
    assert_response :redirect
  end

  test 'should prevent optional registration if done it already' do
    sign_in_as @user
    get register_optional_path
    assert_response :redirect
  end
end
