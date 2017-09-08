# frozen_string_literal: true

require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  include GenerateDigest

  def setup
    @user = users(:john)
  end

  test 'account_activation' do
    @user.activation_token = generate_token
    mail = UserMailer.account_activation(@user)
    assert_equal 'Account activation', mail.subject
    assert_equal [@user.email], mail.to
    assert_equal ['from@example.com'], mail.from
    assert_match @user.email, mail.body.encoded
    assert_match @user.activation_token, mail.body.encoded
    assert_match CGI.escape(@user.email), mail.body.encoded
  end

  test 'password_reset' do
    @user.reset_token = generate_token
    mail = UserMailer.password_reset(@user)
    assert_equal 'Password reset', mail.subject
    assert_equal [@user.email], mail.to
    assert_equal ['from@example.com'], mail.from
    assert_match @user.reset_token,        mail.body.encoded
    assert_match CGI.escape(@user.email),  mail.body.encoded
  end
end
