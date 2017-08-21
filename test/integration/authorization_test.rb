# frozen_string_literal: true

require 'test_helper'

class AuthorizationTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:john)
    @user = users(:jane)
  end

  test 'should not let guest user access any interface' do
    get interface_path
    assert_redirected_to root_path
    follow_redirect!
    assert_select 'div.alert-danger', count: 1
  end

  test 'should let user access user interface' do
    sign_in_as @user
    get interface_path
    assert_response :success
  end

  test 'should let admin user access admin interface' do
    sign_in_as@admin
    get new_task_path
    assert_response :success
  end

  test 'should not let normal user access admin interface' do
    sign_in_as@user
    get new_task_path
    assert_redirected_to root_path
    follow_redirect!
    assert_select 'div.alert-danger', count: 1
  end
end
