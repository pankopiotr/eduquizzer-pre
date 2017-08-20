# frozen_string_literal: true

require 'test_helper'

class AuthorizationTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:john)
    @other_user = users(:jane)
    @inactive_user = users(:bob)
  end

  test 'should not let register if user is signed in' do
    get signin_path
    sign_in_as(@user)
    assert_redirected_to interface_path
    get register_path
    post '/register', params: { user: { email: 'john.newman@example.com',
                                        password: 'password12' } }
    assert_nil User.find_by(email: 'john.newman@example.com')
    assert_select 'div.alert-danger', '1'
  end

  test 'should not let signed out user access any interface' do
    get interface_path
    assert_redirected_to root_path
    assert_select 'div.alert-danger', '1'
  end

  test 'should not let normal user access admin interface' do
    get new_task_path
    assert_redirected_to root_path
    assert_select 'div.alert-danger', '1'
  end
end
