require 'test_helper'

class TasksControlerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_task_path
    assert_response :success
  end
end
