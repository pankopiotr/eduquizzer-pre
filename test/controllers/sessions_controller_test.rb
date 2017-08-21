# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:john)
    @other_user = users(:jane)
    @inactive_user = users(:bob)
  end

  test 'should get new' do
    get signin_path
    assert_response :success
  end

  test 'should sign in user with valid information' do
    get signin_path
    sign_in_as@user
    assert flash[:danger].nil?
    assert in_session?
    assert_response :redirect
  end

  test 'should not sign in user with invalid email' do
    get signin_path
    @user.email = 'doesnotexist@example.com'
    @url = current_url
    sign_in_as@user
    refute in_session?
    refute flash[:danger].nil?
    assert_equal current_url, @url
  end

  test 'should not sign user with invalid password' do
    get signin_path
    @url = current_url
    post '/signin', params: { session: { email: @user.email,
                                         password: '' } }
    refute in_session?
    refute flash[:danger].nil?
    assert_equal current_url, @url
  end

  test 'should not sign in inactive user' do
    get signin_path
    @url = current_url
    sign_in_as@inactive_user
    refute in_session?
    refute flash[:danger].nil?
    assert_equal current_url, @url
  end

  test 'should sign out user' do
    get signin_path
    sign_in_as@user
    assert in_session?
    sign_out
    assert_not in_session?
    assert_redirected_to root_path
  end
end
