# frozen_string_literal: true

require 'test_helper'

class AuthorizationTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:john)
    @other_user = users(:jane)
    @inactive_user = users(:bob)
  end

  test 'should not let guest user access any interface' do
    get interface_path
    assert_redirected_to root_path
    follow_redirect!
    assert_select 'div.alert-danger', count: 1
  end

  test 'should not let normal user access admin interface' do
    sign_in_as@user
    get new_task_path
    assert_redirected_to root_path
    follow_redirect!
    assert_select 'div.alert-danger', count: 1
  end
end
