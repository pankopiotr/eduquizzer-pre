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
    flunk('Require login implementation to work')
    # Should fail
    # Will redirect user to second step after login (which is not implemented yet)
    get register_path
    post '/register', params: { user: { email: 'john.newman@example.com',
                                        password: 'password12' } }
    assert_select 'form label', 3
    post '/register', params: { user: { first_name: 'john', last_name: 'Newman',
                                        student_id: '123123' } }
    assert_not_nil User.find_by(student_id: '123123')
    assert_response :redirect
  end
end
