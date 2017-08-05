require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get registration page' do
    get register_path
    assert_response :success
  end

  test 'should get optional registration page' do
    get register_path
    post '/register', params: { user: { email: 'john.newman@example.com',
                                        password: 'password12' } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_template 'new_optional'
  end

  test 'should create user' do
    get register_path
    post '/register', params: { user: { email: 'john.newman@example.com',
                                        password: 'password12' } }
    follow_redirect!
    post '/register', params: { user: { first_name: 'john', last_name: 'Newman',
                                        student_id: '123123' } }
    assert_not_nil User.find_by(student_id: '123123')
  end
end
