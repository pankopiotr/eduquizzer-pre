# frozen_string_literal: true

require 'test_helper'

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:josh)
    @user.reset_token = 'reset123'
  end

  test 'should get new' do
    get new_password_reset_url
    assert_response :success
  end

  test 'should get edit with correct parameters' do
    get edit_password_reset_url(reset_token: @user.reset_token,
                                email: @user.email)
    assert_response :success
  end

  test 'should not get edit with wrong token' do
    @user.update_attribute(:activated, false)
    get edit_password_reset_url(reset_token: 'wrong_token', email: @user.email)
    assert_redirected_to root_url
  end

  test 'should not get edit with wrong email' do
    get edit_password_reset_url(reset_token: @user.reset_token, email: '')
    assert_redirected_to root_url
  end

  test 'should redirect if link life has expired' do
    @user.update_attribute(:reset_at, 2.hours.ago)
    get edit_password_reset_url(reset_token: @user.reset_token,
                                email: @user.email)
    assert_redirected_to root_url
  end

  test 'should redirect if user already changed password' do
    @user.update_attribute(:updated_at, @user.updated_at + 5.minutes)
    get edit_password_reset_url(reset_token: @user.reset_token,
                                email: @user.email)
    assert_redirected_to root_url
  end

  test 'should not redirected if user was deleted' do
    @user.update_attribute(:active, false)
    get edit_password_reset_url(reset_token: @user.reset_token,
                                email: @user.email)
    assert_redirected_to root_url
  end

  test 'should redirect if user was not activated' do
    @user.update_attribute(:activated, false)
    get edit_password_reset_url(reset_token: @user.reset_token,
                                email: @user.email)
    assert_redirected_to root_url
  end

  test 'should throw error when requesting recover with empty email' do
    get new_password_reset_path
    assert_template 'password_resets/new'
    # Invalid email
    post password_resets_path, params: { password_reset: { email: '' } }
    refute flash.empty?
    assert_equal 0, ActionMailer::Base.deliveries.size
  end

  test 'should successfully change password' do
    get new_password_reset_path
    post password_resets_path,
         params: { password_reset: { email: @user.email } }
    user = assigns(:user)
    assert_equal 1, ActionMailer::Base.deliveries.size
    get edit_password_reset_url(reset_token: user.reset_token,
                                email: @user.email)
    assert_response :success
    assert_select 'input[name=email][type=hidden][value=?]', @user.email
    patch password_reset_path(user.reset_token),
          params: { email: @user.email,
                    user: { password: 'new_password' } }
    assert in_session?
    assert_nil @user.reload.reset_digest
    assert_response :redirect
  end
end