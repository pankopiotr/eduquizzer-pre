# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: 'johndoe@domain.com', password: 'password12',
                     first_name: 'John', last_name: 'Doe',
                     student_id: '112233')
  end

  # Presence validation
  test 'should validate user' do
    assert @user.valid?
  end

  test 'should not validate empty email' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'should not validate blank password' do
    @user.password = '     '
    assert_not @user.valid?
  end

  test 'should validate blank first name' do
    @user.first_name = ''
    assert @user.valid?
  end

  test 'should validate blank last name' do
    @user.last_name = ''
    assert @user.valid?
  end

  test 'should validate blank student id' do
    @user.student_id = ''
    assert @user.valid?
  end

  # Length validation
  test 'should not validate too long email' do
    @user.password = 'a' * 65
    assert_not @user.valid?
  end

  test 'should not validate too long password' do
    @user.password = 'a' * 65
    assert_not @user.valid?
  end

  test 'should not validate too short password' do
    @user.password = 'a' * 7
    assert_not @user.valid?
  end

  test 'should not validate too long first name' do
    @user.first_name = 'a' * 17
    assert_not @user.valid?
  end

  test 'should not validate too short first name' do
    @user.first_name = 'a'
    assert_not @user.valid?
  end

  test 'should not validate too long last name' do
    @user.last_name = 'a' * 33
    assert_not @user.valid?
  end

  test 'should not validate too short last name' do
    @user.last_name = 'a'
    assert_not @user.valid?
  end

  test 'should not validate too long student id' do
    @user.student_id = '1234567'
    assert_not @user.valid?
  end

  test 'should not validate too short student id' do
    @user.student_id = '1234'
    assert_not @user.valid?
  end

  # Email format validation
  test 'should not validate email with wrong format' do
    @user.email = 'john.doe@domain'
    assert_not @user.valid?
  end

  test 'should validate email with special characters in local address' do
    @user.email = 'john.doe@domain.com'
    assert @user.valid?
  end

  test 'should not validate email with special characters in domain' do
    @user.email = 'john.doe@dom_ain.com'
    assert_not @user.valid?
  end

  # Numeric-only validation
  test 'should not validate student id with non-numeric characters' do
    @user.student_id = 'ab123c'
    assert_not @user.valid?
  end

  # Uniqueness validation
  test 'should not validate duplicated email' do
    @copycat_user = @user.dup
    @user.save
    assert_not @copycat_user.valid?
  end
end
